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

// MARK: - StatusScreenBuilderDependency

extension MainFlowModuleDependencyContainer: StatusScreenBuilderDependency {
    var presentingViewController: UIViewController {
        mainNavigationController
    }
    
    var getStatusService: GetStatusServiceProtocol {
        networkService
    }
}

// MARK: - SportsListBuilderDependency

extension MainFlowModuleDependencyContainer: SportsListBuilderDependency {
    var getSportsListService: GetSportsDataServiceProtocol {
        networkService
    }
}

// MARK: - SportEventsListBuilderDependency

extension MainFlowModuleDependencyContainer: SportEventsListBuilderDependency {
    var getEventsDataService: GetEventsDataServiceProtocol {
        networkService
    }
}


final class MainFlowModuleBuilder {
    func build() -> MainFlowModuleInput {
        let dependencyContainer = MainFlowModuleDependencyContainer(
            mainNavigationController: UINavigationController(),
            networkService: NetworkService())

        let statusScreenBuilder = StatusScreenBuilder(dependancy: dependencyContainer)
        let sportsListBuilder = SportsListBuilder(dependency: dependencyContainer)
        let sportEventsListBuilder = SportEventsListBuilder(dependency: dependencyContainer)

        let router = MainFlowModuleRouter(
            statusScreenBuilder: statusScreenBuilder,
            sportsListBuilder: sportsListBuilder,
            sportEventsListBuilder: sportEventsListBuilder,
            mainNavigationController: dependencyContainer.mainNavigationController)
        
        let presenter = MainFlowModulePresenter(router: router)

        router.output = presenter

        return presenter
    }
}
