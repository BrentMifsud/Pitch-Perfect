//
//  PlaybackViewController.swift
//  Pitch Perfect
//
//  Created by Brent Mifsud on 2019-02-23.
//  Copyright © 2019 Brent Mifsud. All rights reserved.
//

import UIKit
import AVFoundation

class PlaybackViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioUrl: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func playbackButtonPressed(_ sender: UIButton){
        switch ButtonType(rawValue: sender.tag)! {
            case .slow:
                print("slow button pressed")
            case .fast:
                print("fast button pressed")
            case .highPitch:
                print("highpitch button pressed")
            case .lowPitch:
                print("lowpitch button pressed")
            case .echo:
                print("echo button pressed")
            case .reverb:
                print("reverb button pressed")
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
    }
}
