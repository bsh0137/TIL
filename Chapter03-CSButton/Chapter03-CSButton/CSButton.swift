import UIKit

// 버튼 타입을 결정하는 열거형
public enum CSButtonType {
    case rect
    case circle
}

class CSButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // 스토리보드 방식으로 버튼을 정의했을 때 적용됩니다.
        self.backgroundColor = .green
        self.layer.borderWidth = 2 // 테두리
        self.layer.borderColor = UIColor.black.cgColor // 테두리는 검은색
        self.setTitle(("버튼"), for: .normal) // 기본 문구 설정.
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2 // 테두리 두께
        self.setTitle("코드로 생성된 버튼", for: .normal)
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        
        switch type {
        case .rect :
            self.backgroundColor = .black // 검은색으로
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 0 // 모서리는 전혀 둥글지 않게
            self.setTitleColor(.white, for: .normal)
            self.setTitle("Rect Button", for: .normal)
        case . circle:
            self.backgroundColor = .red // 배경을 빨간색으로
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
            self.layer.cornerRadius = 50 // 50 만큼 둥글게 처리
            self.setTitle("Circle Button", for: .normal)
        }
        
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
    }
    
    var style: CSButtonType = .rect {
        didSet {
            switch style {
                case .rect :
                    self.backgroundColor = .black // 검은색으로
                    self.layer.borderColor = UIColor.black.cgColor
                    self.layer.borderWidth = 2
                    self.layer.cornerRadius = 0 // 모서리는 전혀 둥글지 않게
                    self.setTitleColor(.white, for: .normal)
                    self.setTitle("Rect Button", for: .normal)
                case . circle:
                    self.backgroundColor = .red // 배경을 빨간색으로
                    self.layer.borderColor = UIColor.black.cgColor
                    self.layer.borderWidth = 2
                    self.layer.cornerRadius = 50 // 50 만큼 둥글게 처리
                    self.setTitle("Circle Button", for: .normal)
            }
        }
    }
    
    // 버튼이 클릭된 횟수를 카운트하며 타이틀에 표시해 주는 함수
    @objc func counting(_ sender: UIButton) {
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
        
    }
}
