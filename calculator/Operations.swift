//
//  Operations.swift
//  calculator
//
//  Created by Edgar on 11/17/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import Foundation

class Operations {
    
    private var pending: PendingBinaryOperationInfo?
    private var accumulator: Double = 0.0
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        
        // Common notation displayed in the main screen.
        "π" : Operation.Constant(M_PI),
        "√" : Operation.UnaryOperation(sqrt),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals,
        
        //Scientific notation displayed int the second screen.
        "cos" : Operation.UnaryOperation(cos),
        "℮" : Operation.Constant(M_E)

    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
            }
        }
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    // MARK: Methods
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    
    
    
}
