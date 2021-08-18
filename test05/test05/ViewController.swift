//
//  ViewController.swift
//  test05
//
//  Created by 백성현 on 2021/08/17.
//

import UIKit
import Amplify

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configureAmplify() {
        do {
            // Storage
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            
            print("Successfully configured Amplify !!")
        } catch {
            print("Could not configure Amplify", error)
        }
    }
}

