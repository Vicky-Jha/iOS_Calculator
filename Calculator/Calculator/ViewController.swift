//
//  ViewController.swift
//  Calculator
//
//  Created by Vicky Jha on 08/05/21.
//

import UIKit

enum Modes {
    case notSet
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: Modes = .notSet
    var SavedNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    func updateText() {
        
        if currentMode == .notSet {
            SavedNum = Int(labelString)!
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let labelInt: Int = Int(labelString)!
        
        let num: NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
        
    }
    
    func changeModes(newMode: Modes){
        if SavedNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true;
    }
    
    var hello: String?
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        if currentMode == .notSet {
            return
        }
        let newNum = Int(labelString)!
        
        switch currentMode {
        case .addition:
            SavedNum += newNum
        case .subtraction:
            SavedNum -= newNum
        case .multiplication:
            SavedNum *= newNum
        case .notSet:
            return
        }
        
        currentMode = .notSet
        labelString = "\(SavedNum)"
        updateText()
        
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        currentMode = .notSet
        SavedNum = 0
        lastButtonWasMode = false
        labelString = "0";
        updateText()
    }
    
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue: String = (sender.titleLabel?.text)!
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0";
        }
        
        if SavedNum == 0 || labelString == "0" {
            labelString = stringValue
        }else{
            labelString = labelString.appending(stringValue)
        }
        updateText()
    }
    
}

