//
//  SpeechCoordinator+Transcription.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/1/23.
//

import Foundation
import Speech

extension SpeechCoordinator {

    func transcribeAudio() throws {
        debugPrint("\(SpeechCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress).")
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil

        // Configure the audio session for the app.
        debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress) Configuring audio session for the app \(DebuggingIdentifiers.actionOrEventInProgress) .")
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress) Configuring speech recognition request for the app \(DebuggingIdentifiers.actionOrEventInProgress) .")
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true

        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }

        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress) Creating Task \(DebuggingIdentifiers.actionOrEventInProgress) .")
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self, self.recognitionTask != nil else {
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventFailed) Recognition Task does not exist. Cancelling recognition request")
                return
            }
            var isFinal = false

            if let result = result {
                // Print the results.
                isFinal = result.isFinal
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventSucceded) Text : \(result.bestTranscription.formattedString).")
            }

            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
                // Log Problem
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventFailed) Audio Transcription Failed.")
            }
        }

        // Configure the microphone input.
        debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress) Configuring microphone input \(DebuggingIdentifiers.actionOrEventInProgress) .")
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        // Start the engine
        debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventInProgress) Starting audio engine \(DebuggingIdentifiers.actionOrEventInProgress) .")
        audioEngine.prepare()
        try audioEngine.start()
    }
}
