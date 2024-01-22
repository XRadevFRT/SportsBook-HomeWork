//
//  SceneDelegate.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 17.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var mainFlowModuleInput: MainFlowModuleInput?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        mainFlowModuleInput = MainFlowModuleBuilder().build()
        mainFlowModuleInput?.launch(from: window)

        let backButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        backButtonAppearance.tintColor = UIColor.black
    }
}
