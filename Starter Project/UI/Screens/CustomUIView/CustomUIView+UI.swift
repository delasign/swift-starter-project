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
        self.setupLabel()
        self.setupImageView()
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerInSuperview()
        }
    }

    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.imageView)
            self.imageView.topToBottom(of: self.label, offset: 20)
            self.imageView.centerX(to: self)
            self.imageView.width(250)
            self.imageView.height(250)
            // Set the content mode.
            self.imageView.contentMode = .scaleAspectFit
            // Set the background color to red whilst loading
            self.imageView.backgroundColor = .red
            // Create Hosted Image URL - please note the URL is an optional that must be safely unwrapped.
            var imageUrl: URL? = URL(string: "https://www.delasign.com/CDN/seo-images/delasign.jpg")
            // Gather URL
            DispatchQueue.global().async { [weak self] in
                // Make sure that the URL exists via teh guard.
                guard let url = imageUrl else { return }
                // Gather the data from the URL
                if let data = try? Data(contentsOf: url) {
                    // Create an image from the data
                    if let image = UIImage(data: data) {
                        // Set the image.
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
