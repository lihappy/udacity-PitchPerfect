//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Li, Haibo on 1/23/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import UIKit
import AVFoundation

let kSegueIdentifier: String = "stopRecording"

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopRecordingButton.isEnabled = false
        recordButton.imageView?.contentMode = .scaleAspectFit
        stopRecordingButton.imageView?.contentMode = .scaleAspectFit
        recordingLabel.numberOfLines = 1
        recordingLabel.adjustsFontSizeToFitWidth = true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func recordAudio(_ sender: Any) {
        setUIState(couldRecord: false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        setUIState(couldRecord: true)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func setUIState(couldRecord: Bool) {
        stopRecordingButton.isEnabled = !couldRecord
        recordButton.isEnabled = couldRecord
        recordingLabel.text = couldRecord ? "Tap to Record" : "Recording in Progress"
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {        
        if flag {
            performSegue(withIdentifier: kSegueIdentifier, sender: audioRecorder.url)
        } else {
            showAlert("Failed", message: Alerts.AudioRecordingError, self)
        }
    }
    
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueIdentifier {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as! URL
        }
    }

}

