//
//  NetworkClientTests.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 17.01.24.
//

import XCTest
@testable import SportsBook_HomeWork

final class NetworkClientTests: XCTestCase {
    enum Constants {
        static var completionCalledMessage = "Completion called"
        static var expectedFailureButGotSuccessMessage = "Expected failure, but got success"
        static var testURL = "https://api.example.com/endpoint"
        static var testResponseJSON =
            """
                {
                    "someKey": "value"
                }
            """
    }

    private var networkClient: NetworkClient!

    override func setUp() {
        super.setUp()
        MockURLProtocol.register()
        networkClient = NetworkClient()
    }

    override func tearDown() {
        MockURLProtocol.unregister()
        networkClient = nil
        super.tearDown()
    }

    func testBuildURLRequestSuccess() {
        var mockRequest = MockRequest()
        mockRequest.mockParameters = ["key1": "value1", "key2": "value2"]

        // Test
        do {
            let urlRequest = try networkClient.buildURLRequest(from: mockRequest)

            XCTAssertEqual(urlRequest.url, URL(string: Constants.testURL))
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Authorization"], "Bearer yourAccessToken")
            if let httpBody = urlRequest.httpBody {
                let decodedParameters = try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any]
                XCTAssertEqual(decodedParameters?["key1"] as? String, "value1")
                XCTAssertEqual(decodedParameters?["key2"] as? String, "value2")
            } else {
                XCTFail("httpBody is nil")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testBuildURLRequestEncodingFailure() {
        var mockRequest = MockRequest()
        mockRequest.mockParameters = ["invalidJSON": Data()]

        // Test
        do {
            _ = try networkClient.buildURLRequest(from: mockRequest)
            XCTFail("Expected encoding failure, but it succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.encodingFailed)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testPerformRequestSuccess() {
        let url = URL(string: Constants.testURL)!
        MockURLProtocol.mockResponseData = Constants.testResponseJSON.data(using: .utf8)
        let expectation = XCTestExpectation(description: "Completion called")

        // Test
        networkClient.performRequest(with: URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, Constants.testResponseJSON.data(using: .utf8))
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformRequestFailure() {
        let url = URL(string: Constants.testURL)!
        MockURLProtocol.mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.performRequest(with: URLRequest(url: url)) { result in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.requestFailed(statusCode: -1, data: nil))
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testDecodeResponseSuccess() {
        networkClient.decodeResponse(data: Constants.testResponseJSON.data(using: .utf8)!) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.someKey, "value")
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        }
    }

    func testDecodeResponseFailure() {
        let responseData = "Invalid JSON".data(using: .utf8)!

        // Test
        networkClient.decodeResponse(data: responseData) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.decodingFailed)
            }
        }
    }

    func testSendRequestSuccess() {
        MockURLProtocol.mockResponseData = Constants.testResponseJSON.data(using: .utf8)
        let exampleRequest = MockRequest()
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.sendRequest(exampleRequest) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.someKey, "value")
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSendRequestInvalidURL() {
        var invalidRequest = MockRequest()
        invalidRequest.mockBaseURL = URL(string: "123")
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.sendRequest(invalidRequest) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.invalidURL)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSendRequestEncodingFailure() {
        var encodingFailureRequest = MockRequest()
        encodingFailureRequest.mockParameters = ["invalidJSON": Data()]
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.sendRequest(encodingFailureRequest) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.encodingFailed)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSendRequestRequestFailed() {
        let requestFailedRequest = MockRequest()
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.sendRequest(requestFailedRequest) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                if case let .requestFailed(statusCode, data) = error {
                    XCTAssertEqual(statusCode, -1)
                    XCTAssert(data == nil || data!.isEmpty, "Expected data to be nil or empty, but got \(data?.count ?? 0) bytes")
                } else {
                    XCTFail("Unexpected error: \(error)")
                }
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSendRequestUnexpectedResponse() {
        let unexpectedResponseRequest = MockRequest()
        MockURLProtocol.mockResponseData = Data()
        let expectation = XCTestExpectation(description: Constants.completionCalledMessage)

        // Test
        networkClient.sendRequest(unexpectedResponseRequest) { (result: Result<MockDecodableModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail(Constants.expectedFailureButGotSuccessMessage)
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.unexpectedResponse)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
