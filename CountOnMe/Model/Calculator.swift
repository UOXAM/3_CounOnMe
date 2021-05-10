//
//  Calcul.swift
//  CountOnMe
//
//  Created by ROUX Maxime on 29/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

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
        return (elements[numberOfElements-2] == "÷" && Float(elements[numberOfElements-1]) == 0.0)
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
    func operation (_ elements: [String]) -> Float {
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

        let result = Float(operationsToReduce[0])!
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
    private func calculate(elements: [String], _ index: Int) -> Float {
        let left = Float(elements[index-1])!
        let operand = elements[index]
        let right = Float(elements[index+1])!
        let result: Float

        switch operand {
        case "×": result = left * right
        case "÷": result = left / right
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }

        return result
    }

    // Formate the result (if Integer -> Integer, if Float -> Round)
    func formatting(_ result: Float) -> String {
        if isInteger(result) {
            return "\(changeToInteger(result))"
        }
            return "\(roundToXDecimals(result, 2))"
    }

    // Check if the result is an Integer (of type Float)
    func isInteger(_ result: Float) -> Bool {
        result == round(result)
    }

    // Return Integer
    private func changeToInteger(_ result: Float) -> String {
        return String(format: "%.0f", result)
    }

    // Return Round x decimals
    private func roundToXDecimals(_ result: Float, _ decimals: Float) -> String {
        let power = Float(pow(10.0, decimals))
        return "\((round(power * result) / power))"
    }
}

// COMMENT ADAPTER LA TAILLE DE LA POLICE SELON LE NOMBRE DE CARACTÈRES DANS LE TEXTVIEW ?
// COMMENT FAIRE UN TEST UNITAIRE SUR LA LIGNE 91"default: fatalError("Unknown operator !")" ?
// COMMENT GÉRER LES NOMBRES TROP IMPORTANTS
