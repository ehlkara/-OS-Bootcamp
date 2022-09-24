//
//  ViewController.swift
//  Week2Day1
//
//  Created by Ehlullah Karakurt on 24.09.2022.
//

import UIKit

final class ViewController: UIViewController {
    
//    var displayValue: String? {
//        get{
//            displayLabel.text
//        }
//        set {
//            displayLabel.text?.append(newValue ?? "")
//        }
//    }

    @IBOutlet private weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(sumInt(firstNumber: 5, secondNumber: 3))
        
        print(sum(firstNumber: 3.13, secondNumber: 9.8))
    }
    func sumInt(firstNumber: Int, secondNumber:Int) -> Int {
        firstNumber + secondNumber
    }
    func sumDouble(firstNumber: Double, secondNumber:Double) -> Double {
        firstNumber + secondNumber
    }
    
    func sum<T: Numeric>(firstNumber: T, secondNumber:T) -> T {
        firstNumber + secondNumber
    }
    @IBAction private func didTapDigitButton(_ sender: UIButton) {
        guard let digit = sender.currentTitle
        else {
            return
        }
        
        displayLabel.text! += "\(digit)"
    }
}

