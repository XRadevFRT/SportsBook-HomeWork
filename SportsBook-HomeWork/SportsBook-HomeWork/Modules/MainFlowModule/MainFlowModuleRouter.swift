//
//  MainFlowModuleRouter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

protocol MainFlowModuleRouterInput: AnyObject {
    func showInitialScreen(from window: UIWindow?)
}

protocol MainFlowRouterOutput: AnyObject {
    func statusScreenFinished()
}

final class MainFlowModuleRouter {

    private var statusScreenBuilder: StatusScreenBuilderBuildable

    private let mainNavigationController: UINavigationController

    weak var output: MainFlowRouterOutput?

    init(statusScreenBuilder: StatusScreenBuilderBuildable, 
         mainNavigationController: UINavigationController) {
        self.statusScreenBuilder = statusScreenBuilder
        self.mainNavigationController = mainNavigationController
    }
}

// MARK: - MainFlowModuleInput

extension MainFlowModuleRouter: MainFlowModuleRouterInput {
    func showInitialScreen(from window: UIWindow?) {

        let statusScreenViewController = statusScreenBuilder.build(handler: { [weak self] in
            self?.output?.statusScreenFinished()
        })

        mainNavigationController.viewControllers = [statusScreenViewController]
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }
}
