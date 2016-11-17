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
    @IBOutlet weak var padView: UIView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var upperOutputLabel: UILabel!
    
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    var currentOperation = Operation.Empty
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "0"
        upperOutputLabel.text = ""
        
        // Create a shadow effect in the pad view.
        padView.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.50).cgColor
        padView.layer.shadowOpacity = 1
        padView.layer.shadowOffset = CGSize.zero
        padView.layer.shadowRadius = 10
        padView.layer.shouldRasterize = true

        
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
    @IBAction func numberPressed(_ sender: UIButton!) {
        playSound()
        runningNumber += "\(sender.tag )"
        outputLabel.text = runningNumber
    }

    @IBAction func onDivide(_ sender: UIButton) {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiply(_ sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAdd(_ sender: UIButton) {
        processOperation(operation: .Add)
    }
    @IBAction func onSubtract(_ sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onEqualPressed(_ sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    @IBAction func onCleanButtonPressed(_ sender: UIButton) {
        restart()
    }
    //MARK: Methods
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func restart() {
        runningNumber = ""
        leftValueString = ""
        rightValueString = ""
        result = ""
        outputLabel.text = "0"
        currentOperation = Operation.Empty
        playSound()
        
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                
                // Prints the operation in the upper label.
                upperOutputLabel.text = "\(leftValueString) \(currentOperation.rawValue) \(rightValueString)"
                
                leftValueString = result
                outputLabel.text = result
            
            }
            currentOperation = operation

        } else {
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

