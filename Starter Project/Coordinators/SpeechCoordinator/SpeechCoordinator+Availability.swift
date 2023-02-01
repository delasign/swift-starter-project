//
//  SpeechCoordinator+Availability.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/1/23.
//

import Foundation
import Speech

extension SpeechCoordinator {
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            debugPrint("\(SpeechCoordinator.identifier) availabilityDidChange \(DebuggingIdentifiers.actionOrEventSucceded) Speech recognition available.")
            do {
                try self.transcribeAudio()
            } catch {
                debugPrint("\(SpeechCoordinator.identifier) availabilityDidChange \(DebuggingIdentifiers.actionOrEventFailed) Failed to start transcribing audio.")
            }
        } else {
            debugPrint("\(SpeechCoordinator.identifier) availabilityDidChange \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition not available.")
        }
    }
}
