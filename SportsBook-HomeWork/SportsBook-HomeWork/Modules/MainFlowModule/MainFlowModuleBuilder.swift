//
//  MainFlowModuleBuilder.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

final class MainFlowModuleBuilder {
    func build() -> MainFlowModuleInput {
        let router = MainFlowModuleRouter()
        let presenter = MainFlowModulePresenter(router: router)

        return presenter
    }
}
