//
//  MoreController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/25/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit

class MoreController: UITableViewController {
    
    let settings : [[String]] = [["CubePRO Timer Version:",""],["Timer Theme"],["Rate App"]]
    let descriptions : [[String]] = [["1.0.0"],[""],[""]]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
}
