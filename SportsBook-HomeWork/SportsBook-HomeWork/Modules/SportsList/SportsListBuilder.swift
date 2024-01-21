//
//  SportsListBuilder.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

protocol SportsListBuilderDependency {
    var presentingViewController: UIViewController { get }
    var getSportsListService: GetSportsDataServiceProtocol { get }
}

enum SportsListResult {
    case sportSelected(_ sportId: Int)
}

typealias SportsListBuilderCompletionHandler = (SportsListResult) -> Void

protocol SportsListBuildable: AnyObject {
    func build(handler: @escaping SportsListBuilderCompletionHandler) -> UIViewController
}

final class SportsListBuilder: SportsListBuildable {
    let dependency: SportsListBuilderDependency

    init(dependency: SportsListBuilderDependency) {
        self.dependency = dependency
    }

    func build(handler: @escaping SportsListBuilderCompletionHandler) -> UIViewController {
        let viewController = SportsListViewController()
        let interactor = SportsListInteractor(getSportsListService: dependency.getSportsListService)
        let router = SportsListRouter(presentingViewController: dependency.presentingViewController)
        let presenter = SportsListPresenter(view: viewController,
                                            interactor: interactor,
                                            router: router,
                                            completionHandler: handler)

        viewController.output = presenter
        interactor.output = presenter
        router.output = presenter

        return viewController
    }
}
