//
//  SettingsViewController.swift
//  tipsy
//
//  Created by Lia Zadoyan on 7/31/17.
//  Copyright © 2017 Lia Zadoyan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet private weak var defaultTipControl: UISegmentedControl!
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let defaultTipIndex = defaults.object(forKey: UserDefaultKeys.defaultTipIndex) as? Int {
            defaultTipControl.selectedSegmentIndex = defaultTipIndex
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Methods
    
    @IBAction func defaultTipChosen(_ sender: Any) {
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: UserDefaultKeys.defaultTipIndex)
        defaults.synchronize()
    }
}
