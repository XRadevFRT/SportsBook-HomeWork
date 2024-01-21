//
//  String+Localized.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import Foundation

extension String {
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
}
