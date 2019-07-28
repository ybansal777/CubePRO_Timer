//
//  DescriptionController.swift
//  CubePRO Timer
//
//  Created by Sumeet Bansal on 7/27/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit


class DescriptionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newArray = TimerController.globalVariable.solveTimes
    var newCount = TimerController.globalVariable.solveCount
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var descriptionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "\(numbSolves[indexNumber].title): \(numbSolves[indexNumber].result)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainLabel.text! == "Best Time: \(numbSolves[indexNumber].result)" {
            newArray = [""]
        }
        if mainLabel.text! == "Worst Time: \(numbSolves[indexNumber].result)" {
            newArray = [""]
        }
        return newArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath)
        if newCount == 0 {
            cell.textLabel?.text = ""
        }
        else {
            if mainLabel.text! == "Best Time: \(numbSolves[indexNumber].result)" {
                newArray = TimerController.globalVariable.solveTimes
                cell.textLabel?.text = newArray.min()
            }
            else if mainLabel.text! == "Worst Time: \(numbSolves[indexNumber].result)" {
                newArray = TimerController.globalVariable.solveTimes
                cell.textLabel?.text = newArray.max()
            }
            else {
                cell.textLabel?.text = newArray[indexPath.row]
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
