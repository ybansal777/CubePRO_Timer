//
//  HelpController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/25/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit


class HelpController: UITableViewController {
    
    let gestures : [[String]] = [["Start Timer", "Stop Timer", "Delete Last Solve", "Generate New Scramble", "Reset Current Session"], ["Delete Last Solve", "Generate New Scramble", "Reset Current Session"]]
    let titles = ["Touch Gestures", "Voice Commands"]
    let subtitles : [[String]] = [["Hold and Release", "Single Tap", "Swipe Left", "Swipe Right", "Double Tap"], ["Say \"Delete Solve\"","Say \"New Scramble\"", "Say \"Reset Session\"" ]]
    let myImages : [[UIImage]] = [[#imageLiteral(resourceName: "hold"),#imageLiteral(resourceName: "stop"),#imageLiteral(resourceName: "swipeLeft"),#imageLiteral(resourceName: "swipeRight"),#imageLiteral(resourceName: "reset")],[#imageLiteral(resourceName: "voicecommand"),#imageLiteral(resourceName: "voicecommand"),#imageLiteral(resourceName: "voicecommand")]]
    
    @IBOutlet var iconButton: UIBarButtonItem!
    
    @IBAction func buttonTapped(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gestures[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "gestCell", for: indexPath)
        myCell.textLabel?.text = gestures[indexPath.section][indexPath.row]
        myCell.imageView?.image = myImages[indexPath.section][indexPath.row]
        myCell.detailTextLabel?.text = subtitles[indexPath.section][indexPath.row]
        return myCell
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconButton.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (TimerController.globalVariable.appTheme == "White & Red") || (TimerController.globalVariable.appTheme == "Black & Red") {
            self.navigationController?.navigationBar.barTintColor = UIColor.red
        }
        if (TimerController.globalVariable.appTheme == "White & Orange") || (TimerController.globalVariable.appTheme == "Black & Orange") {
            self.navigationController?.navigationBar.barTintColor = UIColor.orange
        }
        if (TimerController.globalVariable.appTheme == "White & Green") || (TimerController.globalVariable.appTheme == "Black & Green") {
            self.navigationController?.navigationBar.barTintColor = UIColor.flatGreenColorDark()
        }
        if (TimerController.globalVariable.appTheme == "White & Blue") || (TimerController.globalVariable.appTheme == "Black & Blue") {
            self.navigationController?.navigationBar.barTintColor = UIColor.flatSkyBlue()
        }
        if (TimerController.globalVariable.appTheme == "White & Purple") || (TimerController.globalVariable.appTheme == "Black & Purple") {
            self.navigationController?.navigationBar.barTintColor = UIColor.purple
        }
    }
    
    
}
