//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    enum Message {
        case operandAlreadyPut
        case incorrectExpression
        case startNewCalculation
    }

    func getAlertMessage(_ message: Message) -> String? {
        if message == .operandAlreadyPut {
            return "Un opérateur est déjà mis !"
        } else if message == .incorrectExpression {
            return "Entrez une expression correcte !"
        } else if message == .startNewCalculation {
            return "Démarrez un nouveau calcul !"
        } else {
            return nil
        }
    }

    func alert(message: Message) -> UIAlertController {
        let alertVC = UIAlertController(title: "Zéro!", message: getAlertMessage(message), preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alertVC
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        if calculator.checkIfExpressionHaveResult(textView.text) {
            textView.text = ""
        }

        textView.text.append(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.checkIfCanAddOperator(elements) {
            textView.text.append(" + ")
        } else {
            self.present(alert(message: .operandAlreadyPut), animated: true, completion: nil)
        }
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        textView.text = ""
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.checkIfCanAddOperator(elements) {
            textView.text.append(" - ")
        } else {
            self.present(alert(message: .operandAlreadyPut), animated: true, completion: nil)
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.checkIfCanAddOperator(elements) {
            textView.text.append(" × ")
        } else {
            self.present(alert(message: .operandAlreadyPut), animated: true, completion: nil)
        }
    }

    @IBAction func tappedDivisonButton(_ sender: UIButton) {
        if calculator.checkIfCanAddOperator(elements) {
            textView.text.append(" ÷ ")
        } else {
            self.present(alert(message: .operandAlreadyPut), animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.checkExpressionIsCorrect(elements) else {
            return self.present(alert(message: .incorrectExpression), animated: true, completion: nil)
        }

        guard calculator.checkExpressionHaveEnoughElement(elements) else {
            return self.present(alert(message: .startNewCalculation), animated: true, completion: nil)

        }

        let result = calculator.operation(elements)
        textView.text.append(" = \(calculator.formatting(result))")
    }
}
