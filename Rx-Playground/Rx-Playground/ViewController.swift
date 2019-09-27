//
//  ViewController.swift
//  Rx-Playground
//
//  Created by Edgar Allan Fojas on 16/9/19.
//  Copyright © 2019 Edgar Allan Fojas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Imperative
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        inputA.delegate = self
//        inputB.delegate = self
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let x = textField == inputA ? string : inputA.text
//        let y = textField == inputB ? string : inputB.text
//
//        if let x = x, let y = y,
//            let intX = Int(x), let intY = Int(y) {
//            resultLabel.text = "\(intX + intY)"
//        }
//        else {
//            resultLabel.text = ""
//        }
//
//
//        return true
//    }
    
    // Imperative
//    var x: Int?
//    var y: Int?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        inputA.delegate = self
//        inputB.delegate = self
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == inputA {
//            x = Int(string)
//        }
//        if textField == inputB {
//            y = Int(string)
//        }
//
//        updateResult(x: x, y: y)
//        return true
//    }
//
//    func updateResult(x: Int?, y: Int?) {
//        guard let x = x, let y = y else {
//            resultLabel.text = ""
//            return
//        }
//
//        resultLabel.text = "\(x + y)"
//    }
    
//    let disposeBag = DisposeBag()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let x = inputA.rx.text.orEmpty.map({ return Int($0) })
//        let y = inputB.rx.text.orEmpty.map({ return Int($0) })
//        
//        Observable.combineLatest(x, y)
//            .map { (arg) -> String? in
//                let (x, y) = arg
//                guard let intX = x, let intY = y else {
//                    return nil
//                }
//                
//                return "\(intX + intY)"
//            }
//            .bind(to: resultLabel.rx.text)
//            .disposed(by: disposeBag)
//    }

//    func getSum(x: Int?, y: Int?) -> Int? {
//        guard let x = x, let y = y else {
//            return nil
//        }
//
//        return x + y
//    }

}


//    var x: Int? {
//        didSet {
//            updateResult(x: x, y: y)
//        }
//    }
//
//    var y: Int? {
//        didSet {
//            updateResult(x: x, y: y)
//        }
//    }

