//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by 백성현 on 2021/07/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
        // 추가된 부분) 델리게이트 지정
        picker.delegate = self
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
    }
}


// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 알림창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imageView.image = img
        }
    }
}

// MARK:- 네비게이션 컨트롤러 델리게이트 메소드
extension ViewController: UINavigationControllerDelegate{
    
}

