//
//  ViewController.swift
//  test12
//
//  Created by 백성현 on 2021/08/18.
//

import UIKit
import Amplify
import AmplifyPlugins


class ViewController: UIViewController {
    @IBOutlet weak var lbldata1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        amplifyConfigure()
//        createTodo()
    }

    func amplifyConfigure() {
        do {
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Amplify Configured with API Plugin!!")
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
    }
    
    @IBAction func btn(_ sender: Any) {
//        createTodo()
        postData()
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
    
    func postData(){
        let post = Post(title: "Create an Amplify DataStore app", status: PostStatus.draft)
        
        Amplify.DataStore.save(post) { result in
            switch result {
            case .success:
                print("Post saved successfully!")
            case .failure(let error):
                print("Error saving post \(error)")
            }
        }
    }
    
    func readData() {
        print("Start Reading Data!")
        Amplify.DataStore.query(Post.self) { result in
            switch result {
            case .success(let posts):
                print("Posts retrieved successfully: \(posts)")
            case .failure(let error):
                print("Error retrieving posts \(error)")
            }
        }
    }
    
    @IBAction func btnReadData(_ sender: Any) {
        readData()
    }
    
    func readSpecificData() {
        Amplify.DataStore.query(Post.self, byId: "87CE4E6C-1213-462E-B943-9A3946107238") {
            switch $0 {
            case .success(let result):
                // result will be a single object of type Post?
//                print("Posts: \(result)")
                print("reading Specific Data Success")
                lbldata1.text = result?.title
            case .failure(let error):
                print("Reading specific data failed!") // dㅘ우
//                print("Error on query() for type Post - \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func btnReadSpecificData(_ sender: Any) {
        readSpecificData()
    }
    
}

