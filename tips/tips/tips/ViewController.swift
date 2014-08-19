//
//  ViewController.swift
//  tips
//
//  Created by Scott Liu on 8/18/14.
//  Copyright (c) 2014 Scott Liu. All rights reserved.
//

import UIKit

var mainViewColor = [UIColor.greenColor(), UIColor.whiteColor()]

class ViewController: UIViewController {
    
    @IBOutlet weak var SplitView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmtFld: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var split2: UILabel!
    @IBOutlet weak var split3: UILabel!
    @IBOutlet weak var split4: UILabel!
    @IBOutlet weak var split5: UILabel!
    
    @IBOutlet weak var percentageCtrl: UISegmentedControl!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var splitViewColor = [UIColor.greenColor(), UIColor.whiteColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tipLabel.text="$0.00"
        //totalLabel.text="$0.00"
        
        percentageCtrl.selectedSegmentIndex = defaults.integerForKey(KEY_DEFAULT_PERCENT_INDEX)
        SplitView.hidden = true;
        
        mainViewColor[0] = self.view.backgroundColor
        splitViewColor[0] = SplitView.backgroundColor
        
        resetBackgroundColor()

    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        percentageCtrl.selectedSegmentIndex = defaults.integerForKey(KEY_DEFAULT_PERCENT_INDEX)
        calculateTip()
        
        resetBackgroundColor()
    }
    
    private func resetBackgroundColor()
    {
        var color_scheme_index = defaults.integerForKey(KEY_COLOR_SCHEME_INDEX)
        self.view.backgroundColor = mainViewColor[color_scheme_index]
        self.SplitView.backgroundColor = splitViewColor[color_scheme_index]
    }
    
    private func calculateTip()
    {
        let tipPercentages=[0.18, 0.2, 0.22]
        let amtString:NSString = billAmtFld.text
        var billAmt = amtString.doubleValue
        var percentage = tipPercentages[percentageCtrl.selectedSegmentIndex]
        var tip = billAmt*percentage
        var total = billAmt+tip
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"$%.2f", total)
        split2.text = String(format:"$%.2f", total/2)
        split3.text = String(format:"$%.2f", total/3)
        split4.text = String(format:"$%.2f", total/4)
        split5.text = String(format:"$%.2f", total/5)
        
        
    }

    @IBAction func AmtEditingChanged(sender: AnyObject) {
        calculateTip()
    }
    
    private func animateSplitView() {
        self.SplitView.alpha = 0
        var startFrame = self.SplitView.frame
        startFrame.origin.y += startFrame.size.height
        self.SplitView.frame = startFrame
        
        UIView.animateWithDuration(1.0, animations: {
            var endFrame = self.SplitView.frame
            endFrame.origin.y -= endFrame.size.height
            
            self.SplitView.alpha = 1
            self.SplitView.frame = endFrame
            
        })
    }
    
    @IBAction func OnTab(sender: AnyObject) {
        view.endEditing(true)
        SplitView.hidden = false
        animateSplitView()
    }
}

