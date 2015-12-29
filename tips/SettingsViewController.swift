//
//  SettingsViewController.swift
//  tips
//
//  Created by Scott Kolodziej on 12/6/15.
//  Copyright © 2015 Scott Kolodziej. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var goodTipLabel: UILabel!
    @IBOutlet weak var neutralTipLabel: UILabel!
    @IBOutlet weak var badTipLabel: UILabel!
    
    @IBOutlet weak var goodTipSlider: UISlider!
    @IBOutlet weak var neutralTipSlider: UISlider!
    @IBOutlet weak var badTipSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultGoodTip:Int
        var defaultNeutralTip:Int
        var defaultBadTip:Int
        
        // Check if tips are stored in user defaults - if not, use 10/20/25%
        if defaults.objectForKey("defaultGoodTip") != nil {
            defaultGoodTip    = defaults.integerForKey("defaultGoodTip")
        }
        else {
            defaultGoodTip = 25
            defaults.setInteger(25, forKey: "defaultGoodTip")
        }
        
        if defaults.objectForKey("defaultNeutralTip") != nil {
            defaultNeutralTip    = defaults.integerForKey("defaultNeutralTip")
        }
        else {
            defaultNeutralTip = 20
            defaults.setInteger(20, forKey: "defaultNeutralTip")
        }
        
        if defaults.objectForKey("defaultBadTip") != nil {
            defaultBadTip    = defaults.integerForKey("defaultBadTip")
        }
        else {
            defaultBadTip = 10
            defaults.setInteger(10, forKey: "defaultBadTip")
        }
        
        goodTipSlider.value    = Float(defaultGoodTip)
        neutralTipSlider.value = Float(defaultNeutralTip)
        badTipSlider.value     = Float(defaultBadTip)
        
        goodTipSliderChanged(self)
        neutralTipSliderChanged(self)
        badTipSliderChanged(self)
    }
    
    @IBAction func goodTipSliderChanged(sender: AnyObject) {
        // Good tip slider has changed
        // Make sure good tip is greater than other tips
        if goodTipSlider.value <= neutralTipSlider.value {
            goodTipSlider.value = neutralTipSlider.value
        }
        goodTipLabel.text = String(format: "%d%%", Int(round(goodTipSlider.value)))
        
        let newDefaultTip = Int(round(goodTipSlider.value))
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(newDefaultTip, forKey: "defaultGoodTip")
    }
    
    @IBAction func neutralTipSliderChanged(sender: AnyObject) {
        // Neutral tip slider has changed
        // Make sure neutral tip is between good and bad tips
        if neutralTipSlider.value >= goodTipSlider.value {
            neutralTipSlider.value = goodTipSlider.value
        } else if neutralTipSlider.value <= badTipSlider.value {
            neutralTipSlider.value = badTipSlider.value
        }
        neutralTipLabel.text = String(format: "%d%%", Int(round(neutralTipSlider.value)))
        
        let newDefaultTip = Int(round(neutralTipSlider.value))
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(newDefaultTip, forKey: "defaultNeutralTip")
    }
    
    @IBAction func badTipSliderChanged(sender: AnyObject) {
        // Bad tip slider has changed
        // Make sure bad tip is less than other tips
        if badTipSlider.value >= neutralTipSlider.value {
            badTipSlider.value = neutralTipSlider.value
        }
        badTipLabel.text = String(format: "%d%%", Int(round(badTipSlider.value)))
        
        let newDefaultTip = Int(round(badTipSlider.value))
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(newDefaultTip, forKey: "defaultBadTip")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
