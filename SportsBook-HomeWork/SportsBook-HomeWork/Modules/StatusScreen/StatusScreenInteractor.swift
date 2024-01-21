//
//  StatusScreenInteractor.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import Foundation

protocol StatusScreenInteractorOutput: AnyObject {
    func getAPIStatusSuccess(_ result: APIStatus)
    func getAPIStatusFailed()
}

protocol StatusScreenInteractorInput: AnyObject {
    func getAPIStatus()
}

final class StatusScreenInteractor {
    private var getStatusService: GetStatusServiceProtocol

    weak var output: StatusScreenInteractorOutput?

    init(getStatusService: GetStatusServiceProtocol) {
        self.getStatusService = getStatusService
    }
}

// MARK: - StatusScreenInteractorInput

extension StatusScreenInteractor: StatusScreenInteractorInput {
    func getAPIStatus() {
        getStatusService.getStatus { [weak output] result in
            switch result {
            case .success(let result):
                output?.getAPIStatusSuccess(result)
            case .failure:
                output?.getAPIStatusFailed()
            }
        }
    }
}
