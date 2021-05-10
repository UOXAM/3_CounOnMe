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
    var textView: String = ""

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // MARK: TESTS
    // Test last element is Operator
    func testGiven156Plus_WhenCheckExpression_ThenLastElementIsOperator() {
        elements.append("156")
        elements.append("+")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
    }

    func testGiven156Minus_WhenCheckExpression_ThenLastElementIsOperator() {
        elements.append("156")
        elements.append("-")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
    }

    func testGiven156Multiplication_WhenCheckExpression_ThenLastElementIsOperator() {
        elements.append("156")
        elements.append("×")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
    }

    func testGiven156Division_WhenCheckExpression_ThenLastElementIsOperator() {
        elements.append("156")
        elements.append("÷")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
    }

    func testGiven156Division23Plus_WhenCheckExpression_ThenLastElementIsOperator() {
        elements.append("156")
        elements.append("÷")
        elements.append("23")
        elements.append("+")

        XCTAssertFalse(calculator.checkLastElementIsNotOperator(elements))
    }

    func testGiven156Division23Plus_WhenCheckExpression_ThenLastElementIsNotOperator() {
        elements.append("156")
        elements.append("÷")
        elements.append("23")
        elements.append("+")
        elements.append("23")

        XCTAssertTrue(calculator.checkLastElementIsNotOperator(elements))
    }

    // Test Expression is empty
    func testGivenNothing_WhenCheckExpression_ThenExpressionIsEmpty() {

        XCTAssertTrue(calculator.checkExpressionIsEmpty(elements))
    }

    // Test Expression has enough elements (>= 3)
    func testGiven1plus10_WhenCheckExpression_ThenExpressionHaveEnoughElements() {
        elements.append("1")
        elements.append("+")
        elements.append("10")

        XCTAssertTrue(calculator.checkExpressionHaveEnoughElement(elements))
    }

    func testGiven1plus10minus20_WhenCheckExpression_ThenExpressionHaveEnoughElements() {
        elements.append("1")
        elements.append("+")
        elements.append("10")
        elements.append("-")
        elements.append("20")

        XCTAssertTrue(calculator.checkExpressionHaveEnoughElement(elements))
    }

    func testGiven1plus_WhenCheckExpression_ThenExpressionHaveEnoughElements() {
        elements.append("1")
        elements.append("+")

        XCTAssertFalse(calculator.checkExpressionHaveEnoughElement(elements))
    }

    // Test Operation is impossible
    func testGiven25dividedBy0_WhenCheckExpression_ThenExpressionIsImpossible() {
        elements.append("25")
        elements.append("÷")
        elements.append("0")
        textView = "25 ÷ 0"

        XCTAssertTrue(calculator.checkOperationIsImpossible(elements, textView))
    }

    func testGiven25dividedBy0Plus1_WhenCheckExpression_ThenExpressionIsImpossible() {
        elements.append("25")
        elements.append("÷")
        elements.append("0")
        elements.append("+")
        elements.append("1")
        textView = "25 ÷ 0 + 1"

        XCTAssertTrue(calculator.checkOperationIsImpossible(elements, textView))
    }

    func testGiven25dividedBy03Plus1_WhenCheckExpression_ThenExpressionIsPossible() {
        elements.append("25")
        elements.append("÷")
        elements.append("03")
        elements.append("+")
        elements.append("1")
        textView = "25 ÷ 03 + 1"

        XCTAssertFalse(calculator.checkOperationIsImpossible(elements, textView))
    }

    // Test Expression is Correct
    func testGiven25dividedBy3Plus10_WhenCheckExpression_ThenExpressionIsCorrect() {
        elements.append("25")
        elements.append("÷")
        elements.append("3")
        elements.append("+")
        elements.append("10")
        textView = "25 ÷ 3 + 10"

        XCTAssertTrue(calculator.checkExpressionIsCorrect(elements, textView))
    }

    func testGiven25dividedBy3Plus10_WhenCheckExpression_ThenExpressionIsNotCorrect() {
        elements.append("25")
        elements.append("÷")
        elements.append("3")
        elements.append("+")
        elements.append("10")
        elements.append("-")
        textView = "25 ÷ 3 + 10 -"

        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements, textView))
    }

    func testGiven25dividedBy_WhenCheckExpression_ThenExpressionIsNotCorrect() {
        elements.append("25")
        elements.append("÷")
        textView = "25 ÷ "

        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements, textView))
    }

    func testGivenNothing_WhenCheckExpression_ThenExpressionIsNotCorrect() {
        textView = ""

        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements, textView))
    }

    func testGiven25dividedBy0Plus10_WhenCheckExpression_ThenExpressionIsNotCorrect() {
        elements.append("25")
        elements.append("÷")
        elements.append("0")
        elements.append("+")
        elements.append("10")
        textView = "25 ÷ 0 + 10"

        XCTAssertFalse(calculator.checkExpressionIsCorrect(elements, textView))
    }

    // Test Operation is composed by just first part
    func testGiven25_WhenCheckExpression_ThenExpressionHasJustFirstPart() {
        elements.append("25")

        XCTAssertTrue(calculator.checkIfJustFirstPartOfOperation(elements))
    }

    func testGiven25Plus_WhenCheckExpression_ThenExpressionHasJustFirstPart() {
        elements.append("25")
        elements.append("+")

        XCTAssertFalse(calculator.checkIfJustFirstPartOfOperation(elements))
    }

    // Test Operation has already a result
    func testGiven25Plus5Equal30_WhenCheckExpression_ThenOperationHasAlreadyResult() {
        elements.append("25")
        elements.append("+")
        elements.append("5")
        elements.append("=")
        elements.append("30")

        XCTAssertTrue(calculator.checkIfAlreadyResult(elements))
    }

    func testGiven25Plus5Minus5_WhenCheckExpression_ThenOperationHasAlreadyResult() {
        elements.append("25")
        elements.append("+")
        elements.append("5")
        elements.append("_")
        elements.append("5")

        XCTAssertFalse(calculator.checkIfAlreadyResult(elements))
    }

    // MARK: Operation
    // Simple Addition Give Positive Result
    func testGiven10Plus5_WhenCalculate_ThenResultIs15() {
        elements.append("10")
        elements.append("+")
        elements.append("5")

        XCTAssertEqual(calculator.operation(elements), 15)
    }

    // Simple Substraction Give Positive Result
    func testGiven12Minus3_WhenCalculate_ThenResultIs9() {
        elements.append("12")
        elements.append("-")
        elements.append("3")

        XCTAssertEqual(calculator.operation(elements), 9)
    }

    // Simple Multiplication Give Positive Result
    func testGiven3Times5_WhenCalculate_ThenResultIs15() {
        elements.append("3")
        elements.append("×")
        elements.append("5")

        XCTAssertEqual(calculator.operation(elements), 15)
    }

    // Simple Division Give Positive Result
    func testGiven10DividedBy2_WhenCalculate_ThenResultIs5() {
        elements.append("10")
        elements.append("÷")
        elements.append("2")

        XCTAssertEqual(calculator.operation(elements), 5)
    }

    // Simple Operation Give Negative Result
    func testGiven12Minus15_WhenCalculate_ThenResultIsMinus3() {
        elements.append("12")
        elements.append("-")
        elements.append("15")

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

        XCTAssertEqual(calculator.operation(elements), 10)
    }

    // Multiple Operation Addition and Multiplication Give Positive Result
    func testGiven10Plus5Times2_WhenCalculate_ThenResultIs20() {
        elements.append("10")
        elements.append("+")
        elements.append("5")
        elements.append("×")
        elements.append("2")

        XCTAssertEqual(calculator.operation(elements), 20)
    }

    // Multiple Operation Substraction and Division Give Positive Result
    func testGiven12Minus10DividedBy2_WhenCalculate_ThenExpressionIsCorrectAndResultIs7() {
        elements.append("12")
        elements.append("-")
        elements.append("10")
        elements.append("÷")
        elements.append("2")

        XCTAssertEqual(calculator.operation(elements), 7)
    }

    // MARK: Formatting
    func testGivenResultDouble10_WhenCFormatting_ThenString10() {
        let result: Float = 10

        XCTAssertEqual(calculator.formatting(result), "10")
    }

    func testGivenResultDouble10Point0_WhenCFormatting_ThenString10() {
        let result: Float = 10.0

        XCTAssertEqual(calculator.formatting(result), "10")
    }

    func testGivenResultDouble15Point5_WhenCFormatting_ThenString15Point5() {
        let result: Float = 15.5

        XCTAssertEqual(calculator.formatting(result), "15.5")
    }

    func testGivenResultDouble15Point53_WhenCFormatting_ThenString15Point53() {
        let result: Float = 15.53

        XCTAssertEqual(calculator.formatting(result), "15.53")
    }

    func testGivenResultDouble15Point566_WhenCFormatting_ThenString15Point57() {
        let result: Float = 15.566

        XCTAssertEqual(calculator.formatting(result), "15.57")
    }

    func testGivenResultDouble15Point5_WhenCFormatting_ThenString15Point67() {
        let result: Float = 15.672

        XCTAssertEqual(calculator.formatting(result), "15.67")
    }
}
