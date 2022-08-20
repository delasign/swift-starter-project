//
//  UIContent.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

struct UIContent: Codable {
    struct Sample: Codable {
        let sampleString: String
        let sectionATitle: String
        let sectionBTitle: String
        let sampleCellTitle: String
        let sampleCellBody: String
    }

    let sample: Sample
}
