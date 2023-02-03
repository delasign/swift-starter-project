//
//  SpeechCoordinator+Commands.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/3/23.
//

import Foundation
import Speech

extension SpeechCoordinator {
    public func processTranscription(transcription: String) {
        debugPrint("\(SpeechCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) processTranscription \(DebuggingIdentifiers.actionOrEventInProgress).")
        for command in VoiceCommands.allCases {
            if transcription.lowercased().contains(command.rawValue.lowercased()) {
                debugPrint("\(SpeechCoordinator.identifier) processTranscription \(DebuggingIdentifiers.actionOrEventSucceded) Recognized Voice Command.")
                triggerCommand(command: command)
            }
        }
    }

    private func triggerCommand(command: VoiceCommands) {
        debugPrint("\(SpeechCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) triggerCommand \(DebuggingIdentifiers.actionOrEventInProgress) with command : \(command.rawValue).")
        // Trigger the specific command
        switch command {
        case .start:
            debugPrint("\(SpeechCoordinator.identifier) triggerCommand \(DebuggingIdentifiers.actionOrEventSucceded) Triggering Start Command.")
            break
        case .stop:
            debugPrint("\(SpeechCoordinator.identifier) triggerCommand \(DebuggingIdentifiers.actionOrEventSucceded) Triggering Stop Command.")
            break
        case .helloWorld:
            debugPrint("\(SpeechCoordinator.identifier) triggerCommand \(DebuggingIdentifiers.actionOrEventSucceded) Triggering Hello World Command.")
            break
        case .longCommand:
            debugPrint("\(SpeechCoordinator.identifier) triggerCommand \(DebuggingIdentifiers.actionOrEventSucceded) Triggering A Long Command.")
        }
        // Restart Audio Buffer to listen to a new command.
        self.restartAudioBuffer()
    }
}
