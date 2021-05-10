//
//  Calcul.swift
//  CountOnMe
//
//  Created by ROUX Maxime on 29/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

    var result: Int = 0
    var isResult: Bool = false

    // MARK: Error check
    func checkLastElementIsNotOperator(_ elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    func checkExpressionIsEmpty(_ elements: [String]) -> Bool {
        return elements.count == 0
    }

    func checkExpressionHaveEnoughElement(_ elements: [String]) -> Bool {
        return elements.count >= 3
    }

    func checkOperationIsImpossible(_ elements: [String], _ textView: String) -> Bool {
        let numberOfElements = elements.count
        return (elements[numberOfElements-2] == "÷" && Double(elements[numberOfElements-1]) == 0.0)
            || textView.contains(" ÷ 0 ")
    }

    func checkExpressionIsCorrect(_ elements: [String], _ textView: String) -> Bool {
        return checkLastElementIsNotOperator(elements) && !checkExpressionIsEmpty(elements)
            && !checkOperationIsImpossible(elements, textView)
    }

    func checkIfJustFirstPartOfOperation(_ elements: [String]) -> Bool {
        return elements.count == 1
    }

    func checkIfAlreadyResult(_ elements: [String]) -> Bool {
        return elements.contains("=")
    }

    // MARK: Calculation
    func operation (_ elements: [String]) -> Double {
        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here (multiplication or division)
        while operationsToReduce.count > 1 && verifyIfMultiplicationOrDivision(elements: operationsToReduce) {
            for index in 0...operationsToReduce.count - 1
            where operationsToReduce[index] == "×" || operationsToReduce[index] == "÷"{
                reduceElements(&operationsToReduce, index)
                break
            }
        }

        // Iterate over operations while an operand still here (addition or substraction)
        while operationsToReduce.count > 1 {
            reduceElements(&operationsToReduce, 1)
        }

        let result = Double(operationsToReduce[0])!
        return result
    }

    // Iterate operation : delete elements and put the result in the table
    private func reduceElements(_ elements: inout [String], _ index: Int) {
        elements.insert("\(calculate(elements: elements, index))", at: index-1)
        elements.removeSubrange(index...index+2)
    }

    // Check if the operation contains multiplication or substraction
    private func verifyIfMultiplicationOrDivision(elements: [String]) -> Bool {
        return (elements.contains("×") || elements.contains("÷"))
    }

    // Calculate the operation of 2 elements
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

    // Formate the result (if Integer -> Integer, if Double -> Round)
    func formatting(_ result: Double) -> String {
        if isInteger(result) {
            return "\(changeToInteger(result))"
        } else {
            return "\(roundToXDecimals(result, 2))"
        }
    }

    // Check if the result is an Integer (of type Double)
    func isInteger(_ result: Double) -> Bool {
        result == round(result)
    }

    // Return Integer
    private func changeToInteger(_ result: Double) -> String {
        return String(Int(result))
    }

    // Return Round x decimals
    private func roundToXDecimals(_ result: Double, _ decimals: Double) -> String {
        let power = Double(pow(10.0, decimals))
        return "\((round(power * result) / power))"
    }
}
