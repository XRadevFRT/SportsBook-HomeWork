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

final class MainFlowModuleRouter {
    private let mainNavigationController: UINavigationController

    init(mainNavigationController: UINavigationController = .init()) {
        self.mainNavigationController = mainNavigationController
    }
}

// MARK: - MainFlowModuleInput

extension MainFlowModuleRouter: MainFlowModuleRouterInput {
    func showInitialScreen(from window: UIWindow?) {
        // Show status module
        let vc = ViewController()
        mainNavigationController.viewControllers = [vc]

        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }
}
