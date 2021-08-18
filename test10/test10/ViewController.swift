//
//  ViewController.swift
//  test10
//
//  Created by 백성현 on 2021/08/17.
//

import UIKit
import Amplify
//import AWSAP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAmplify()
    }

    func configureAmplify() {
        // initialize amplify
        do {
           try Amplify.add(plugin: AWSCognitoAuthPlugin())
           try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
           try Amplify.configure()
           print("Initialized Amplify")
        } catch {
           print("Could not initialize Amplify: \(error)")
        }
    }
}

