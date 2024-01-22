//
//  String+parseToHomeAndAway.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import Foundation

extension String {
    func parseTeams(using separators: [String] = ["vs", "v"]) -> (home: String, away: String) {

        for separator in separators {
            let components = self.components(separatedBy: separator)
            guard components.count == 2 else { continue }

            let home = components[0].trimmingCharacters(in: .whitespaces)
            let away = components[1].trimmingCharacters(in: .whitespaces)

            return (home: home, away: away)
        }

        debugPrint("The string does not contain two teams")
        return ("unknown name", "unknown name")
    }
}
