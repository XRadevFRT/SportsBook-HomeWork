//
//  TapAnimatedView.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 21.01.24.
//

import UIKit

class TapAnimatedView: UIView {
    var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTapAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("TapAnimatedView.init(coder:) has not been implemented")
    }

    func initiateTapAction() {
        animateOnTap()
        onTap?()
    }

    private func addTapAnimation() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTapGesture() {
        initiateTapAction()
    }

    private func animateOnTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}
