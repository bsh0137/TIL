
import UIKit

protocol EditDelegate {
    func didMessageEditOne(_ controller: SecondViewController, message: String)
    func didImageOnOffDone(_ controller: SecondViewController, isOn: Bool)
}

class SecondViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate : EditDelegate?
    var isOn = false
    
    @IBOutlet var swChangeImg: UISwitch!
    @IBOutlet var txtField: UITextField!
    @IBOutlet var lblWay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblWay.text = textWayValue
        txtField.text = textMessage
        swChangeImg.isOn = isOn
    }
    
    @IBAction func btnFinish(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditOne(self, message: txtField.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    
}
