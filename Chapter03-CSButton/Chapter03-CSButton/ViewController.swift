//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by 백성현 on 2021/07/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 인자 값에 따라 다른 스타일로 결정되는 버튼 1
        let rectBtn = CSButton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        // 인자 값에 따라 다른 스타일로 결정되는 버튼 2
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        
    }


}

