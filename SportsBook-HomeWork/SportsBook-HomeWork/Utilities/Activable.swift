//
//  Activable.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 19.01.24.
//

import UIKit

let activityViewTag = (Int.max - 1)

protocol Activable: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
}

extension UIView: Activable {
    @objc func startActivityIndicator() {
        if let existingActivityView = viewWithTag(activityViewTag) {
            existingActivityView.removeFromSuperview()
        }

        let activityView = UIView(frame: bounds)
        var frame: CGRect = activityView.frame
        frame.origin.y -= 50
        frame.size.height += 100
        activityView.frame = frame
        activityView.backgroundColor = UIColor.clear
        activityView.alpha = 0
        activityView.tag = activityViewTag
        addSubview(activityView)
        let spinner = UIActivityIndicatorView(style: .medium)
        activityView.addSubview(spinner)
        spinner.center = activityView.center
        spinner.autoresizingMask = .flexibleTopMargin
        spinner.startAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            activityView.alpha = 1
        })
    }

    @objc func stopActivityIndicator() {
        let activityView = viewWithTag(activityViewTag)

        if let activityView = activityView {
            UIView.animate(withDuration: 0.2, animations: {
                activityView.alpha = 0
            }, completion: { _ in
                activityView.removeFromSuperview()
            })
        }
    }
}

extension Activable where Self: UIViewController {
    func startActivityIndicator() {
        view.startActivityIndicator()
    }

    func stopActivityIndicator() {
        view.stopActivityIndicator()
    }
}
