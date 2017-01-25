//
//  PitchPerfectUtils.swift
//  PitchPerfect
//
//  Created by Li, Haibo on 1/25/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import UIKit


// MARK: Alerts

struct Alerts {
    static let DismissAlert = "Dismiss"
    static let RecordingDisabledTitle = "Recording Disabled"
    static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let RecordingFailedTitle = "Recording Failed"
    static let RecordingFailedMessage = "Something went wrong with your recording."
    static let AudioRecorderError = "Audio Recorder Error"
    static let AudioSessionError = "Audio Session Error"
    static let AudioRecordingError = "Audio Recording Error"
    static let AudioFileError = "Audio File Error"
    static let AudioEngineError = "Audio Engine Error"
}

func showAlert(_ title: String, message: String, _ sender: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
    sender.present(alert, animated: true, completion: nil)
}


class PitchPerfectUtils: NSObject {

}
