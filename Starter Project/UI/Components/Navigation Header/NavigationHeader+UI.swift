//
//  NavigationHeader+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension NavigationHeader {
    func setupUI() {
        self.setupButton()
        self.setupHeader()
    }

    // MARK: UI Setup Functionality
    private func setupButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.button)
            self.button.centerYToSuperview()
            self.button.left(to: self, offset: kPadding)

            self.button.onRelease = { [weak self] in
                guard let self = self else { return }
                switch ViewController.experienceState {
                case .landing:
                    // Do nothing, it cannot be touched in this state.
                    break
                case .offering:
                    NotificationCenter.default.post(name: SystemNotifications.updateExperienceState, object: nil, userInfo: [kExperienceStateUserInfo: ExperienceStates.landing])
                    break
                case .refund:
                    NotificationCenter.default.post(name: SystemNotifications.updateExperienceState, object: nil, userInfo: [kExperienceStateUserInfo: ExperienceStates.offering])
                    break
                }
            }
        }
    }

    private func setupHeader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.header)
            self.header.centerYToSuperview()
            self.header.leftToRight(of: self.button, offset: kPadding)
            self.header.right(to: self, offset: -kPadding)
        }
    }

}
