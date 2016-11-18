//
//  ViewController.swift
//  calculator
//
//  Created by Edgar on 11/15/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var outputLabel: UILabel!
    @IBOutlet private weak var upperOutputLabel: UILabel!
    
    private var btnSound: AVAudioPlayer!
    private var userIsTyping = false
    private var calculator = Operations()
    
    private var privatedisplayValue: Double {
        get {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return Double(formatter.number(from: outputLabel.text!)!)

        }
        
        set {
            outputLabel.text = String(newValue)
            userIsTyping = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       cleanDisplay()
        
        // Configuration for audio button.
        let path = Bundle.main.path(forResource: "tapMellow", ofType: "aif")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let soundError as NSError {
            print(soundError.debugDescription)
        }
    }
    
    // MARK: Actions
    @IBAction private func numberPressed(_ sender: UIButton!) {
        playSound()
        
        if outputLabel.text == "0" {
            outputLabel.text?.removeAll()
        }
        
        let number = sender.currentTitle!
        
        if userIsTyping && number != "." || number == "." && outputLabel.text!.range(of: ".") == nil {
            outputLabel.text = outputLabel.text! + number
        } else if number == "." {
            outputLabel.text = "0" + number
        } else {
            outputLabel.text = number
        }
        userIsTyping = true
        
    }
    
    @IBAction private func onCleanButtonPressed(_ sender: UIButton) {
        restart()
    }
    
    @IBAction private func processOperation(sender: UIButton) {
        playSound()
        
        if userIsTyping {
            calculator.setOperand(operand: privatedisplayValue)
        }
        userIsTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            calculator.performOperation(symbol: mathematicalSymbol)
        }
        
        privatedisplayValue = calculator.result
    }
    
    //MARK: Methods
    private func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    private  func restart() {
        playSound()
        cleanDisplay()
    }
    
    private func  cleanDisplay() {
        outputLabel.text = "0"
        upperOutputLabel.text = ""
    }
    
    
    
}








