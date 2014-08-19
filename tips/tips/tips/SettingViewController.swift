//
//  SettingViewController.swift
//  tips
//
//  Created by Scott Liu on 8/18/14.
//  Copyright (c) 2014 Scott Liu. All rights reserved.
//

import UIKit

let KEY_DEFAULT_PERCENT_INDEX = "Default_Percentage_Index"
let KEY_COLOR_SCHEME_INDEX = "Color_Scheme_Index"

class SettingViewController: UIViewController {

    @IBOutlet weak var DefaultPercentCtrl: UISegmentedControl!
    
    @IBOutlet weak var ColorSchemeCtrl: UISegmentedControl!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DefaultPercentCtrl.selectedSegmentIndex = defaults.integerForKey(KEY_DEFAULT_PERCENT_INDEX)
        
        ColorSchemeCtrl.selectedSegmentIndex = defaults.integerForKey(KEY_COLOR_SCHEME_INDEX)
        
        resetBackgroundColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtn_OnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func OnDefaultPercentValueChanged(sender: AnyObject) {
        
        defaults.setInteger(DefaultPercentCtrl.selectedSegmentIndex, forKey: KEY_DEFAULT_PERCENT_INDEX)
        defaults.synchronize()
    }
    
    @IBAction func OnColorSchemeValueChanged(sender: AnyObject) {
        
        defaults.setInteger(ColorSchemeCtrl.selectedSegmentIndex, forKey: KEY_COLOR_SCHEME_INDEX)
        defaults.synchronize()
        resetBackgroundColor()
    }
    
    private func resetBackgroundColor()
    {
        var color_scheme_index = ColorSchemeCtrl.selectedSegmentIndex
        self.view.backgroundColor = mainViewColor[color_scheme_index]
    }



}
