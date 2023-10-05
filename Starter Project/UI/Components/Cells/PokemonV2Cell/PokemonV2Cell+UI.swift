//
//  PokemonV2Cell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension PokemonV2Cell {
    func setupUI() {
        setupHeader()
        setupType()
        setupHeight()
        setupWeight()
    }

    private func setupHeader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.header)
            self.header.left(to: self)
            self.header.top(to: self)
        }
    }

    private func setupType() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.type)
            self.type.left(to: self)
            self.type.topToBottom(of: self.header)
        }
    }

    private func setupHeight() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.height)
            self.height.left(to: self)
            self.height.topToBottom(of: self.type)
        }
    }

    private func setupWeight() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.weight)
            self.weight.left(to: self)
            self.weight.topToBottom(of: self.weight)
        }
    }
}
