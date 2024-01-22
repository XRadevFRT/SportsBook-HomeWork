//
//  EventsData.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 18.01.24.
//

import Foundation

struct EventsData: Codable {
    let data: [Event]
}

extension EventsData {
    func groupEventsByDay() -> [EventDay] {
        var eventsByDay: [String: [Event]] = [:]

        for event in data {
            let dateText = event.date.formattedString()
            if eventsByDay[dateText] == nil {
                eventsByDay[dateText] = [event]
            } else {
                eventsByDay[dateText]?.append(event)
            }
        }

        let eventDays: [EventDay] = eventsByDay.map { (dateText, events) in
            return EventDay(dateText: dateText, events: events)
        }

        return eventDays
    }
}
