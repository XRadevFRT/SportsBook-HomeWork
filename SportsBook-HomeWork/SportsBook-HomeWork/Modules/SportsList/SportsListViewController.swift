//
//  SportsListViewController.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 20.01.24.
//

import UIKit

protocol SportsListViewControllerInput: Activable {
    func updateUI(sports: [Sport])
}

protocol SportsListViewControllerOutput: AnyObject {
    func viewIsReady()
    func didSelectSport(_ sportId: Int)
}

final class SportsListViewController: UIViewController {
    private lazy var tableView: UITableView = .commonTableView()
    private var sports: [Sport] = [] {
        didSet {
            self.tableView.reloadSections([0], with: .automatic)
        }
    }

    var output: SportsListViewControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "sportListScreenTitle".localized()
        view.backgroundColor = .white

        setupTableView()
        output?.viewIsReady()
    }

    private func setupTableView() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableViewConstraint)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ofType: GenericTableViewCell<BaseSportView>.self)
    }
}

// MARK: - UITableViewDataSource

extension SportsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: GenericTableViewCell<BaseSportView>.self)
        let selectedSport = sports[indexPath.row]

        // Configure separators
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.configureSeparators(isFirst: isFirstCell, isLast: isLastCell)
        cell.separatorHeight = 3

        cell.insets = Theme.Spacings.standardCellHSpacing

        cell.embeddedView.updateTitle(selectedSport.name)
        cell.embeddedView.onPressed = { [weak output] in
            output?.didSelectSport(selectedSport.id)
        }

        return cell
    }
}

// MARK: - SportsListViewControllerInput

extension SportsListViewController: SportsListViewControllerInput {
    func updateUI(sports: [Sport]) {
        self.sports = sports
    }
}

// MARK: - Constraint providers

private extension SportsListViewController {
    var tableViewConstraint: [NSLayoutConstraint] {
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
}
