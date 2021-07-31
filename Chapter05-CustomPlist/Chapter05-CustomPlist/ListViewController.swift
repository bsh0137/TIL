import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    // 메인 번들에 정의된 PList 내용을 저장할 딕셔너리
    var defaultPlist : NSDictionary!
    var accountlist = [String]()
    
    override func viewDidLoad() {
        // 메인 번들에 UserInfo.plist가 포함되어 있으면 이를 읽어와 딕셔너리에 담는다.
        if let defaultPlistPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPlist = NSDictionary(contentsOfFile: defaultPlistPath)
        }
        
        
        let picker = UIPickerView()
        
        // 1) 피커 뷰의 델리게이트 객체 지정
        picker.delegate = self
        
        // 2) account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker
        
        // 툴바 객체 정의
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        
        // 액세서리 뷰 영역에 툴바를 표시
        self.account.inputAccessoryView = toolbar
        
        // 툴바에 들어갈 닫기 버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        // 가변 폭 버튼 정의
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // 신규 계정 등록 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        // 버튼을 툴바에 추가
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        // 기본 저장소 객체 불러오기
        let plist = UserDefaults.standard
        
        // 불러온 값을 설정
        self.name.text = plist.string(forKey: "name") // 이름
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        let accountist = plist.array(forKey: "accountList") as? [String] ?? [String]()
        self.accountlist = accountist
        
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
            let customPlist = "\(account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            print(clist)
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
        
        // 1) 사용자의 계정의 값이 비어 있따면 값을 설정하는 것을 막는다.
        if (self.account.text?.isEmpty)! {
            
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        // 내비게이션 바에 계정 추가 버튼 추가.
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // 1) 선택된 계정값을 텍스트 필드에 입력
        let account = self.accountlist[row] // 선택된 계정
        self.account.text = account
        
        // 사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장.
        let plist = UserDefaults.standard
        plist.setValue(account, forKey: "selectedAccount")
        plist.synchronize()
        
        if let _account = self.account.text {
            let customPlist = "\(_account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    
    @objc func pickerDone (_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func newAccount (_ sender: Any) {
        self.view.endEditing(true) // 일단 열려있는 입력용 뷰부터 닫아준다.
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요.", message: nil, preferredStyle: .alert)
        
        // 입력폼 추가.
        alert.addTextField() {
            $0.placeholder = "ex) abc@gamil.com"
        }
        
        // 버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            if let account = alert.textFields?[0].text {
                // 계정 목록 배열에 추가한다.
                self.accountlist.append(account)
                // 계정 텍스트 필드에 표시한다.
                self.account.text = account
                
                // 컨트롤 값을 모두 초기화한다.
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                // 계정 목록을 통째로 저장한다.
                let plist = UserDefaults.standard
                
                plist.setValue(self.accountlist, forKey: "accountlist")
                plist.setValue(account, forKey: "selectedAccount")
                plist.synchronize()
                
                // 입력 항목을 활성화한다.
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        })
        // 알림창 오픈
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0 이면 남자, 1이면 여자
        
        // 저장 로직 시작.
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist)
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn // true면 혼, false면 미혼
        
        // 저장 로직 시작
        let customPlist = "\(self.account.text!).plist"
    
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist)
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        print("custom plist = \(plist)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1) && !(self.account.text?.isEmpty)! {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요.", preferredStyle: .alert)
            
            alert.addTextField() {
                $0.text = self.name.text // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
            }
            
            // 버튼 및 액션 추가
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                let value = alert.textFields?[0].text
                
                // 저장 로직 시작
                let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPlist)
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                
                self.name.text = value
            })
            self.present(alert, animated: false, completion: nil)
        }
            
    }
}
