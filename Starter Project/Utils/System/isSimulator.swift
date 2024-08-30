//
//  isSimulator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/30/24.
//

import Foundation

func isSimulator() -> Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}
