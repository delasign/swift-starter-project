//
//  ViewController.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    static let identifier: String = "[ViewController]"
    private let helloWorldDidSucceed: Bool = true
    // MARK: UI
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hello()
        setupCoordinators()
    }

    // MARK: Setup Functionality

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
        LanguageCoordinator.shared.onContentUpdate = { [weak self] in
            guard let _ = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Could not update current content - as current content does not exist.")
                return
            }
            // Carry out your content update functionality here.
            // This can range from refreshing your application or could be used to send a notification to complete specific updates at chosen locations within your application.
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) content sample : \(currentContent.sample)")
        }
    }
}
