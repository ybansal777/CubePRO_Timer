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
var numbSolves = [Solves(id: 0, title: "Number Of Solves", result: "0"), Solves(id: 1, title: "Session Average", result: "00.00"), Solves(id: 2, title: "Best Time", result: "00.00"), Solves(id: 3, title: "Worst Time", result: "00.00"), Solves(id: 4, title: "Current Average of 5", result: "00.00"),Solves(id: 5, title: "Best Average of 5", result: "00.00"), Solves(id: 6, title: "Current Average of 12", result: "00.00"), Solves(id: 7, title: "Best Average of 12", result: "00.00"), Solves(id: 8, title: "Current Average of 100", result: "00.00"), Solves(id: 9, title: "Best Average of 100", result: "00.00"), Solves(id: 10, title: "Current Average of 1000", result: "00.00"), Solves(id: 11, title: "Best Average of 1000", result: "00.00")]

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
            numbSolves[1].result = "00.00"
            numbSolves[2].result = "00.00"
            numbSolves[3].result = "00.00"
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
            if solveArray.count > 4 {
                var fiveaverage : [Double] = []
                var bestAverage = 0.00
                var bestFiveArray : [Double] = []
                var sortedIntArray = intSolveArray
                for index in 0...(sortedIntArray!.count-5){
                    fiveaverage = []
                    for j in index...index+4 {
                        fiveaverage.append(sortedIntArray![j])
                    }
                    var m : [String] = []
                    for item in fiveaverage {
                        m.append(String(item))
                    }
                    TimerController.globalVariable.BAO5 = m
                    fiveaverage.remove(at: (fiveaverage.firstIndex(of: fiveaverage.min()!))!)
                    fiveaverage.remove(at: (fiveaverage.firstIndex(of: fiveaverage.max()!))!)
                    let total3 = fiveaverage.reduce(0,+)
                    bestAverage = total3/3
                    bestFiveArray.append(bestAverage)
                }
                let numberOneAverage = bestFiveArray.min()!
                let bestroundedAverage = Double(round(100*numberOneAverage)/100)
                let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
                numbSolves[5].result = bestnormalRoundedAverage
                
                
                let fiveArray = intSolveArray.suffix(5)
                let h = Array(fiveArray)
                var m : [String] = []
                for item in h {
                    m.append(String(item))
                }
                TimerController.globalVariable.AO5 = m
                var g = fiveArray.sorted()
                g.remove(at:0)
                g.remove(at: fiveArray.count-2)
                let total = g.reduce(0, +)
                let average = total/Double(g.count)
                let roundedAverage = Double(round(100*average)/100)
                let normalRoundedAverage = String(format: "%.2f", roundedAverage)
                numbSolves[4].result = normalRoundedAverage
                self.tableView.reloadData()
            }
            
            if solveArray.count > 11 {
                var twelveaverage : [Double] = []
                var bestAverage = 0.00
                var bestTwelveArray : [Double] = []
                var sortedIntArray = intSolveArray
                for index in 0...(sortedIntArray!.count-12){
                    twelveaverage = []
                    for j in index...index+11 {
                        twelveaverage.append(sortedIntArray![j])
                    }
                    var m : [String] = []
                    for item in twelveaverage {
                        m.append(String(item))
                    }
                    TimerController.globalVariable.BAO12 = m
                    twelveaverage.remove(at: (twelveaverage.firstIndex(of: twelveaverage.min()!))!)
                    twelveaverage.remove(at: (twelveaverage.firstIndex(of: twelveaverage.max()!))!)
                    let total10 = twelveaverage.reduce(0,+)
                    bestAverage = total10/10
                    bestTwelveArray.append(bestAverage)
                }
                let numberOneAverage = bestTwelveArray.min()!
                let bestroundedAverage = Double(round(100*numberOneAverage)/100)
                let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
                numbSolves[7].result = bestnormalRoundedAverage
                
                
                
                let twelveArray = intSolveArray.suffix(12)
                var g = twelveArray.sorted()
                g.remove(at:0)
                g.remove(at: twelveArray.count-2)
                let total = g.reduce(0, +)
                let average = total/10
                let roundedAverage = Double(round(100*average)/100)
                let normalRoundedAverage = String(format: "%.2f", roundedAverage)
                numbSolves[6].result = normalRoundedAverage
            }
            
            if solveArray.count > 99 {
                var hundredaverage : [Double] = []
                var bestAverage = 0.00
                var bestHundredArray : [Double] = []
                var sortedIntArray = intSolveArray
                for index in 0...(sortedIntArray!.count-100){
                    hundredaverage = []
                    for j in index...index+99 {
                        hundredaverage.append(sortedIntArray![j])
                    }
                    var m : [String] = []
                    for item in hundredaverage {
                        m.append(String(item))
                    }
                    TimerController.globalVariable.BAO100 = m
                    hundredaverage.remove(at: (hundredaverage.firstIndex(of: hundredaverage.min()!))!)
                    hundredaverage.remove(at: (hundredaverage.firstIndex(of: hundredaverage.max()!))!)
                    let total98 = hundredaverage.reduce(0,+)
                    bestAverage = total98/98
                    bestHundredArray.append(bestAverage)
                }
                let numberOneAverage = bestHundredArray.min()!
                let bestroundedAverage = Double(round(100*numberOneAverage)/100)
                let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
                numbSolves[9].result = bestnormalRoundedAverage
                
                
                
                let hundredArray = intSolveArray.suffix(100)
                let h = Array(hundredArray)
                var m : [String] = []
                for item in h {
                    m.append(String(item))
                }
                TimerController.globalVariable.AO100 = m
                var g = hundredArray.sorted()
                g.remove(at:0)
                g.remove(at: hundredArray.count-2)
                let total = g.reduce(0, +)
                let average = total/Double(g.count)
                let roundedAverage = Double(round(100*average)/100)
                let normalRoundedAverage = String(format: "%.2f", roundedAverage)
                numbSolves[10].result = normalRoundedAverage
                self.tableView.reloadData()
            }
            
            if solveArray.count > 999 {
                var thousandaverage : [Double] = []
                var bestAverage = 0.00
                var bestthousandArray : [Double] = []
                var sortedIntArray = intSolveArray
                for index in 0...(sortedIntArray!.count-1000){
                    thousandaverage = []
                    for j in index...index+999 {
                        thousandaverage.append(sortedIntArray![j])
                    }
                    var m : [String] = []
                    for item in thousandaverage {
                        m.append(String(item))
                    }
                    TimerController.globalVariable.BAO1000 = m
                    thousandaverage.remove(at: (thousandaverage.firstIndex(of: thousandaverage.min()!))!)
                    thousandaverage.remove(at: (thousandaverage.firstIndex(of: thousandaverage.max()!))!)
                    let total998 = thousandaverage.reduce(0,+)
                    bestAverage = total998/998
                    bestthousandArray.append(bestAverage)
                }
                let numberOneAverage = bestthousandArray.min()!
                let bestroundedAverage = Double(round(100*numberOneAverage)/100)
                let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
                numbSolves[11].result = bestnormalRoundedAverage
                
                
                
                let thousandArray = intSolveArray.suffix(1000)
                let h = Array(thousandArray)
                var m : [String] = []
                for item in h {
                    m.append(String(item))
                }
                TimerController.globalVariable.AO1000 = m
                var g = thousandArray.sorted()
                g.remove(at:0)
                g.remove(at: thousandArray.count-2)
                let total = g.reduce(0, +)
                let average = total/Double(g.count)
                let roundedAverage = Double(round(100*average)/100)
                let normalRoundedAverage = String(format: "%.2f", roundedAverage)
                numbSolves[10].result = normalRoundedAverage
                self.tableView.reloadData()
            }
        }
        
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        numbOfSolves = TimerController.globalVariable.solveCount
        solveArray = TimerController.globalVariable.solveTimes
        self.tableView.reloadData()
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

        if solveArray.count > 4 {
            var fiveaverage : [Double] = []
            var bestAverage = 0.00
            var bestFiveArray : [Double] = []
            var sortedIntArray = intSolveArray
            for index in 0...(sortedIntArray!.count-5){
                fiveaverage = []
                for j in index...index+4 {
                    fiveaverage.append(sortedIntArray![j])
                }
                var m : [String] = []
                for item in fiveaverage {
                    m.append(String(item))
                }
                TimerController.globalVariable.BAO5 = m
                fiveaverage.remove(at: (fiveaverage.firstIndex(of: fiveaverage.min()!))!)
                fiveaverage.remove(at: (fiveaverage.firstIndex(of: fiveaverage.max()!))!)
                let total3 = fiveaverage.reduce(0,+)
                bestAverage = total3/3
                bestFiveArray.append(bestAverage)
            }
            let numberOneAverage = bestFiveArray.min()!
            let bestroundedAverage = Double(round(100*numberOneAverage)/100)
            let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
            numbSolves[5].result = bestnormalRoundedAverage
            
            
            
            let fiveArray = intSolveArray.suffix(5)
            let h = Array(fiveArray)
            var m : [String] = []
            for item in h {
                m.append(String(item))
            }
            TimerController.globalVariable.AO5 = m
            var g = fiveArray.sorted()
            g.remove(at:0)
            g.remove(at: fiveArray.count-2)
            let total = g.reduce(0, +)
            let average = total/Double(g.count)
            let roundedAverage = Double(round(100*average)/100)
            let normalRoundedAverage = String(format: "%.2f", roundedAverage)
            numbSolves[4].result = normalRoundedAverage
            self.tableView.reloadData()
        }
        
        if solveArray.count > 11 {
            var twelveaverage : [Double] = []
            var bestAverage = 0.00
            var bestTwelveArray : [Double] = []
            var sortedIntArray = intSolveArray
            for index in 0...(sortedIntArray!.count-12){
                twelveaverage = []
                for j in index...index+11 {
                    twelveaverage.append(sortedIntArray![j])
                }
                var m : [String] = []
                for item in twelveaverage {
                    m.append(String(item))
                }
                TimerController.globalVariable.BAO12 = m
                twelveaverage.remove(at: (twelveaverage.firstIndex(of: twelveaverage.min()!))!)
                twelveaverage.remove(at: (twelveaverage.firstIndex(of: twelveaverage.max()!))!)
                let total10 = twelveaverage.reduce(0,+)
                bestAverage = total10/10
                bestTwelveArray.append(bestAverage)
            }
            let numberOneAverage = bestTwelveArray.min()!
            let bestroundedAverage = Double(round(100*numberOneAverage)/100)
            let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
            numbSolves[7].result = bestnormalRoundedAverage
            
            
            
            let twelveArray = intSolveArray.suffix(12)
            let h = Array(twelveArray)
            var m : [String] = []
            for item in h {
                m.append(String(item))
            }
            TimerController.globalVariable.AO12 = m
            var g = twelveArray.sorted()
            g.remove(at:0)
            g.remove(at: twelveArray.count-2)
            let total = g.reduce(0, +)
            let average = total/Double(g.count)
            let roundedAverage = Double(round(100*average)/100)
            let normalRoundedAverage = String(format: "%.2f", roundedAverage)
            numbSolves[6].result = normalRoundedAverage
            self.tableView.reloadData()
        }
        
        if solveArray.count > 99 {
            var hundredaverage : [Double] = []
            var bestAverage = 0.00
            var bestHundredArray : [Double] = []
            var sortedIntArray = intSolveArray
            for index in 0...(sortedIntArray!.count-100){
                hundredaverage = []
                for j in index...index+99 {
                    hundredaverage.append(sortedIntArray![j])
                }
                var m : [String] = []
                for item in hundredaverage {
                    m.append(String(item))
                }
                TimerController.globalVariable.BAO100 = m
                hundredaverage.remove(at: (hundredaverage.firstIndex(of: hundredaverage.min()!))!)
                hundredaverage.remove(at: (hundredaverage.firstIndex(of: hundredaverage.max()!))!)
                let total98 = hundredaverage.reduce(0,+)
                bestAverage = total98/98
                bestHundredArray.append(bestAverage)
            }
            let numberOneAverage = bestHundredArray.min()!
            let bestroundedAverage = Double(round(100*numberOneAverage)/100)
            let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
            numbSolves[9].result = bestnormalRoundedAverage
            
            
            
            let hundredArray = intSolveArray.suffix(100)
            let h = Array(hundredArray)
            var m : [String] = []
            for item in h {
                m.append(String(item))
            }
            TimerController.globalVariable.AO100 = m
            var g = hundredArray.sorted()
            g.remove(at:0)
            g.remove(at: hundredArray.count-2)
            let total = g.reduce(0, +)
            let average = total/Double(g.count)
            let roundedAverage = Double(round(100*average)/100)
            let normalRoundedAverage = String(format: "%.2f", roundedAverage)
            numbSolves[10].result = normalRoundedAverage
            self.tableView.reloadData()
        }
        
        if solveArray.count > 999 {
            var thousandaverage : [Double] = []
            var bestAverage = 0.00
            var bestthousandArray : [Double] = []
            var sortedIntArray = intSolveArray
            for index in 0...(sortedIntArray!.count-1000){
                thousandaverage = []
                for j in index...index+999 {
                    thousandaverage.append(sortedIntArray![j])
                }
                var m : [String] = []
                for item in thousandaverage {
                    m.append(String(item))
                }
                TimerController.globalVariable.BAO1000 = m
                thousandaverage.remove(at: (thousandaverage.firstIndex(of: thousandaverage.min()!))!)
                thousandaverage.remove(at: (thousandaverage.firstIndex(of: thousandaverage.max()!))!)
                let total998 = thousandaverage.reduce(0,+)
                bestAverage = total998/998
                bestthousandArray.append(bestAverage)
            }
            let numberOneAverage = bestthousandArray.min()!
            let bestroundedAverage = Double(round(100*numberOneAverage)/100)
            let bestnormalRoundedAverage = String(format: "%.2f", bestroundedAverage)
            numbSolves[11].result = bestnormalRoundedAverage
            
            
            
            let thousandArray = intSolveArray.suffix(1000)
            let h = Array(thousandArray)
            var m : [String] = []
            for item in h {
                m.append(String(item))
            }
            TimerController.globalVariable.AO1000 = m
            var g = thousandArray.sorted()
            g.remove(at:0)
            g.remove(at: thousandArray.count-2)
            let total = g.reduce(0, +)
            let average = total/Double(g.count)
            let roundedAverage = Double(round(100*average)/100)
            let normalRoundedAverage = String(format: "%.2f", roundedAverage)
            numbSolves[10].result = normalRoundedAverage
            self.tableView.reloadData()
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
        var rowNumber = 0
        if TimerController.globalVariable.solveCount < 5 {
            rowNumber = 4
        }
        if TimerController.globalVariable.solveCount > 4 {
            rowNumber = 6
        }
        if TimerController.globalVariable.solveCount > 11 {
            rowNumber = 8
        }
        if TimerController.globalVariable.solveCount > 99 {
            rowNumber = 10
        }
        if TimerController.globalVariable.solveCount > 999 {
            rowNumber = 12
        }
        return rowNumber
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
