import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var wv: WKWebView!
    
    var mvo: MovieVO!
    
    override func viewDidLoad() {
        self.wv.navigationDelegate = self
        NSLog("linkurl = \(self.mvo.detail!), title= \(self.mvo.title!)")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        
        // URLRequest 인스턴스를 생성한다.
        let url = URL(string: (self.mvo.detail)!)
        let req = URLRequest(url: url!)
        
        self.wv.load(req)
    }
}


// MARK:- WKNavigationDelegate 프로토콜 구현
extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating() // 인디케이터 뷰의 애니메이션을 실행
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating() // 인디케이터 뷰의 애니메이션을 중단.
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating() // 인디케이터 뷰의 애니메이션을 중지.
        
        // 경고창 형식으로 오류 메시지를 표현해줌.
        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어오지 못했습니다.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
            // 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            // 버튼 클릭 시, 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK:- 심플한 경고창 함수 정의용 익스텐션
extension UIViewController {
    func alert(_ message: String, onClick: (() -> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel) { (_) in
            onClick?()
        })
        DispatchQueue.main.async {
            self.present(controller, animated: false)
        }
    }
}
