//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Brent Mifsud on 2019-02-23.
//  Copyright © 2019 Brent Mifsud. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {

    //MARK:- Class Properties
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    enum RecordingState: String {
        case recording = "Recording in Progress..."
        case notRecording = "Tap to Start Recording"
    }
    
    //MARK:- Methods
    //MARK: View Init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureUI(.notRecording)
    }
    
    //MARK: Button Event Handler Methods
    @IBAction func recordButtonPressed(_ sender: Any) {
        //TODO add recording code here
        configureUI(.recording)
    }
    
    @IBAction func stopRecordingButtonPressed(_ sender: Any) {
        //TODO add stop recording code here
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
    
    //MARK: AVFoundation Methods
}

