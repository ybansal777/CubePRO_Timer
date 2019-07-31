//
//  PopUpViewController.swift
//  CubePRO Timer
//
//  Created by Yash Bansal on 7/28/19.
//  Copyright © 2019 Yash Bansal. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }

}
