//
//  ViewController.swift
//  unit0
//
//  Created by administrator on 1/26/20.
//  Copyright © 2020 cst311. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var partyOneLabel: UILabel!
    @IBOutlet weak var partyTwoLabel: UILabel!
    @IBOutlet weak var partyThreeLabel: UILabel!
    @IBOutlet weak var partyFourLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {
        print("Hello")
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // get the bill amount
        let bill = Double(billTextField.text!) ?? 0
        
        // calculate the tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        partyOneLabel.text = String(format: "$%.2f", total)
        partyTwoLabel.text = String(format: "$%.2f", total / 2)
        partyThreeLabel.text = String(format: "$%.2f", total / 3)
        partyFourLabel.text = String(format: "$%.2f", total / 4)
    }
}

