//
//  MainFlowModuleBuilder.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

final class MainFlowModuleDependencyContainer {
    let mainNavigationController: UINavigationController
    let networkService: NetworkService

    init(mainNavigationController: UINavigationController, 
         networkService: NetworkService) {
        self.mainNavigationController = mainNavigationController
        self.networkService = networkService
    }
}

extension MainFlowModuleDependencyContainer: StatusScreenBuilderDependency {
    var presentingViewController: UIViewController {
        mainNavigationController
    }
    
    var getStatusService: GetStatusServiceProtocol {
        networkService
    }

}

final class MainFlowModuleBuilder {
    func build() -> MainFlowModuleInput {
        let dependencyContainer = MainFlowModuleDependencyContainer(
            mainNavigationController: UINavigationController(),
            networkService: NetworkService())

        let statusScreenBuilder = StatusScreenBuilder(dependancy: dependencyContainer)

        let router = MainFlowModuleRouter(
            statusScreenBuilder: statusScreenBuilder,
            mainNavigationController: dependencyContainer.mainNavigationController)
        let presenter = MainFlowModulePresenter(router: router)

        router.output = presenter

        return presenter
    }
}
