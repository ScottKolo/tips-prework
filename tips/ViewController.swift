//
//  ViewController.swift
//  tips
//
//  Created by Scott Kolodziej on 12/6/15.
//  Copyright © 2015 Scott Kolodziej. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    
    // Stored good/neutral/bad tip percentages
    var goodTip: Int = 25
    var neutralTip: Int = 20
    var badTip: Int = 10
    
    func getTipPercentage() -> Int {
        // Get tip percentage from slider position and good/neutral/bad tip values
        let sliderPosition = tipSlider.value
        if sliderPosition < 0.5 {
            return Int(round(Float(badTip) + Float(neutralTip - badTip)*sliderPosition*2))
        }
        else {
            return Int(round(Float(neutralTip) + Float(goodTip - neutralTip)*(sliderPosition-0.5)*2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "fabric_of_squares_gray_@2X.png") {
            view.backgroundColor = UIColor(patternImage: image)
        } else {
            print("There was no such image as small_steps.png")
        }
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipSlider.value = 0.5
        onTipSliderChange(self) // Update slider UI
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentage = Float(getTipPercentage())/100
        
        let billAmount = NSString(string: billField.text!).floatValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get user defaults for good/neutral/bad tip values
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Check if tips are stored in user defaults - if not, use 10/20/25%
        if defaults.objectForKey("defaultGoodTip") != nil {
            goodTip    = defaults.integerForKey("defaultGoodTip")
        }
        else {
            goodTip = 25
            defaults.setInteger(25, forKey: "defaultGoodTip")
        }
        
        if defaults.objectForKey("defaultNeutralTip") != nil {
            neutralTip    = defaults.integerForKey("defaultNeutralTip")
        }
        else {
            neutralTip = 20
            defaults.setInteger(20, forKey: "defaultNeutralTip")
        }
        
        if defaults.objectForKey("defaultBadTip") != nil {
            badTip    = defaults.integerForKey("defaultBadTip")
        }
        else {
            badTip = 10
            defaults.setInteger(10, forKey: "defaultBadTip")
        }

        
        
        goodTip = defaults.integerForKey("defaultGoodTip")
        neutralTip = defaults.integerForKey("defaultNeutralTip")
        badTip = defaults.integerForKey("defaultBadTip")
        
        tipSlider.value = 0.5   // Reset tip back to neutral
        onTipSliderChange(self) // Update slider UI
    }
    
    @IBAction func onTipSliderChange(sender: AnyObject) {
        tipPercentLabel.text = String(format: "%d%%", getTipPercentage())
        onEditingChanged(self)
    }
}

