//
//  ViewController.swift
//  test04
//
//  Created by 백성현 on 2021/08/17.
//
import Amplify
import AmplifyPlugins
import UIKit




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAmplify()
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

    func uploadFile() {
        let fileKey = "testFile.txt"
        let fileContents = "This is my dummy file"
        let fileData = fileContents.data(using: .utf8)
        
        Amplify.Storage.uploadData(key: fileKey, data: fileData!) { result in
            
            switch result {
            case .success(let key):
                print("file with key \(key) uploaded")
                
//                DispatchQueue.main.async {
//                    fileStatus = "File Uploaded"
//                }
                
            case .failure(let storageError):
                print("Failed to upload file", storageError)
                
//                DispatchQueue.main.async {
//                    fileStatus = "Failed to upload file"
//                }
            
            }
        }
    }
    
    func createData() {
        let item = Test(contents: "It's Sample Contents")
        Amplify.DataStore.save(item) { result in
            switch (result) {
                case .success(let savedItem):
                    print("Saved item: \(savedItem.id)")
                case .failure(let error):
                    print("Could not save item to DataStore: \(error)")
            }
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        uploadFile()
        createData()
    }
    
}

