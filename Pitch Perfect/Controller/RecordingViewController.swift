//
//  RecordingViewController.swift
//  Pitch Perfect
//
//  Created by Brent Mifsud on 2019-02-23.
//  Copyright © 2019 Brent Mifsud. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController {

    //MARK:- Class Properties
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    private let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    private let filename = "voiceRecording.aac"
    private var audioRecorder: AVAudioRecorder!
    private var recordingState: RecordingState!
    
    enum RecordingState: String {
        case recording = "Recording in Progress..."
        case paused = "Recording paused. Tap Record or Stop"
        case notRecording = "Tap to Start Recording"
    }
    
    
    //MARK:- Methods
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recordingState = .notRecording
        configureUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playbackViewController" {
            let targetViewController = segue.destination as! PlaybackViewController
            targetViewController.audioUrl = (sender as! URL)
        }
        
    }
    
    //MARK: Button Event Handler Methods
    @IBAction func recordButtonPressed(_ sender: Any) {
        let filePath = URL(string: "\(url)\(filename)")
        
        switch recordingState! {
            case .notRecording:
                startRecording(to: filePath!)
            case .paused:
                continueRecording()
            case .recording:
                print("This Scenario can not happen")
        }
        
        configureUI()
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        pauseRecording()
        configureUI()
    }
    
    
    @IBAction func stopRecordingButtonPressed(_ sender: Any) {
        stopRecording()
        configureUI()
    }
    
    private func configureUI() {
        switch self.recordingState! {
            case .recording:
                self.stopButton.isEnabled = true
                self.startButton.isEnabled = false
                self.pauseButton.isEnabled = true
                self.recordingLabel.text = recordingState.rawValue
            case .notRecording:
                self.stopButton.isEnabled = false
                self.startButton.isEnabled = true
                self.pauseButton.isEnabled = false
                self.recordingLabel.text = recordingState.rawValue
            case .paused:
                self.stopButton.isEnabled = true
                self.startButton.isEnabled = true
                self.pauseButton.isEnabled = false
                self.recordingLabel.text = recordingState.rawValue
        }
    }
}


//MARK:- AVAudioRecorder Control Methods
extension RecordingViewController: AVAudioRecorderDelegate {
    func startRecording(to url: URL) {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)

        } catch {
            print("Recording Audio Session Error: \(error)")
        }
        
        
        do{
            //Initialize AVAudioRecorder
            audioRecorder = try AVAudioRecorder(
                url: url,
                settings: [
                    AVFormatIDKey:Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 8000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
                ]
            )
            //Set AVAudioRecorder Delegate
            audioRecorder.delegate = self
            
            //Delete existing file
            audioRecorder.deleteRecording()
            
            //Create audio file and begin recording
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            recordingState = .recording
        } catch {
            print("Error Initializing Audio Recorder: \(error)")
        }
    }
    
    func pauseRecording() {
        audioRecorder.pause()
        recordingState = .paused
    }
    
    func continueRecording() {
        audioRecorder.record()
        recordingState = .recording
    }
    
    func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        recordingState = .notRecording
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "playbackViewController", sender: audioRecorder.url)
        } else {
            print("Failed to stop Recording!")
        }
    }
}

