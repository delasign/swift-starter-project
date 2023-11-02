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
        let addCell: String
    }

    let sample: Sample
}
