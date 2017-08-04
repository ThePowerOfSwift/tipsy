//
//  ViewController.swift
//  tipsy
//
//  Created by Lia Zadoyan on 7/31/17.
//  Copyright © 2017 Lia Zadoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tipLabel: UILabel!
    
    @IBOutlet private weak var totalLabel: UILabel!
    
    @IBOutlet private weak var billField: UITextField!
    @IBOutlet private weak var tipControl: UISegmentedControl!
    
    private var bill = 0.0
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the last time the view closed
        let timeAppClosed = defaults.object(forKey: UserDefaultKeys.timeAppClosed) as? Int ?? 0
        // Set the default tip option if one exists, else default to 18%
        if let defaultTipIndex = defaults.object(forKey: UserDefaultKeys.defaultTipIndex) as? Int {
            tipControl.selectedSegmentIndex = defaultTipIndex
            updateTip()
        }
        // Get the current time
        let currentTime = Int(NSDate().timeIntervalSince1970)
        // Check if enough time has passed to update the view
        if currentTime - timeAppClosed < 600,
            let billLastClosed = defaults.object(forKey: UserDefaultKeys.billLastClosed) as? String,
            let percentageLastClosed = defaults.object(forKey: UserDefaultKeys.percentageLastClosed) as? Int {
            // Set bill
            billField.text = billLastClosed
            bill = Double(billLastClosed) ?? 0
            // Set tip percentage
            tipControl.selectedSegmentIndex = percentageLastClosed
            // Update view
            updateTip()
        }
         billField.becomeFirstResponder()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Button Methods
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        defaults.set(tipControl.selectedSegmentIndex, forKey: UserDefaultKeys.percentageLastClosed)
        defaults.set(billField.text, forKey: UserDefaultKeys.billLastClosed)
        defaults.synchronize()
        if let billFieldText = billField.text,
            let billFieldValue = Double(billFieldText) {
            bill = billFieldValue
        }
        updateTip()
    }
    
    // MARK: - Private Methods
    
    private func updateTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
