//
//  ProfileViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/24.
//

import UIKit
import RxSwift

/// 프로필 사진을 선택할 수 있도록 ImagePicker 기능이 있는 뷰 컨트롤러
class ProfileViewController: UIViewController {

    let imagePicker = UIImagePickerController()
    var bag = DisposeBag()

    let profileImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.backgroundColor = UIColor(named: "PlaceholderColor")?.cgColor
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "TitleColor")?.cgColor
        $0.makeCircleView()
    }
    
    let cameraButton = UIButton().then {
        $0.setImage(UIImage(named: "camera_button"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImagePicker()        
    }
    
    func setBinding() {
        profileImageButton.rx.controlEvent(.touchUpInside)
            .bind { [unowned self] in
                present(imagePicker, animated: true)
            }
            .disposed(by: bag)
        
        cameraButton.rx.controlEvent(.touchUpInside)
            .bind { [unowned self] in
                present(imagePicker, animated: true)
            }
            .disposed(by: bag)
        
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Image Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        profileImageButton.setBackgroundImage(newImage, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func setImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
}
