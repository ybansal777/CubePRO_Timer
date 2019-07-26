//
//  StatsController.swift
//  CubePRO Timer
//
//  Created by Sumeet Bansal on 7/25/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit

class StatsController: UITableViewController {

    
    
    let statListArray = ["Number of Solves","Best Time","Worst Time","Session Average"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statListArray.count
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = statListArray[indexPath.row]
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
}
