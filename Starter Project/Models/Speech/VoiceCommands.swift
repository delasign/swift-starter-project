//
//  VoiceCommands.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/3/23.
//

import Foundation
// List out all the commands that you want to listen for.
enum VoiceCommands: String, CaseIterable {
    case helloWorld = "Hello World"
    case stop = "Stop"
    case start = "Start"
    case longCommand = "A very long command"
}
