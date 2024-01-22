//
//  SportEventsListViewController.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 22.01.24.
//

import UIKit

protocol SportEventsListViewControllerInput: Activable {
    func updateUI(eventDays: [SportEventsListViewController.SportEventDayViewModel])
    func updateScreenTitle(_ screenTitle: String)
}

protocol SportEventsListViewControllerOutput: AnyObject {
    func viewIsReady()
}

final class SportEventsListViewController: UIViewController {
    struct SportEventDayViewModel {
        let dateText: String
        let eventViewModel: [EventView.ViewModel]
    }

    private lazy var tableView: UITableView = .commonTableView(style: .grouped)
    private var eventDays: [SportEventDayViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    var output: SportEventsListViewControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        output?.viewIsReady()
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableViewConstraint)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ofType: GenericTableViewCell<EventView>.self)
        tableView.registerCell(ofType: GenericTableViewCell<EventDateView>.self)
    }
}

// MARK: - UITableViewDataSource

extension SportEventsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        eventDays.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventDays[section].eventViewModel.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let eventDateView = tableView.dequeueCell(ofType: GenericTableViewCell<EventDateView>.self)
        eventDateView.separatorColor = .clear
        eventDateView.insets = Theme.Spacings.standardSectionSpacing
        eventDateView.embeddedView.updateEventDate(eventDays[section].dateText)
        return eventDateView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: GenericTableViewCell<EventView>.self, for: indexPath) else {
            return .init()
        }
        // Configure separators
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        cell.configureSeparators(isFirst: isFirstCell, isLast: isLastCell)

        cell.insets = Theme.Spacings.standardCellHSpacing

        cell.embeddedView.update(with: eventDays[indexPath.section].eventViewModel[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDataSource

extension SportEventsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.numberOfRows(inSection: section) > 0 ? UITableView.automaticDimension : .leastNormalMagnitude
    }
}

// MARK: - SportEventsListViewControllerInput

extension SportEventsListViewController: SportEventsListViewControllerInput {
    func updateUI(eventDays: [SportEventDayViewModel]) {
        self.eventDays = eventDays
    }
    
    func updateScreenTitle(_ screenTitle: String) {
        title = screenTitle
    }
}

// MARK: - Constraint providers

private extension SportEventsListViewController {
    var tableViewConstraint: [NSLayoutConstraint] {
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
}
