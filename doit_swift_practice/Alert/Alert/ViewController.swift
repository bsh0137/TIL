//
//  ViewController.swift
//  Alert
//
//  Created by 백성현 on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {
    let imgLampOn = UIImage(named: "bulb_on.jpeg")
    let imgLampOff = UIImage(named: "bulb_off.jpeg")
    let imgRemoved = UIImage(named: "white_background.jpeg")
    
    var isLampOn = true
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lampImg.image = imgLampOn
    }

    @IBAction func btnLampOn(_ sender: UIButton) {
        if (isLampOn) {
            let alert = UIAlertController(title: "경고", message: "전구가 이미 켜져 잇습니다.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(ok)
            self.present(alert, animated: false)
        }
        else {
            lampImg.image = imgLampOn
            isLampOn = true
        }
    }
    
    @IBAction func btnLampOff(_ sender: UIButton) {
        if (isLampOn) {
            let alert = UIAlertController(title: "경고", message: "전구가 이미 켜져 잇습니다.", preferredStyle: .alert)
            
            let on = UIAlertAction(title: "켜기", style: .default, handler: nil)
            
            let off = UIAlertAction(title: "끄기", style: .default, handler: {(_) in
                self.lampImg.image = self.imgLampOff
                self.isLampOn = false
            })
            
            alert.addAction(on)
            alert.addAction(off)
            self.present(alert, animated: false)
        }
    }
    
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let alert = UIAlertController(title: "경고", message: "전구가 이미 켜져 잇습니다.", preferredStyle: .alert)
        
        let on = UIAlertAction(title: "켜기", style: .default, handler: {(_) in
            self.lampImg.image = self.imgLampOn
            self.isLampOn = true
        })
        
        let off = UIAlertAction(title: "끄기", style: .default, handler: {(_) in
            self.lampImg.image = self.imgLampOff
            self.isLampOn = false
        })
        let remove = UIAlertAction(title: "제거", style: .default, handler: {(_) in
            self.lampImg.image = self.imgRemoved
            self.isLampOn = false
        })
    
        alert.addAction(on)
        alert.addAction(off)
        alert.addAction(remove)
        self.present(alert, animated: false)
    }
    
    
}

