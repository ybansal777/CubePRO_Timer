//
//  StatsController.swift
//  CubePRO Timer
//
//  Created by Sumeet Bansal on 7/26/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit
struct Solves {
    
    var id : Int
    var title : String
    var result : String
    
}
class StatsController: UITableViewController {
    
    var numbOfSolves : Int = 0
    var solveArray : [String] = []
    var intSolveArray : Array<Float>!
    var numbSolves = [Solves(id: 1, title: "Number Of Solves", result: "0"), Solves(id: 2, title: "Session Average", result: "00.00"), Solves(id: 3, title: "Best Time", result: "00.00"), Solves(id: 4, title: "Worst Time", result: "00.00")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbOfSolves = TimerController.globalVariable.solveCount
        numbSolves[0].result = String(numbOfSolves)
        solveArray = TimerController.globalVariable.solveTimes
        intSolveArray = solveArray.map { Float($0)!}
        if intSolveArray.count == 0 {
            numbSolves[2].result = "00.00"
            numbSolves[3].result = "00.00"
        }
        if intSolveArray.count != 0 {
            let a = intSolveArray.min()
            let b = String(a!)
            if b != "" {
                print("Best: \(b)")
                numbSolves[2].result = b
            }
            let c = intSolveArray.max()
            let d = String(c!)
            if d != "" {
                print("Best: \(d)")
                numbSolves[3].result = d
            }
        }
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        numbOfSolves = TimerController.globalVariable.solveCount
        solveArray = TimerController.globalVariable.solveTimes
        intSolveArray = solveArray.map { Float($0)!}
        numbSolves[0].result = String(numbOfSolves)
        if intSolveArray.count == 0 {
            numbSolves[2].result = "00.00"
            numbSolves[3].result = "00.00"
        }
        if intSolveArray.count != 0 {
            let a = intSolveArray.min()
            let b = String(a!)
            if b != "" {
                print("Best: \(b)")
                numbSolves[2].result = b
            }
            let c = intSolveArray.max()
            let d = String(c!)
            if d != "" {
                print("Best: \(d)")
                numbSolves[3].result = d
            }
        }
        print("solveCount is: \(TimerController.globalVariable.solveCount)")
        if TimerController.globalVariable.solveCount == 0 {
            solveArray = []
            intSolveArray = []
            self.tableView.reloadData()
        }
        intSolveArray = solveArray.map { Float($0)!}
        print("Solve List: \(String(describing: intSolveArray))")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = numbSolves[indexPath.row].title
        cell.detailTextLabel?.text = numbSolves[indexPath.row].result
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
