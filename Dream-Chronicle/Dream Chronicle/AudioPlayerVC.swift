//
//  AudioPlayerVC.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/16/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class AudioPlayerVC: UIViewController {
    
    lazy var motionManager = CMMotionManager()
    var trackID: Int!
    var audioPlayer:AVAudioPlayer!
    var trackName: String!
    
    @IBOutlet var trackLbl: UILabel!
    
    @IBOutlet var progressView: UIProgressView!
    @IBAction func fastBackward(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0 
        if time < 0
        {
            stop(self)
        }else
        {
            audioPlayer.currentTime = time
        }
    }
    @IBAction func pause(_ sender: AnyObject) {
        audioPlayer.pause()
    }
    @IBAction func play(_ sender: AnyObject) {
        if !audioPlayer.isPlaying{
            audioPlayer.play()
        }
    }
    @IBAction func stop(_ sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0.0
    }
    @IBAction func fastForward(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0
        if time > audioPlayer.duration
        {
            stop(self)
        }else
        {
            audioPlayer.currentTime = time
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if !audioPlayer.isPlaying{
                audioPlayer.play()
            }
            else {
                audioPlayer.pause()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackLbl.text = trackName
        let path: String! = Bundle.main.resourcePath?.appending("/\(trackID!).mp3")
        let mp3URL = NSURL(fileURLWithPath: path)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL as URL)
            audioPlayer.play()
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateAudioProgressView()
    {
        if audioPlayer.isPlaying
        {
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
}
