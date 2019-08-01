//
//  MoreController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/25/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit

class MoreController: UITableViewController {
    
    let settings : [[String]] = [["CubePRO Timer Version:",""],["Timer Theme"]]
    let descriptions : [[String]] = [["1.0.0"],[""]]
    let identities : [String] = ["A"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        myCell.textLabel?.text = settings[indexPath.section][indexPath.row]
        myCell.detailTextLabel?.text = descriptions[indexPath.section][indexPath.row]
        if indexPath.section == 0 && indexPath.row == 0 {
            myCell.accessoryType = .none
            myCell.isUserInteractionEnabled = false
        }
        else {
            myCell.accessoryType = .disclosureIndicator
            myCell.isUserInteractionEnabled = true
        }
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
