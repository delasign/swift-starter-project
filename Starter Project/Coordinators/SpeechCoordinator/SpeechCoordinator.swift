//
//  SpeechCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/1/23.
//

import Foundation
import UIKit
import Speech

class SpeechCoordinator: NSObject, SFSpeechRecognizerDelegate {

    // MARK: Variables
    static let identifier: String = "[SpeechCoordinator]"
    static let shared: SpeechCoordinator = SpeechCoordinator()
    // The speech recognizer object, set to listen to English.
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    // The audio buffer for speech recognition requests.
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    // The task to recognize speech.
    var recognitionTask: SFSpeechRecognitionTask?
    // The audio engine required to listen to live audio.
    let audioEngine = AVAudioEngine()
    // A timer to restart the audio buffer
    var audioRestartTimer: Timer?
    // A Timer to offset the restart of the audiobuffer - we made it a timer so we can invalidate it in the event we just want to stop the audio.
    var startAudioIntervalTimer: Timer?
    // A time interval to restart you buffer
    let restartTimeInterval: TimeInterval = 5

    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(SpeechCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Configure the SFSpeechRecognizer object already
        // stored in a local member variable.
        speechRecognizer.delegate = self
    }

    func requestAuthorization() {
        // Asynchronously make the authorization request.
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // Divert to the app's main thread so that the UI
            // can be updated.
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    debugPrint("\(SpeechCoordinator.identifier) requestAuthorization \(DebuggingIdentifiers.actionOrEventSucceded) Speech recognition authorized.")
                    self.restartAudioBuffer()
                case .denied:
                    debugPrint("\(SpeechCoordinator.identifier) requestAuthorization \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition authorization denied.")
                case .restricted:
                    debugPrint("\(SpeechCoordinator.identifier) requestAuthorization \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition restricted.")
                case .notDetermined:
                    debugPrint("\(SpeechCoordinator.identifier) requestAuthorization \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition not determined.")
                default:
                    debugPrint("\(SpeechCoordinator.identifier) requestAuthorization \(DebuggingIdentifiers.actionOrEventFailed) Speech recognition authorization defaulted.")
                }
            }
        }
    }

    func endAudioRecording() {
        // Invalidate Timer
        if let timer = audioRestartTimer, timer.isValid {
            audioRestartTimer?.invalidate()
            audioRestartTimer = nil
        }

        if let timer = startAudioIntervalTimer, timer.isValid {
            startAudioIntervalTimer?.invalidate()
        }

        // End Audio Recording
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.recognitionTask?.cancel()
            self.recognitionRequest = nil
            self.recognitionTask = nil
            self.audioEngine.inputNode.removeTap(onBus: 0)
            debugPrint("\(SpeechCoordinator.identifier) endAudioRecording \(DebuggingIdentifiers.actionOrEventSucceded) Ended Audio Recording.")
        } else {
            debugPrint("\(SpeechCoordinator.identifier) endAudioRecording \(DebuggingIdentifiers.actionOrEventFailed) Failed to End Audio Recording.")
        }
    }
}
