//
//  MainFlowModuleRouter.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

protocol MainFlowModuleRouterInput: AnyObject {
    func showInitialScreen(from window: UIWindow?)
    func showSportsListScreen()
    func showSportEventsList(sport: Sport)
}

protocol MainFlowRouterOutput: AnyObject {
    func statusScreenFinished()
    func selectedSport(_ sport: Sport)
}

final class MainFlowModuleRouter {

    private var statusScreenBuilder: StatusScreenBuildable
    private var sportsListBuilder: SportsListBuildable
    private var sportEventsListBuilder: SportEventsListBuildable

    private let mainNavigationController: UINavigationController

    weak var output: MainFlowRouterOutput?

    init(statusScreenBuilder: StatusScreenBuildable, 
         sportsListBuilder: SportsListBuildable,
         sportEventsListBuilder: SportEventsListBuildable,
         mainNavigationController: UINavigationController,
         output: MainFlowRouterOutput? = nil) {
        self.statusScreenBuilder = statusScreenBuilder
        self.sportsListBuilder = sportsListBuilder
        self.sportEventsListBuilder = sportEventsListBuilder
        self.mainNavigationController = mainNavigationController
        self.output = output
    }
}

// MARK: - MainFlowModuleInput

extension MainFlowModuleRouter: MainFlowModuleRouterInput {
    func showInitialScreen(from window: UIWindow?) {
        let statusScreenViewController = statusScreenBuilder.build(handler: { [weak output] in
            output?.statusScreenFinished()
        })

        mainNavigationController.viewControllers = [statusScreenViewController]
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
    }

    func showSportsListScreen() {
        let sportsListViewController = sportsListBuilder.build { [weak output] result in
            switch result {
            case .sportSelected(let sport):
                output?.selectedSport(sport)
            }
        }

        mainNavigationController.viewControllers = [sportsListViewController]

    }

    func showSportEventsList(sport: Sport) {
        let sportEventsListViewController = sportEventsListBuilder.build(sport: sport)
        mainNavigationController.pushViewController(sportEventsListViewController, animated: true)
    }
}
