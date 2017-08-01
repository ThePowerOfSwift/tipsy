//
//  ViewController.swift
//  tipsy
//
//  Created by Lia Zadoyan on 7/31/17.
//  Copyright © 2017 Lia Zadoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    private var bill = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        bill = Double(billField.text!) ?? 0
        updateTip()
    }
    
    private func updateTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let intValue = defaults.object(forKey: "default_tip_index")
        var timeAppClosed = defaults.object(forKey: "time_app_closed") as? Int
        if (timeAppClosed == nil) {
            timeAppClosed = 0
        }
        let currentTime = Int(NSDate().timeIntervalSince1970)
        if (intValue != nil) {
            tipControl.selectedSegmentIndex = intValue as! Int
            updateTip()
        }
        if (currentTime - timeAppClosed! < 600) {
            billField.text = defaults.object(forKey: "bill_last_closed") as? String
            bill = Double(billField.text!) ?? 0
            tipControl.selectedSegmentIndex = defaults.object(forKey: "percentage_last_closed") as! Int
            updateTip()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = UserDefaults.standard
        
        defaults.set(Int(NSDate().timeIntervalSince1970), forKey: "time_app_closed")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "percentage_last_closed")
        defaults.set(billField.text, forKey: "bill_last_closed")
        
        defaults.synchronize()
    }
}

