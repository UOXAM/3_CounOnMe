//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Variables
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    private var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Errors

    // Error messages
    private enum Message {
        case operandAlreadyPut
        case incorrectExpression
        case startNewCalculation
        case noExpression
        case operationIsImpossible

        func getAlertMessage() -> String? {
            if self == .operandAlreadyPut {
                return "Un opérateur est déjà mis !"
            } else if self == .noExpression {
                return "Entrez une expression !"
            } else if self == .incorrectExpression {
                return "Entrez une expression correcte !"
            } else if self == .startNewCalculation {
                return "Démarrez un nouveau calcul !"
            } else if self == .operationIsImpossible {
                return "Impossible de diviser un nombre par 0, Démarrez un nouveau calcul !"
            } else {
                return nil
            }
        }
    }

    // Pop up alert
    private func alert(message: Message) -> UIAlertController {
        let alertVC = UIAlertController(title: "Zéro!", message: message.getAlertMessage(), preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }

    // Check if expression is correct when the user tap on Operand
    private func checkOperator(_ operand: String) {
        if calculator.checkExpressionIsEmpty(elements) {
            self.present(alert(message: .incorrectExpression), animated: true, completion: nil)
        } else if calculator.checkLastElementIsNotOperator(elements) {
            if calculator.checkIfAlreadyResult(elements) {
                textView.text = "\(elements.last!) \(operand) "
            } else {
                textView.text.append(" \(operand) ")
            }
        } else {
            self.present(alert(message: .operandAlreadyPut), animated: true, completion: nil)
        }
    }

    // MARK: View actions

    // Numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculator.checkIfAlreadyResult(elements) {
            textView.text = ""
        }
        textView.text.append(numberText)
    }

    // Reset
    @IBAction func tappedResetButton(_ sender: UIButton) {
        textView.text = ""
    }

    // Operand
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
       checkOperator("+")
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        checkOperator("-")
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        checkOperator("×")
    }

    @IBAction func tappedDivisonButton(_ sender: UIButton) {
        checkOperator("÷")
    }

    // Equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard !calculator.checkExpressionIsEmpty(elements) else {
            return self.present(alert(message: .noExpression), animated: true, completion: nil)
        }
        guard !calculator.checkIfAlreadyResult(elements) &&
                !calculator.checkIfJustFirstPartOfOperation(elements)  else {
            return
        }
        guard !calculator.checkOperationIsImpossible(elements, textView.text) else {
            textView.text = ""
            return self.present(alert(message: .operationIsImpossible), animated: true, completion: nil)
        }
        guard calculator.checkExpressionIsCorrect(elements, textView.text) else {
            return self.present(alert(message: .incorrectExpression), animated: true, completion: nil)
        }
        let result = calculator.operation(elements)
        textView.text.append(" = \(calculator.formatting(result))")
    }
}
