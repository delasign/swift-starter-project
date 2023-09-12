//
//  SampleSwiftDataCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/12/23.
//

import Foundation
import UIKit

extension SampleSwiftDataCell {
    func update(data: SampleSwiftDataModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Set the data
            self.data = data
            // Set the Number
            self.number.attributedText = Styleguide.attributedText(text: "\(data.number)")
            self.number.sizeToFit()
            // Set the Id
            self.id.attributedText = Styleguide.attributedText(text: data.id)
            self.id.sizeToFit()
            // Set the FlipSwitch
            self.flipSwitch.isOn = data.boolean
            // Add the Target
            flipSwitch.addTarget(self, action: #selector(self.onFlipSwitchToggle), for: .touchUpInside)
            flipSwitch.thumbTintColor = data.boolean ? Styleguide.getBackgroundColor() : Styleguide.getPrimaryColor()
            // Set the Delete Button Callback
            self.button.onRelease = { [weak self] in
                guard let _ = self else { return }
                debugPrint("\(SampleSwiftDataCell.identifier) Delete item with Id : \(data.id)")
                let result = DataCoordinator.shared.deleteAnObject(id: data.id)
                switch result {
                case .success:
                    debugPrint("Succesfully deleted data : \(data.id)")
                    break
                case .failure(let error):
                    debugPrint("Failed to create model : \(error)")
                    break
                }
            }
        }
    }

    @objc func onFlipSwitchToggle() {
        guard let data = data else { return }
        let result = DataCoordinator.shared.updateObject(id: data.id, boolean: !data.boolean)
        switch result {
        case .success:
            debugPrint("Succesfully updated model : \(data)")
            break
        case .failure:
            debugPrint("Failed to update model : \(data)")
            break
        }
    }
}
