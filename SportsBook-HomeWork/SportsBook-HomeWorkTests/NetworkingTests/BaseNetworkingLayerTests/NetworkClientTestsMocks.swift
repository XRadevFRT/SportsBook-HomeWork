//
//  NetworkClientTestsMocks.swift
//  SportsBook-HomeWorkTests
//
//  Created by Radoslav Radev  on 17.01.24.
//

import Foundation
@testable import SportsBook_HomeWork

extension NetworkClientTests {
    final class MockURLProtocol: URLProtocol {
        static var mockResponseData: Data?
        static var mockError: Error?

        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            if let data = MockURLProtocol.mockResponseData {
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
            } else if let error = MockURLProtocol.mockError {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() {
            // Nothing to do
        }

        static func register() {
            URLProtocol.registerClass(MockURLProtocol.self)
        }

        static func unregister() {
            MockURLProtocol.mockResponseData = nil
            MockURLProtocol.mockError = nil
            URLProtocol.unregisterClass(MockURLProtocol.self)
        }
    }

    struct MockRequest: NetworkRequestProtocol {
        var mockParameters: [String: Any]?
        var mockBaseURL: URL?

        var baseURL: URL? {
            guard let mockBaseURL = mockBaseURL else {
                return URL(string: "https://api.example.com")!
            }
            return mockBaseURL
        }

        var path: String {
            return "/endpoint"
        }

        var method: HTTPMethod {
            return .get
        }

        var headers: [String: String] {
            return ["Authorization": "Bearer yourAccessToken"]
        }

        var parameters: [String: Any]? {
            guard let mockParameters = mockParameters else {
                return ["someKey": "someValue"]
            }
            return  mockParameters
        }

        var requiresAuthorization: Bool {
            return false
        }
    }

    struct MockDecodableModel: Decodable {
        let someKey: String
        var dateKey: Date?
    }
}
