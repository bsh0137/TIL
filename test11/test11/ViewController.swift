//
//  ViewController.swift
//  test11
//
//  Created by 백성현 on 2021/08/18.
//

import UIKit
import Amplify
import AmplifyPlugins


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        amplifyConfigure()
    }
    
    func amplifyConfigure() {
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

    func createTodo() {
        let todo = Todo(name: "my first todo", description: "todo description")
        Amplify.API.mutate(request: .create(todo)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let todo):
                    print("Successfully created the todo: \(todo)")
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            case .failure(let apiError):
                print("Failed to create a todo", apiError)
            }
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        createTodo()
    }
    
}

