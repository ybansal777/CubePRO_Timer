//
//  SettingsController.swift
//  CubePRO Timer
//
//  Created by Sumeet Bansal on 7/31/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    var themes : [[String]] = [["White & Red","White & Orange", "White & Green", "White & Blue", "White & Purple"],["Black & Red","Black & Orange", "Black & Green", "Black & Blue", "Black & Purple"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
        cell.textLabel?.text = themes[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        TimerController.globalVariable.appTheme = themes[indexPath.section][indexPath.row]
        if (TimerController.globalVariable.appTheme == "White & Red") || (TimerController.globalVariable.appTheme == "White & Orange") || (TimerController.globalVariable.appTheme == "White & Green") || (TimerController.globalVariable.appTheme == "White & Blue") || (TimerController.globalVariable.appTheme == "White & Purple") {
            self.tabBarController!.tabBar.barTintColor = UIColor.white
        }
        if (TimerController.globalVariable.appTheme == "Black & Red") || (TimerController.globalVariable.appTheme == "Black & Orange") || (TimerController.globalVariable.appTheme == "Black & Green") || (TimerController.globalVariable.appTheme == "Black & Blue") || (TimerController.globalVariable.appTheme == "Black & Purple") {
            self.tabBarController!.tabBar.barTintColor = UIColor.black
        }
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
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
