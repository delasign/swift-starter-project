//
//  CustomUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
import TinyConstraints

extension CustomUIView {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupButton()
            self.setupLabel()
            self.setupCollectionView()
        }
    }

    // MARK: UI Setup Functionality

    private func setupButton() {
        addSubview(button)
        button.right(to: self, offset: -kPadding)
        button.top(to: self, offset: kPadding)

        button.onRelease = { [weak self] in
            guard let self = self else { return }
            let result = DataCoordinator.shared.addANewObject(
                id: self.randomString(length: 6),
                number: DataCoordinator.shared.sampleSwiftDataModels.count,
                boolean: false
            )
            switch result {
            case .success(let data):
                debugPrint("Succesfully created model : \(data)")
                break
            case .failure(let error):
                debugPrint("Failed to create model : \(error)")
                break
            }
        }
    }

    private func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

    private func setupLabel() {
        guard let content = LanguageCoordinator.shared.currentContent else { return }
        // For more information about Language Content, consult the guide linked below:
        // https://delasign.com/blog/localize-apps-swift/
        label.attributedText = Styleguide.attributedText(text: content.exercise.header)
        addSubview(self.label)
        label.centerY(to: button)
        label.left(to: self, offset: kPadding)
        label.rightToLeft(of: button, offset: -kPadding)
    }

    private func setupCollectionView() {
        // Add the UICollectionView to the View
        addSubview(self.collectionView)
        // Setup the constraints
        collectionView.topToBottom(of: button, offset: kPadding)
        collectionView.left(to: self, offset: kPadding)
        collectionView.right(to: self, offset: -kPadding)
        collectionView.bottom(to: self, offset: -kPadding)
        // Register the cells
         self.collectionView.register(SampleSwiftDataCell.self, forCellWithReuseIdentifier: SampleSwiftDataCell.identifier)
        // Set the delegate & datasource
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
