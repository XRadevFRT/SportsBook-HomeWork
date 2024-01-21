//
//  UITableView+CommonTableView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

extension UITableView {
    static func commonTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }
}

