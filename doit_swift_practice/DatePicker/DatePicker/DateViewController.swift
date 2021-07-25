//
//  ViewController.swift
//  DatePicker
//
//  Created by 백성현 on 2021/07/24.
//

import UIKit

class DateViewController: UIViewController {
    let timeSelector: Selector = #selector(DateViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime: String?
    var currentTime: String?
    var isAlarmOn = false
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        for i in 1..<10 {
            NSLog("test \(i)")
        }
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
        lblPickerTime.text = "선택시간 : " + alarmTime!
    }
    
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm aaa"
        
        currentTime = formatter.string(from: date as Date)
        lblCurrentTime.text = "현재 시각 : " + currentTime!
        
        if (alarmTime == currentTime) {
            if (!isAlarmOn){
                let alert = UIAlertController(title: "알림", message: "알람 시간이 되었습니다.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "네, 알겠습니다.", style: .default, handler: {(_) in
                    self.isAlarmOn = true
                })
                
                alert.addAction(okAction)
                present(alert, animated: false, completion: nil)
            }
        }
        else {
            isAlarmOn = false
            view.backgroundColor = UIColor.white
        }
    }
    
}

