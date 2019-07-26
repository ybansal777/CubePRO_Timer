//
//  ViewController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/24/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit
import ChameleonFramework

class TimerController: UIViewController {
    
    
    
    
    
    @IBOutlet var scrambleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var solveLabel: UILabel!
    
    var solves : [String] = []
    var start = false
    var finish = true
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    func startTimer() {
        if start == true {
            counter = 0.0
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            isPlaying = true
            finish = false
        }
    }
    
    func stopTimer() {
        timer.invalidate()
        isPlaying = false
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "Time"
        timeLabel.textColor = UIColor.black
        generateScramble()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(gesture:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction2(gesture:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        
        let holdGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(press:)))
        holdGesture.minimumPressDuration = 0.25
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
            let delete = UIAlertController(title: "Delete your Solve", message: "Confirm this deletion?", preferredStyle: .alert)
            let No = UIAlertAction(title: "No", style: .default, handler:  { (UIAlertAction) in
                self.stopTimer()
            })
            let Yes = UIAlertAction(title: "Yes", style: .default, handler:  { (UIAlertAction) in
                if self.solves.count == 0 {
                    print("No Solves")
                    self.timeLabel.text = "Time"
                }
                if self.timeLabel.text == "Time" && self.solves.count != 0{
                    self.solves.remove(at: self.solves.count-1)
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                }
                if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == true{
                    self.stopTimer()
                    self.solves.remove(at: self.solves.count-1)
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                    self.timeLabel.text = "Time"
                }
                if self.timeLabel.text != "Time" && self.solves.count != 0 && self.finish == false{
                    self.solveLabel.text = "Solves: " + String(self.solves.count)
                    self.timeLabel.text = "Time"
                }
            })
            
            delete.addAction(No)
            delete.addAction(Yes)
            
            present(delete, animated: true, completion: nil)
        }
    }
    
    @objc func longPress(press:UILongPressGestureRecognizer) -> Void {
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
    }
    
    
    @objc func stopTap(_ sender: UITapGestureRecognizer) {
        if isPlaying == true {
            print("Timer Stop")
            start = false
            stopTimer()
            finish = true
            self.solves.append(self.timeLabel.text!)
            self.solveLabel.text = "Solves: " + String(self.solves.count)
            generateScramble()
            
        }
    }
    

    @objc func resetTap(_ sender: UITapGestureRecognizer) {
        if true {
            print("Session Reset")
            start = false
            stopTimer()
            finish = true
            let reset = UIAlertController(title: "Reset your Session", message: "Would you like to reset?", preferredStyle: .alert)
            let No = UIAlertAction(title: "No", style: .default, handler:  { (UIAlertAction) in
                self.stopTimer()
            })
            let Yes = UIAlertAction(title: "Yes", style: .default, handler:  { (UIAlertAction) in
                self.solves.removeAll()
                self.solveLabel.text = "Solves: " + String(self.solves.count)
                self.timeLabel.text = "Time"
                self.generateScramble()
            })
            reset.addAction(No)
            reset.addAction(Yes)
            
            present(reset, animated: true, completion: nil)
            
        }
    }


}

