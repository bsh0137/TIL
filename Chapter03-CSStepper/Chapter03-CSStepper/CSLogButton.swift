import UIKit

public enum CSLogType: Int {
    case basic // 기본 로그 타입
    case title // 버튼의 타이틀 출력
    case tag // 버튼의 태그값 출력
}

public class CSLogButton: UIButton {
    // 로그 출력 타입
    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // 버튼에 스타일 적용
        self.setBackgroundImage(UIImage(named: <#T##String#>), for: <#T##UIControl.State#>)
    }
    
}


