//
//  ViewController.swift
//  ImageView
//
//  Created by 백성현 on 2021/07/24.
//

import UIKit

let imgArray: [String] = ["bulb_off.jpeg", "bulb_on.jpeg", "money.jpeg", "money2.jpeg"]

class ImageViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    var img_index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = UIImage(named: imgArray[img_index])
    }

    @IBAction func btnShowNextImage(_ sender: Any) {
        img_index += 1
        
        if (img_index > 3 ){
            img_index = 3
            NSLog("다음 이미지가 없습니다.")
            let alert = UIAlertController(title: "경고", message: "다음 이미지가 없습니다.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
        }
        
        imgView.image = UIImage(named: imgArray[img_index])
    }
    
    @IBAction func btnShowPrevImage(_ sender: Any) {
        img_index -= 1
        
        if (img_index < 0) {
            img_index = 0
            NSLog("이전 이미지가 없습니다.")
            
            let alert = UIAlertController(title: "경고", message: "이전 이미지가 없습니다.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
        }
    
        imgView.image = UIImage(named: imgArray[img_index])
        
    }
    
}

