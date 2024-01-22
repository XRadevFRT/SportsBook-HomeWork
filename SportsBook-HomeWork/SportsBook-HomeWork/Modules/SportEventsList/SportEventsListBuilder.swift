//
//  SportEventsListBuilder.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import UIKit

protocol SportEventsListBuilderDependency {
    var presentingViewController: UIViewController { get }
    var getEventsDataService: GetEventsDataServiceProtocol { get }
}

typealias SportEventsListBuilderCompletionHandler = () -> Void

protocol SportEventsListBuildable: AnyObject {
    func build(sport: Sport) -> UIViewController
}

final class SportEventsListBuilder: SportEventsListBuildable {
    let dependency: SportEventsListBuilderDependency

    init(dependency: SportEventsListBuilderDependency) {
        self.dependency = dependency
    }

    func build(sport: Sport) -> UIViewController {
        let viewController = SportEventsListViewController()
        let interactor = SportEventsListInteractor(getEventsDataService: dependency.getEventsDataService)
        let router = SportEventsListRouter(presentingViewController: dependency.presentingViewController)
        let presenter = SportEventsListPresenter(
            sport: sport,
            view: viewController,
            interactor: interactor,
            router: router)

        viewController.output = presenter
        interactor.output = presenter
        router.output = presenter

        return viewController
    }
}
