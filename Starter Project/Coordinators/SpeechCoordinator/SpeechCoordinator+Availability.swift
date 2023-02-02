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
            self.restartAudioBuffer()
        } else {
            debugPrint("\(SpeechCoordinator.identifier) availabilityDidChange \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition not available.")
        }
    }
}
