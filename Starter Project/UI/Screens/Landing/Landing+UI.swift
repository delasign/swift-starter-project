//
//  CustomUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
import TinyConstraints

extension Landing {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        self.setupImageView()
        self.setupLabel()
        self.setupStartButton()
        self.setupVisitOurBlogButton()
    }

    // MARK: UI Setup Functionality
    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.logo)
            self.logo.centerInSuperview(offset: CGPoint(x: 0, y: -56))
            self.logo.width(162)
            self.logo.height(162)
        }
    }

    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.tutorialLabel)
            self.tutorialLabel.centerX(to: self)
            self.tutorialLabel.topToBottom(of: self.logo, offset: kPadding)
        }
    }

    private func setupStartButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.startButton)
            self.startButton.centerX(to: self)
            self.startButton.bottom(to: self, offset: -kPadding)
            self.startButton.left(to: self, offset: kPadding)
            self.startButton.right(to: self, offset: -kPadding)

            self.startButton.onRelease = { [unowned self] in
                debugPrint("\(Landing.identifier) Start Button on Release  \(DebuggingIdentifiers.actionOrEventSucceded) Updated Experience State to Offering.")
                NotificationCenter.default.post(name: SystemNotifications.updateExperienceState, object: nil, userInfo: [kExperienceStateUserInfo: ExperienceStates.offering])
            }

        }
    }

    private func setupVisitOurBlogButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.visitOurBlogButton)
            self.visitOurBlogButton.centerX(to: self)
            self.visitOurBlogButton.bottomToTop(of: self.startButton, offset: -kPadding)
            self.visitOurBlogButton.left(to: self, offset: kPadding)
            self.visitOurBlogButton.right(to: self, offset: -kPadding)

            self.visitOurBlogButton.onRelease = { [weak self] in
                guard let self = self else { return}
                debugPrint("\(Landing.identifier) Visit our Blog Button on Release  \(DebuggingIdentifiers.actionOrEventSucceded) Opening delasign Blog")
                if let url = URL(string: kdelasignBlogURL) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }

}
