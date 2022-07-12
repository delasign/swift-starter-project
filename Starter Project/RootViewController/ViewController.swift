//
//  ViewController.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/11/22.
//

import UIKit

class ViewController: UIViewController {

    static let identifier: String = "[ViewController]"
    private let helloWorldDidSucceed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hello()
        setupCoordinators()
    }

    func hello() {
        switch helloWorldDidSucceed {
        case true:
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Hello World.")
        case false:
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Hello World.")
        }
    }

    func setupCoordinators() {
        LanguageCoordinator.shared.initialize()
    }
}
