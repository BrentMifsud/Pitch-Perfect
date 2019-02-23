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
    @IBOutlet weak var stopButton: UIButton!
    
    private let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    private let filename = "voiceRecording.aac"
    private var audioRecorder: AVAudioRecorder!
    
    enum RecordingState: String {
        case recording = "Recording in Progress..."
        case notRecording = "Tap to Start Recording"
    }
    
    //MARK:- Methods
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureUI(.notRecording)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Button Event Handler Methods
    @IBAction func recordButtonPressed(_ sender: Any) {
        let filePath = URL(string: "\(url)\(filename)")
        
        print("\(filePath)")
        
        startRecording(to: filePath!)
        
        configureUI(.recording)
        
        
    }
    
    @IBAction func stopRecordingButtonPressed(_ sender: Any) {
        stopRecording()
        configureUI(.notRecording)
    }
    
    private func configureUI(_ recordingState: RecordingState) {
        switch recordingState {
        case .recording:
            self.stopButton.isEnabled = true
            self.startButton.isEnabled = false
            self.recordingLabel.text = recordingState.rawValue
        case .notRecording:
            self.stopButton.isEnabled = false
            self.startButton.isEnabled = true
            self.recordingLabel.text = recordingState.rawValue
        }
    }
}

//MARK:- AVAudioRecorder Control Methods
extension RecordingViewController: AVAudioRecorderDelegate {
    func startRecording(to url: URL) {
        do{
            //Initialize AVAudioRecorder
            audioRecorder = try AVAudioRecorder(
                url: url,
                settings: [
                    AVFormatIDKey:Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 8000,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
            )
            //Set AVAudioRecorder Delegate
            audioRecorder.delegate = self
            
            //Delete existing file
            audioRecorder.deleteRecording()
            
            //Create audio file and begin recording
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("Error Initializing Audio Recorder: \(error)")
        }
    }
    
    func pauseRecording() {
        audioRecorder.pause()
    }
    
    func continueRecording() {
        audioRecorder.record()
    }
    
    func stopRecording(){
        audioRecorder.stop()
    }
}

