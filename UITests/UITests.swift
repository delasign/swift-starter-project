//
//  UITests.swift
//  UITests
//
//  Created by Oscar de la Hera Gomez on 11/8/24.
//

import XCTest
import Starter_Project

final class UITests: XCTestCase {

    let languageCoordinator: LanguageCoordinator = LanguageCoordinator(isTestEnvironment: true)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        guard let currentContent = languageCoordinator.currentContent else { return XCTFail("No current content")}

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let label = app.staticTexts.allElementsBoundByIndex.filter { $0.label == "\(currentContent.sample.sampleString)" }

        XCTAssertEqual(label.count, 1, "There should be exactly one label whose text is exactly '\(currentContent.sample.sampleString)'")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
