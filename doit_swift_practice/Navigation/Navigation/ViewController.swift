//
//  ViewController.swift
//  Navigation
//
//  Created by 백성현 on 2021/07/25.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    let imgOn = UIImage(named: "bulb_on.jpeg")
    let imgOff = UIImage(named: "bulb_off.jpeg")
    
    var isOn = true
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
        
    }

    @IBAction func btnEdit(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! SecondViewController
        if segue.identifier == "editButton" {
            secondViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            secondViewController.textWayValue = "segue: use Bar button"
        }
        
        secondViewController.textMessage = txtField.text!
        secondViewController.isOn = isOn
        secondViewController.delegate = self
    }
    
    func didMessageEditOne(_ controller: SecondViewController, message: String) {
        txtField.text = message
    }
    
    func didImageOnOffDone(_ controller: SecondViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
}
/// 이건 깃테스트임~~ㅁㄴㅇㅁㄴㅇ
