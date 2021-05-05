//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
// @testable import CountOnMe
@testable import CountOnMe

// class CalculatorTestCase: XCTestCase {
class CalculatorTestCase: XCTestCase {
    var calculator: Calculator!
    var elements: [String] = []

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // Error Tests
    func testGiven156Plus_WhenCheckExpression_ThenLastElementIsOperatorAndExpressionIsNotCorrect() {
        elements.append("156")
        elements.append("+")

        XCTAssertFalse(calculator.checkExpressionHaveEnoughElement(elements))
        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements))
    }

    func testGiven156Minus_WhenCheckExpression_ThenLastElementIsOperatorAndExpressionIsNotCorrect() {
        elements.append("156")
        elements.append("-")

        XCTAssertFalse(calculator.checkExpressionHaveEnoughElement(elements))
        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements))
    }

    func testGiven156Multiplication_WhenCheckExpression_ThenLastElementIsOperatorAndExpressionIsNotCorrect() {
        elements.append("156")
        elements.append("×")

        XCTAssertFalse(calculator.checkExpressionHaveEnoughElement(elements))
        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements))
    }

    func testGiven156Division_WhenCheckExpression_ThenLastElementIsOperatorAndExpressionIsNotCorrect() {
        elements.append("156")
        elements.append("÷")

        XCTAssertFalse(calculator.checkExpressionHaveEnoughElement(elements))
        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements))
    }

    func testGiven156Division23Plus_WhenCheckExpression_ThenLastElementIsOperatorAndExpressionIsNotCorrect() {
        elements.append("156")
        elements.append("÷")
        elements.append("23")
        elements.append("+")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements))
    }

    // CALCUL TESTS
    // Simple Addition Give Positive Result
    func testGiven10Plus5_WhenCalculate_ThenResultIs15() {
        elements.append("10")
        elements.append("+")
        elements.append("5")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 15)
    }

    // Simple Substraction Give Positive Result
    func testGiven12Minus3_WhenCalculate_ThenResultIs9() {
        elements.append("12")
        elements.append("-")
        elements.append("3")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 9)
    }

    // Simple Multiplication Give Positive Result
    func testGiven3Times5_WhenCalculate_ThenResultIs15() {
        elements.append("3")
        elements.append("×")
        elements.append("5")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 15)
    }

    // Simple Division Give Positive Result
    func testGiven10DividedBy2_WhenCalculate_ThenResultIs5() {
        elements.append("10")
        elements.append("÷")
        elements.append("2")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 5)
    }

    // Simple Operation Give Negative Result
    func testGiven12Minus15_WhenCalculate_ThenResultIsMinus3() {
        elements.append("12")
        elements.append("-")
        elements.append("15")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), -3)
    }

    // Multiple Operation Addition And Substraction Give Positive Result
    func testGiven10Plus5Minus3Minus2_WhenCalculate_ThenResultIs10() {
        elements.append("10")
        elements.append("+")
        elements.append("5")
        elements.append("-")
        elements.append("3")
        elements.append("-")
        elements.append("2")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 10)
    }

    // Multiple Operation Addition and Multiplication Give Positive Result
    func testGiven10Plus5Times2_WhenCalculate_ThenResultIs20() {
        elements.append("10")
        elements.append("+")
        elements.append("5")
        elements.append("×")
        elements.append("2")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 20)
    }

    // Multiple Operation Substraction and Division Give Positive Result
    func testGiven12Minus10DividedBy2_WhenCalculate_ThenExpressionIsCorrectAndResultIs7() {
        elements.append("12")
        elements.append("-")
        elements.append("10")
        elements.append("÷")
        elements.append("2")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements))
        XCTAssertEqual(calculator.operation(elements), 7)
    }

//
//    internal func checkIfExpressionHaveResult(_ textView: String) -> Bool
//
//    internal func operation(_ elements: [String]) -> String
//
//    internal func isInteger(_ result: Double) -> Bool
//
//    internal func formatting(_ result: Double) -> String

}
