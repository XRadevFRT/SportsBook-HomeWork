//
//  MainFlowModulePresenter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit.UIWindow

protocol MainFlowModuleInput {
    func launch(from window: UIWindow?)
}

final class MainFlowModulePresenter {

    let router: MainFlowModuleRouterInput

    init(router: MainFlowModuleRouterInput) {
        self.router = router
    }
}

// MARK: - MainFlowModuleInput

extension MainFlowModulePresenter: MainFlowModuleInput {
    func launch(from window: UIWindow?) {
        router.showInitialScreen(from: window)
    }
}

extension MainFlowModulePresenter: MainFlowRouterOutput {
    func statusScreenFinished() {
        // show sports screen
    }
}
