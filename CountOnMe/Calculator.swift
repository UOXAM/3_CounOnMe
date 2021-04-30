//
//  Calcul.swift
//  CountOnMe
//
//  Created by ROUX Maxime on 29/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // Error check
    func checkLastElementIsNotOperator(_ elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    func checkExpressionIsCorrect(_ elements: [String]) -> Bool {
        return checkLastElementIsNotOperator(elements)
    }

    func checkExpressionHaveEnoughElement(_ elements: [String]) -> Bool {
        return elements.count >= 3
    }

    func checkIfCanAddOperator(_ elements: [String]) -> Bool {
        return checkLastElementIsNotOperator(elements)
    }

    func checkIfExpressionHaveResult(_ textView: String) -> Bool {
        return textView.firstIndex(of: "=") != nil
    }

    // Create local copy of operations
//    func operation (_ elements: [String]) -> String {
//        // Create local copy of operations
//        var operationsToReduce = elements
//
//        // Iterate over operations while an operand still here
//        while operationsToReduce.count > 1 {
//            let left = Double(operationsToReduce[0])!
//            let operand = operationsToReduce[1]
//            let right = Double(operationsToReduce[2])!
//            let result: Double
//
//            switch operand {
//            case "+": result = left + right
//            case "-": result = left - right
//            case "×": result = left * right
//            case "÷": result = left / right
//            default: fatalError("Unknown operator !")
//            }
//
//            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            operationsToReduce.insert("\(result)", at: 0)
//        }
//        return String(operationsToReduce.first!)
//    }

    func operation (_ elements: [String]) -> String {
        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here (multiplication or division)
        while operationsToReduce.count > 1 && verifyIfMultiplicationOrDivision(elements: operationsToReduce) {
            for index in 0...operationsToReduce.count - 1
            where operationsToReduce[index] == "×" || operationsToReduce[index] == "÷"{
                operationsToReduce.insert("\(calculate(elements: operationsToReduce, index))", at: index-1)
                operationsToReduce.removeSubrange(index...index+2)
                break
            }
        }
        
        // Iterate over operations while an operand still here (addition or substraction)
        while operationsToReduce.count > 1 {
            operationsToReduce.insert("\(calculate(elements: operationsToReduce, 1))", at: 0)
            operationsToReduce.removeSubrange(1...3)
        }

        return String(operationsToReduce.first!)
    }

    // Verifiy if the operation contains multiplication or substraction
    private func verifyIfMultiplicationOrDivision(elements: [String]) -> Bool {
        var test: Bool = false
        for index in 0...elements.count - 1
        where elements[index] == "×" || elements[index] == "÷" {
            test = true
        }
        return test
    }
    
    // calculate the operation of 2 elements
    private func calculate(elements: [String], _ index: Int) -> Double {
        let left = Double(elements[index-1])!
        let operand = elements[index]
        let right = Double(elements[index+1])!
        let result: Double

        switch operand {
        case "×": result = left * right
        case "÷": result = left / right
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }

        return result
    }
}
