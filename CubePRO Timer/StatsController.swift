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

var indexNumber = 0
var numbSolves = [Solves(id: 1, title: "Number Of Solves", result: "0"), Solves(id: 2, title: "Session Average", result: "00.00"), Solves(id: 3, title: "Best Time", result: "00.00"), Solves(id: 4, title: "Worst Time", result: "00.00")]

class StatsController: UITableViewController {
    
    var numbOfSolves : Int = 0
    var solveArray : [String] = []
    var intSolveArray : Array<Double>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbOfSolves = TimerController.globalVariable.solveCount
        numbSolves[0].result = String(numbOfSolves)
        solveArray = TimerController.globalVariable.solveTimes
        intSolveArray = solveArray.map { Double($0)!}
        self.tableView.reloadData()
        if intSolveArray.count == 0 {
            numbSolves[2].result = "00.00"
            numbSolves[3].result = "00.00"
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count == 1 {
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count == 2 {
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count != 0 {
            let a = intSolveArray.min()
            let b = String(a!)
            if b != "" {
                numbSolves[2].result = b
            }
            let c = intSolveArray.max()
            let d = String(c!)
            if d != "" {
                numbSolves[3].result = d
            }
            if solveArray.count > 2 {
                var f = intSolveArray.sorted()
                f.remove(at: 0)
                f.remove(at: intSolveArray!.count-2)
                let total = f.reduce(0, +)
                let average = total/Double(f.count)
                let roundedAverage = Double(round(100*average)/100)
                let normalRoundedAverage = String(format: "%.2f", roundedAverage)
                numbSolves[1].result = normalRoundedAverage
            }
        }
        
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        numbOfSolves = TimerController.globalVariable.solveCount
        solveArray = TimerController.globalVariable.solveTimes
        intSolveArray = solveArray.map { Double($0)!}
        numbSolves[0].result = String(numbOfSolves)
        if intSolveArray.count == 0 {
            numbSolves[2].result = "00.00"
            numbSolves[3].result = "00.00"
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count == 1 {
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count == 2 {
            numbSolves[1].result = "00.00"
        }
        if intSolveArray.count != 0 {
            let a = intSolveArray.min()
            let b = String(a!)
            if b != "" {
                numbSolves[2].result = b
            }
            let c = intSolveArray.max()
            let d = String(c!)
            if d != "" {
                numbSolves[3].result = d
            }
        }
        if solveArray.count > 2 {
            var f = intSolveArray.sorted()
            f.remove(at: 0)
            f.remove(at: intSolveArray!.count-2)
            let total = f.reduce(0, +)
            let average = total/Double(f.count)
            let roundedAverage = Double(round(100*average)/100)
            let normalRoundedAverage = String(format: "%.2f", roundedAverage)
            numbSolves[1].result = normalRoundedAverage
        }
        print("solveCount is: \(TimerController.globalVariable.solveCount)")
        if TimerController.globalVariable.solveCount == 0 {
            solveArray = []
            intSolveArray = []
            self.tableView.reloadData()
        }
        intSolveArray = solveArray.map { Double($0)!}
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
        indexNumber = indexPath.row
        performSegue(withIdentifier: "statSegue", sender: self)
    }
    
}
