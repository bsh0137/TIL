//
//  ViewController.swift
//  HelloWorld
//
//  Created by 백성현 on 2021/07/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var textField: UITextField!
    @IBOutlet var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        textField.delegate = self
    }

    @IBAction func btnSend(_ sender: Any) {
        text.text = "\(textField.text!) 씨 반갑습니다."
    }ㅂ
    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return true
//    }

}

