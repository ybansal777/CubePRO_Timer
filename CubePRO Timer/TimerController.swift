//
//  ViewController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/24/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit
import ChameleonFramework
import Speech


class TimerController: UIViewController, SFSpeechRecognizerDelegate {
    
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask : SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    var lang: String = "en-US"
    
    
    
    struct globalVariable {
        static var solveCount : Int = 0
        static var solveTimes : [String] = []
        static var AO5 : [String] = []
        static var BAO5 : [String] = []
        static var AO12 : [String] = []
        static var BAO12 : [String] = []
        static var AO100 : [String] = []
        static var BAO100 : [String] = []
        static var AO1000 : [String] = []
        static var BAO1000 : [String] = []
    }
    
    func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Float) {
        let (_,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (Int(min), Float(60 * secf))
    }
    
    @IBOutlet var wordsLabel: UILabel!
    
    @IBOutlet var audioButton: UIButton!
    
    @IBOutlet var scrambleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var solveLabel: UILabel!
    
    @IBAction func audioTapped(_ sender: Any) {
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        if audioEngine.isRunning {
            audioEngine.stop()
            wordsLabel.textColor = UIColor.white
            recognitionRequest.endAudio()
            audioButton.isEnabled = false
        } else {
            wordsLabel.textColor = UIColor.black
            startRecording()
        }
        if wordsLabel.text! == "New scramble" {
            generateScramble()
        }
        else if wordsLabel.text! == "Delete solve" {
            if self.solves.count == 0 {
                print("No Solves")
                self.defaults.set(self.solves, forKey: "SolvesArray")
                self.timeLabel.text = "Time"
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
            }
            if self.timeLabel.text == "Time" && self.solves.count != 0{
                self.solves.remove(at: self.solves.count-1)
                self.solveLabel.text = "Solves: " + String(self.solves.count)
                self.defaults.set(self.solves, forKey: "SolvesArray")
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
            }
            if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == true{
                self.stopTimer()
                self.solves.remove(at: self.solves.count-1)
                self.solveLabel.text = "Solves: " + String(self.solves.count)
                self.defaults.set(self.solves, forKey: "SolvesArray")
                self.timeLabel.text = "Time"
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
            }
            if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == false{
                self.solveLabel.text = "Solves: " + String(self.solves.count)
                self.defaults.set(self.solves, forKey: "SolvesArray")
                self.timeLabel.text = "Time"
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
            }
        }
        else if wordsLabel.text! == "Reset session" {
            self.solves.removeAll()
            self.solveLabel.text = "Solves: " + String(self.solves.count)
            self.defaults.set(self.solves, forKey: "SolvesArray")
            self.timeLabel.text = "Time"
            globalVariable.solveCount = self.solves.count
            globalVariable.solveTimes = self.solves
            self.generateScramble()
        }
    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("error")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: {
            (Result,Error) in
            
            var isFinal = false
            
            if Result != nil {
                self.wordsLabel.text = Result?.bestTranscription.formattedString
                isFinal = (Result?.isFinal)!
            }
            if Error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                self.recognitionTask = nil
                
                self.audioButton.isEnabled = true
            }
            
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("error")
        }
        wordsLabel.text = ""
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            audioButton.isEnabled = true
        } else {
            audioButton.isEnabled = false
        }
    }
    
    
    
    
    let defaults = UserDefaults.standard
    var solves : [String] = []
    var start = false
    var finish = true
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var holdPossible = true
    
    
    func startTimer() {
        if start == true {
            audioButton.isEnabled = false
            counter = 0.0
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            isPlaying = true
            finish = false
            holdPossible = false
            
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        isPlaying = false
        holdPossible = true
        audioButton.isEnabled = true
    }
    
    @objc func UpdateTimer() {

        counter += 0.01
        timeLabel.text = String(format: "%.002f", counter)
    }
    
    
    func generateScramble() {
        var scramble = ""
        var scramble2 = ""
        let moves = ["U ","U' ","U2 ","F ","F' ","F2 ","R ","R' ","R2 ","L ","L' ","L2 ","B ","B' ","B2 ","D ","D' ","D2 "]
        var scrambleOrder = [""]
        for _ in 1...20 {
            let index = Int.random(in: 0..<17)
            let step = moves[index]
            scramble += step
            scrambleOrder += [step]
        }
        for character in 0...(scrambleOrder.count-2) {
            if scrambleOrder[character] == scrambleOrder[character+1] {
                let index2 = Int.random(in: 0..<17)
                let step2 = moves[index2]
                scrambleOrder += [step2]
                scrambleOrder.remove(at: character)
            }
        }
        for _ in 0...1000 {
            for letters in 0...(scrambleOrder.count-2){
                if (scrambleOrder[letters] == "U " && scrambleOrder[letters+1] == "U' ") || (scrambleOrder[letters] == "U' " && scrambleOrder[letters+1] == "U ") || (scrambleOrder[letters] == "U " && scrambleOrder[letters+1] == "U ") || (scrambleOrder[letters] == "U' " && scrambleOrder[letters+1] == "U' ") || (scrambleOrder[letters] == "U2 " && scrambleOrder[letters+1] == "U2 ") || (scrambleOrder[letters] == "U2 " && scrambleOrder[letters+1] == "U ") || (scrambleOrder[letters] == "U2 " && scrambleOrder[letters+1] == "U' ") || (scrambleOrder[letters] == "U " && scrambleOrder[letters+1] == "U2 ") || (scrambleOrder[letters] == "U' " && scrambleOrder[letters+1] == "U2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
                else if (scrambleOrder[letters] == "F " && scrambleOrder[letters+1] == "F' ") || (scrambleOrder[letters] == "F' " && scrambleOrder[letters+1] == "F ") || (scrambleOrder[letters] == "F " && scrambleOrder[letters+1] == "F ") || (scrambleOrder[letters] == "F' " && scrambleOrder[letters+1] == "F' ") || (scrambleOrder[letters] == "F2 " && scrambleOrder[letters+1] == "F2 ") || (scrambleOrder[letters] == "F2 " && scrambleOrder[letters+1] == "F ") || (scrambleOrder[letters] == "F2 " && scrambleOrder[letters+1] == "F' ") || (scrambleOrder[letters] == "F " && scrambleOrder[letters+1] == "F2 ") || (scrambleOrder[letters] == "F' " && scrambleOrder[letters+1] == "F2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
                else if (scrambleOrder[letters] == "R " && scrambleOrder[letters+1] == "R' ") || (scrambleOrder[letters] == "R' " && scrambleOrder[letters+1] == "R ") || (scrambleOrder[letters] == "R " && scrambleOrder[letters+1] == "R ") || (scrambleOrder[letters] == "R' " && scrambleOrder[letters+1] == "R' ") || (scrambleOrder[letters] == "R2 " && scrambleOrder[letters+1] == "R2 ") || (scrambleOrder[letters] == "R2 " && scrambleOrder[letters+1] == "R ") || (scrambleOrder[letters] == "R2 " && scrambleOrder[letters+1] == "R' ") || (scrambleOrder[letters] == "R " && scrambleOrder[letters+1] == "R2 ") || (scrambleOrder[letters] == "R' " && scrambleOrder[letters+1] == "R2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
                else if (scrambleOrder[letters] == "L " && scrambleOrder[letters+1] == "L' ") || (scrambleOrder[letters] == "L' " && scrambleOrder[letters+1] == "L ") || (scrambleOrder[letters] == "L " && scrambleOrder[letters+1] == "L ") || (scrambleOrder[letters] == "L' " && scrambleOrder[letters+1] == "L' ") || (scrambleOrder[letters] == "L2 " && scrambleOrder[letters+1] == "L2 ") || (scrambleOrder[letters] == "L2 " && scrambleOrder[letters+1] == "L ") || (scrambleOrder[letters] == "L2 " && scrambleOrder[letters+1] == "L' ") || (scrambleOrder[letters] == "L " && scrambleOrder[letters+1] == "L2 ") || (scrambleOrder[letters] == "L' " && scrambleOrder[letters+1] == "L2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
                else if (scrambleOrder[letters] == "B " && scrambleOrder[letters+1] == "B' ") || (scrambleOrder[letters] == "B' " && scrambleOrder[letters+1] == "B ") || (scrambleOrder[letters] == "B " && scrambleOrder[letters+1] == "B ") || (scrambleOrder[letters] == "B' " && scrambleOrder[letters+1] == "B' ") || (scrambleOrder[letters] == "B2 " && scrambleOrder[letters+1] == "B2 ") || (scrambleOrder[letters] == "B2 " && scrambleOrder[letters+1] == "B ") || (scrambleOrder[letters] == "B2 " && scrambleOrder[letters+1] == "B' ") || (scrambleOrder[letters] == "B " && scrambleOrder[letters+1] == "B2 ") || (scrambleOrder[letters] == "B' " && scrambleOrder[letters+1] == "B2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
                else if (scrambleOrder[letters] == "D " && scrambleOrder[letters+1] == "D' ") || (scrambleOrder[letters] == "D' " && scrambleOrder[letters+1] == "D ") || (scrambleOrder[letters] == "D " && scrambleOrder[letters+1] == "D ") || (scrambleOrder[letters] == "D' " && scrambleOrder[letters+1] == "D' ") || (scrambleOrder[letters] == "D2 " && scrambleOrder[letters+1] == "D2 ") || (scrambleOrder[letters] == "D2 " && scrambleOrder[letters+1] == "D ") || (scrambleOrder[letters] == "D2 " && scrambleOrder[letters+1] == "D' ") || (scrambleOrder[letters] == "D " && scrambleOrder[letters+1] == "D2 ") || (scrambleOrder[letters] == "D' " && scrambleOrder[letters+1] == "D2 "){
                    let index3 = Int.random(in: 0..<17)
                    let step3 = moves[index3]
                    scrambleOrder += [step3]
                    scrambleOrder.remove(at: letters)
                }
            }
        }
        
        for element in scrambleOrder {
            scramble2.append(element)
        }
        scramble = scramble2
        scrambleLabel.text = scramble
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wordsLabel.text! = ""
        globalVariable.solveCount = solves.count
        globalVariable.solveTimes = solves
        if timeLabel.text != "Time" {
            timeLabel.text = String(format: "%.002f", counter)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        globalVariable.solveCount = solves.count
        globalVariable.solveTimes = solves
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsLabel.text! = ""
        audioButton.isEnabled = false
        speechRecognizer?.delegate = self as SFSpeechRecognizerDelegate
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: lang))
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                
            case .restricted:
                isButtonEnabled = false
                
            case .notDetermined:
                isButtonEnabled = false
            @unknown default:
                fatalError()
            }
            
            OperationQueue.main.addOperation() {
                self.audioButton.isEnabled = isButtonEnabled
            }
        }
        
        
        globalVariable.solveCount = solves.count
        globalVariable.solveTimes = solves
        timeLabel.text = "Time"
        timeLabel.textColor = UIColor.black
        generateScramble()
        if let solve = defaults.array(forKey: "SolvesArray") as? [String] {
            solves = solve
            self.solveLabel.text = "Solves: " + String(self.solves.count)
        }
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(gesture:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction2(gesture:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(press:)))
        holdGesture.minimumPressDuration = 0.1
        self.view.addGestureRecognizer(holdGesture)
        
        let endTap = UITapGestureRecognizer(target: self, action: #selector(self.stopTap(_:)))
        endTap.numberOfTapsRequired = 1
        endTap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(endTap)
        self.view.isUserInteractionEnabled = true
        
        let sessionTap = UITapGestureRecognizer(target: self, action: #selector(self.resetTap))
        sessionTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(sessionTap)
        self.view.isUserInteractionEnabled = true

        
    }
    
    
    
    @objc func swipeAction(gesture:UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            stopTimer()
            generateScramble()
        }
    }
    
    @objc func swipeAction2(gesture:UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
            stopTimer()
            if timeLabel.text! != "Time" {
                let number = Double(timeLabel.text!)
                print("Number: \(String(describing: number))")
                var h = ""
                if number! >= 60 {
                    let (m, s) = secondsToHoursMinutesSeconds(seconds: number!)
                    if s < 10 {
                        h = "0\(s)"
                    }
                    else {
                        h = String(s)
                    }
                    timeLabel.text! = "\(m):" + h
                    
                }
            }
            let delete = UIAlertController(title: "Delete your Solve", message: "Confirm this deletion?", preferredStyle: .alert)
            let No = UIAlertAction(title: "No", style: .default, handler:  { (UIAlertAction) in
                self.stopTimer()
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
            })
            let Yes = UIAlertAction(title: "Yes", style: .default, handler:  { (UIAlertAction) in
                if self.solves.count == 0 {
                    print("No Solves")
                    self.defaults.set(self.solves, forKey: "SolvesArray")
                    self.timeLabel.text = "Time"
                    globalVariable.solveCount = self.solves.count
                    globalVariable.solveTimes = self.solves
                }
                if self.timeLabel.text == "Time" && self.solves.count != 0{
                    self.solves.remove(at: self.solves.count-1)
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                    self.defaults.set(self.solves, forKey: "SolvesArray")
                    globalVariable.solveCount = self.solves.count
                    globalVariable.solveTimes = self.solves
                }
                if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == true{
                    self.stopTimer()
                    self.solves.remove(at: self.solves.count-1)
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                    self.defaults.set(self.solves, forKey: "SolvesArray")
                    self.timeLabel.text = "Time"
                    globalVariable.solveCount = self.solves.count
                    globalVariable.solveTimes = self.solves
                }
                if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == false{
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                    self.defaults.set(self.solves, forKey: "SolvesArray")
                    self.timeLabel.text = "Time"
                    globalVariable.solveCount = self.solves.count
                    globalVariable.solveTimes = self.solves
                }
            })
            
            delete.addAction(No)
            delete.addAction(Yes)
            
            present(delete, animated: true, completion: nil)
        }
    }
    
    @objc func longPress(press:UILongPressGestureRecognizer) -> Void {
        if holdPossible == true {
            if press.state == .began {
                print("Timer Ready")
                self.timeLabel.textColor = UIColor.flatSkyBlue()
                
            }
            if press.state == .ended {
                print("Timer Start")
                start = true
                self.timeLabel.textColor = UIColor.black
                startTimer()
                
            }
            if isPlaying == true {
                self.timeLabel.textColor = UIColor.black
            }
        }
    }
    
    
    @objc func stopTap(_ sender: UITapGestureRecognizer) {
        if isPlaying == true {
            print("Timer Stop")
            stopTimer()
            start = false
            isPlaying = false
            finish = true
            self.solves.append(self.timeLabel.text!)
            if timeLabel.text! != "Time" {
                let number = Double(timeLabel.text!)
                print("Number: \(String(describing: number))")
                var h = ""
                if number! >= 60 {
                    let (m, s) = secondsToHoursMinutesSeconds(seconds: number!)
                    if s < 10 {
                        h = "0\(s)"
                    }
                    else {
                        h = String(s)
                    }
                    timeLabel.text! = "\(m):" + h
                    
                }
            }
            self.solveLabel.text = "Solves: " + String(self.solves.count)
            self.defaults.set(self.solves, forKey: "SolvesArray")
            globalVariable.solveCount = solves.count
            globalVariable.solveTimes = solves
            generateScramble()
            
        }
    }
    

    @objc func resetTap(_ sender: UITapGestureRecognizer) {
        if true {
            print("Session Reset")
            start = false
            isPlaying = false
            stopTimer()
            finish = true
            if timeLabel.text! != "Time" {
                let number = Double(timeLabel.text!)
                print("Number: \(String(describing: number))")
                var h = ""
                if number! >= 60 {
                    let (m, s) = secondsToHoursMinutesSeconds(seconds: number!)
                    if s < 10 {
                        h = "0\(s)"
                    }
                    else {
                        h = String(s)
                    }
                    timeLabel.text! = "\(m):" + h
                    
                }
            }
            let reset = UIAlertController(title: "Reset your Session", message: "Would you like to reset?", preferredStyle: .alert)
            let No = UIAlertAction(title: "No", style: .default, handler:  { (UIAlertAction) in
                self.stopTimer()
            })
            let Yes = UIAlertAction(title: "Yes", style: .default, handler:  { (UIAlertAction) in
                self.solves.removeAll()
                self.solveLabel.text = "Solves: " + String(self.solves.count)
                self.defaults.set(self.solves, forKey: "SolvesArray")
                self.timeLabel.text = "Time"
                globalVariable.solveCount = self.solves.count
                globalVariable.solveTimes = self.solves
                self.generateScramble()
            })
            reset.addAction(No)
            reset.addAction(Yes)
            
            present(reset, animated: true, completion: nil)
            
        }
    }


}

