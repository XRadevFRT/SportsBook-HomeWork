//
//  SportsListInteractor.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import Foundation

protocol SportsListInteractorOutput: AnyObject {
    func getSportsSuccess(_ result: [Sport])
    func getSportsFailed()
}

protocol SportsListInteractorInput: AnyObject {
    func getSportsList()
}

final class SportsListInteractor {
    private var getSportsListService: GetSportsDataServiceProtocol

    weak var output: SportsListInteractorOutput?

    init(getSportsListService: GetSportsDataServiceProtocol) {
        self.getSportsListService = getSportsListService
    }
}

// MARK: - SportListInteractorInput

extension SportsListInteractor: SportsListInteractorInput {
    func getSportsList() {
        getSportsListService.getSportsData { [weak output] result in
            switch result {
            case .success(let result):
                output?.getSportsSuccess(result.sports)
            case .failure:
                output?.getSportsFailed()
            }
        }
    }
}
