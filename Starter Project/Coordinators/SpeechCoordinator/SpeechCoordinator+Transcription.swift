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
                let transcription: String = result.bestTranscription.formattedString
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventSucceded) Text : \(transcription).")
                self.processTranscription(transcription: transcription)
            }

            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
                // Log Problem
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventFailed) isFinal :\(isFinal).")
                debugPrint("\(SpeechCoordinator.identifier) transcribeAudio \(DebuggingIdentifiers.actionOrEventFailed) Audio Transcription Failed with error :\(error?.localizedDescription).")
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

    public func restartAudioBuffer() {
        debugPrint("\(SpeechCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) restartAudioBuffer \(DebuggingIdentifiers.actionOrEventInProgress) Engine is running : \(audioEngine.isRunning).")
        if audioEngine.isRunning {
            debugPrint("\(SpeechCoordinator.identifier) restartAudioBuffer \(DebuggingIdentifiers.actionOrEventFailed) Audio Engine Running.")
            self.endAudioRecording()
            self.startAudioIntervalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { timer in
                timer.invalidate()
                self.restartAudioBuffer()
            })
        } else {
            do {
                try transcribeAudio()
                debugPrint("\(SpeechCoordinator.identifier) restartAudioBuffer \(DebuggingIdentifiers.actionOrEventSucceded) Restarted audio buffer.")
                self.setRestartAudioBufferTimer()
            } catch {
                debugPrint("\(SpeechCoordinator.identifier) restartAudioBuffer \(DebuggingIdentifiers.actionOrEventFailed) Failed to restart audio buffer with error \(error)")
            }
        }
    }

    private func setRestartAudioBufferTimer() {
        debugPrint("\(SpeechCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) setRestartAudioBufferTimer \(DebuggingIdentifiers.actionOrEventInProgress).")
        if let timer = self.audioRestartTimer, timer.isValid {
            self.audioRestartTimer?.invalidate()
            self.audioRestartTimer = nil
            debugPrint("\(SpeechCoordinator.identifier) setRestartAudioBufferTimer \(DebuggingIdentifiers.actionOrEventSucceded) Restarted Timer.")
        }

        self.audioRestartTimer = Timer.scheduledTimer(withTimeInterval: self.restartTimeInterval, repeats: false, block: { timer in
            timer.invalidate()
            debugPrint("\(SpeechCoordinator.identifier) setRestartAudioBufferTimer \(DebuggingIdentifiers.actionOrEventSucceded) Timer triggered.")
            self.restartAudioBuffer()
        })
    }
}
