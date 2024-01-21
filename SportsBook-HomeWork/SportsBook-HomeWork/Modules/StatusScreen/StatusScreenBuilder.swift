//
//  StatusScreenBuilder.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

protocol StatusScreenBuilderDependency {
    var presentingViewController: UIViewController { get }
    var getStatusService: GetStatusServiceProtocol { get }
}

enum StatusScreenResult {
    case statusOK
}

typealias StatusScreenBuilderCompletionHandler = () -> Void

protocol StatusScreenBuildable: AnyObject {
    func build(handler: @escaping StatusScreenBuilderCompletionHandler) -> UIViewController
}

final class StatusScreenBuilder: StatusScreenBuildable {
    let dependancy: StatusScreenBuilderDependency

    init(dependancy: StatusScreenBuilderDependency) {
        self.dependancy = dependancy
    }

    func build(handler: @escaping StatusScreenBuilderCompletionHandler) -> UIViewController {
        let viewController = StatusScreenViewController()
        let interactor = StatusScreenInteractor(getStatusService: dependancy.getStatusService)
        let router = StatusScreenRouter(presentingViewController: dependancy.presentingViewController)
        let presenter = StatusScreenPresenter(view: viewController,
                                              interactor: interactor,
                                              router: router,
                                              completionHandler: handler)

        viewController.output = presenter
        interactor.output = presenter
        router.output = presenter

        return viewController
    }
}
