import UIKit

class SideBarVC: UITableViewController {
    let uinfo = UserInfoManager() // 개인 정보 관리 매니저
    let nameLabel = UILabel() // 이름 레이블
    let emailLabel = UILabel() // 이메일 레이블
    let profileImage = UIImageView() // 프로필 이미지
    
    // 목록 데이터 배열
    let titles = [ "새 글 작성하기", "친구 새 글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    // 아이콘 데이터 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png")
    ]
    
    override func viewDidLoad() {
        // 테이블 뷰의 헤더 역할을 할 뷰를 정의한다.
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = .brown
        
        // 테이블 뷰의 헤더 뷰로 지정한다.
        self.tableView.tableHeaderView = headerView
        
        // 텍스트 레이블 속성 정의, 헤더 뷰에 추가
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.nameLabel.textColor = .white
        self.nameLabel.backgroundColor = .clear
        
        headerView.addSubview(self.nameLabel)
        
        // 이메일 레이블 속성 정의, 헤더 뷰에 추가
        self.emailLabel.text = self.uinfo.account ?? ""
        
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30)
        self.emailLabel.font = UIFont.systemFont(ofSize: 10)
        self.emailLabel.textColor = .white
        self.emailLabel.backgroundColor = .clear // 배경 색상
        
        headerView.addSubview(self.emailLabel)
        
        // 기본 이미지를 구현.
        self.profileImage.image = self.uinfo.profile
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        // 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2) // 반원 형태로 라운딩
        self.profileImage.layer.borderWidth = 0 // 테두리 두께 0으로
        self.profileImage.layer.masksToBounds = true
        
        view.addSubview(self.profileImage)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell" // 테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 대입한다.
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.text = self.titles[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let uv = self.storyboard?.instantiateViewController(identifier: "MemoForm")
            let target = self.revealViewController().frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController().revealToggle(self)
        } else if indexPath.row == 5 { // 계정 관리
            let uv = self.storyboard?.instantiateViewController(identifier: "_Profile")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: false){
                self.revealViewController().revealToggle(self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }
}
