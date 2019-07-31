//
//  DescriptionController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/27/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit


class DescriptionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newArray = TimerController.globalVariable.solveTimes
    var newCount = TimerController.globalVariable.solveCount
    var currentAO5 = TimerController.globalVariable.AO5
    var bestAO5 = TimerController.globalVariable.BAO5
    var currentAO12 = TimerController.globalVariable.AO12
    var bestAO12 = TimerController.globalVariable.BAO12
    var currentAO100 = TimerController.globalVariable.AO100
    var bestAO100 = TimerController.globalVariable.BAO100
    var currentAO1000 = TimerController.globalVariable.AO1000
    var bestAO1000 = TimerController.globalVariable.BAO1000
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var descriptionTableView: UITableView!
    @IBOutlet var scrambleDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "\(numbSolves[indexNumber].title): \(numbSolves[indexNumber].result)"
        currentAO5 = TimerController.globalVariable.AO5
        bestAO5 = TimerController.globalVariable.BAO5
        currentAO12 = TimerController.globalVariable.AO12
        bestAO12 = TimerController.globalVariable.BAO12
        currentAO100 = TimerController.globalVariable.AO100
        bestAO100 = TimerController.globalVariable.BAO100
        currentAO1000 = TimerController.globalVariable.AO1000
        bestAO1000 = TimerController.globalVariable.BAO1000
        print(currentAO5)
        print(newArray)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainLabel.text! == "Best Time: \(numbSolves[indexNumber].result)" {
            newArray = [""]
        }
        if mainLabel.text! == "Worst Time: \(numbSolves[indexNumber].result)" {
            newArray = [""]
        }
        if (mainLabel.text! == "Current Average of 5: \(numbSolves[indexNumber].result)") || (mainLabel.text! == "Best Average of 5: \(numbSolves[indexNumber].result)"){
            newArray = Array(repeating: "", count: 5)
        }
        if (mainLabel.text! == "Current Average of 12: \(numbSolves[indexNumber].result)") || (mainLabel.text! == "Best Average of 12: \(numbSolves[indexNumber].result)") {
            newArray = Array(repeating: "", count: 12)
        }
        if (mainLabel.text! == "Current Average of 100: \(numbSolves[indexNumber].result)") || (mainLabel.text! == "Best Average of 100: \(numbSolves[indexNumber].result)") {
            newArray = Array(repeating: "", count: 100)
        }
        if (mainLabel.text! == "Current Average of 1000: \(numbSolves[indexNumber].result)") || (mainLabel.text! == "Best Average of 1000: \(numbSolves[indexNumber].result)") {
            newArray = Array(repeating: "", count: 1000)
        }
        return newArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath)
        if newCount == 0 {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        else {
            if mainLabel.text! == "Best Time: \(numbSolves[indexNumber].result)" {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfMin = newArray.firstIndex(of: newArray.min()!)
                cell.textLabel?.text = newArray.min()
                cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexOfMin!]
            }
            else if mainLabel.text! == "Worst Time: \(numbSolves[indexNumber].result)" {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfMax = newArray.firstIndex(of: newArray.max()!)
                cell.textLabel?.text = newArray.max()
                cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexOfMax!]
            }
            else if mainLabel.text! == "Current Average of 5: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 5 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 5 {
                    cell.textLabel?.text = currentAO5[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Best Average of 5: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 5 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 5 {
                    cell.textLabel?.text = bestAO5[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Current Average of 12: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 12 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 12 {
                    cell.textLabel?.text = currentAO12[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Best Average of 12: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 12 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 12 {
                    cell.textLabel?.text = bestAO12[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Current Average of 100: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 100 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 100 {
                    cell.textLabel?.text = currentAO100[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Best Average of 100: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 100 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 100 {
                    cell.textLabel?.text = bestAO100[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Current Average of 1000: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 1000 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 1000 {
                    cell.textLabel?.text = currentAO1000[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else if mainLabel.text! == "Best Average of 1000: \(numbSolves[indexNumber].result)" {
                if TimerController.globalVariable.solveCount == 1000 {
                    newArray = TimerController.globalVariable.solveTimes
                    cell.textLabel?.text = newArray[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
                if TimerController.globalVariable.solveCount > 1000 {
                    cell.textLabel?.text = bestAO1000[indexPath.row]
                    cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
                }
            }
            else {
                cell.textLabel?.text = newArray[indexPath.row]
                cell.detailTextLabel?.text = TimerController.globalVariable.dateAndTime[indexPath.row]
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        if mainLabel.text! == "Best Time: \(numbSolves[indexNumber].result)" {
            newArray = TimerController.globalVariable.solveTimes
            let indexOfMin = newArray.firstIndex(of: newArray.min()!)
            scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfMin!]
        }
        else if mainLabel.text! == "Worst Time: \(numbSolves[indexNumber].result)" {
            newArray = TimerController.globalVariable.solveTimes
            let indexOfMax = newArray.firstIndex(of: newArray.max()!)
            scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfMax!]
        }
        else if mainLabel.text! == "Current Average of 5: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 5 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 5 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfCAO5 = newArray.firstIndex(of: currentAO5[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfCAO5!]
            }
        }
        else if mainLabel.text! == "Best Average of 5: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 5 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 5 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfBAO5 = newArray.firstIndex(of: bestAO5[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfBAO5!]
            }
        }
        else if mainLabel.text! == "Current Average of 12: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 12 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 12 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfCAO12 = newArray.firstIndex(of: currentAO12[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfCAO12!]
            }
        }
        else if mainLabel.text! == "Best Average of 12: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 12 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 12 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfBAO12 = newArray.firstIndex(of: bestAO12[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfBAO12!]
            }
        }
        else if mainLabel.text! == "Current Average of 100: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 100 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 100 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfCAO100 = newArray.firstIndex(of: currentAO100[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfCAO100!]
                
            }
        }
        else if mainLabel.text! == "Best Average of 100: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 100 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 100 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfBAO100 = newArray.firstIndex(of: bestAO100[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfBAO100!]
            }
        }
        else if mainLabel.text! == "Current Average of 1000: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 1000 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 1000 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfCAO1000 = newArray.firstIndex(of: currentAO1000[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfCAO1000!]
            }
        }
        else if mainLabel.text! == "Best Average of 1000: \(numbSolves[indexNumber].result)" {
            if TimerController.globalVariable.solveCount == 1000 {
                newArray = TimerController.globalVariable.solveTimes
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
                
            }
            if TimerController.globalVariable.solveCount > 1000 {
                newArray = TimerController.globalVariable.solveTimes
                let indexOfBAO1000 = newArray.firstIndex(of: bestAO1000[indexPath.row])
                scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexOfBAO1000!]
            }
        }
        else {
            scrambleDesc.text! = TimerController.globalVariable.scrambleList[indexPath.row]
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        mainLabel.text = "\(numbSolves[indexNumber].title): \(numbSolves[indexNumber].result)"
        currentAO5 = TimerController.globalVariable.AO5
        bestAO5 = TimerController.globalVariable.BAO5
        currentAO12 = TimerController.globalVariable.AO12
        bestAO12 = TimerController.globalVariable.BAO12
        currentAO100 = TimerController.globalVariable.AO100
        bestAO100 = TimerController.globalVariable.BAO100
        currentAO1000 = TimerController.globalVariable.AO1000
        bestAO1000 = TimerController.globalVariable.BAO1000
        descriptionTableView.reloadData()
    }
    
    
}
