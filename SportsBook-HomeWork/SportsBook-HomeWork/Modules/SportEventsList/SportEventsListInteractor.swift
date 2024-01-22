//
//  SportEventsListInteractor.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import Foundation

protocol SportEventsListInteractorOutput: AnyObject {
    func getSportEventsSuccess(_ result: [EventDay])
    func getSportEventsFailed()

}

protocol SportEventsListInteractorInput: AnyObject {
    func getEventsData(for sportId: Int)
}

final class SportEventsListInteractor {
    private var getEventsDataService: GetEventsDataServiceProtocol

    weak var output: SportEventsListInteractorOutput?

    init(getEventsDataService: GetEventsDataServiceProtocol) {
        self.getEventsDataService = getEventsDataService
    }
}

// MARK: - SportListInteractorInput

extension SportEventsListInteractor: SportEventsListInteractorInput {
    func getEventsData(for sportId: Int) {
        getEventsDataService.getEventsData(sportId: sportId) { [weak output] result in
            switch result {
            case .success(let result):
                output?.getSportEventsSuccess(result.groupEventsByDay())
            case .failure:
                output?.getSportEventsFailed()
            }
        }
    }
}
