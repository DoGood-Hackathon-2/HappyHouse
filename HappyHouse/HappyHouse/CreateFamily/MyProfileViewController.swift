//
//  CreateProfileViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift

class MyProfileViewController: UIViewController {
    
    // MARK: - Properties
    private var familyName = ""
    private var descriptionFormat = " 안에서의\n역할을 입력해주세요"
    private var bag = DisposeBag()
    private let imagePicker = UIImagePickerController()
            
    private let welcomeTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 48, weight: .black) // Pretendard-ExtraBold
        $0.text = "welcome"
        $0.textColor = UIColor(named: "TitleColor")
    }

    private let familyNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Bold
        $0.text = "가족이름"
    }
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "Rectangle 697") // 이미지 에셋 의미있는 이름으로 변경하기
        $0.contentMode = .top
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold) // Pretendard-Bold
        $0.text = "러블리하우스 안에서의\n역할을 입력해주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
        
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "예) 딸, 공주님"
        $0.textAlignment = .center
        $0.borderStyle = .none
    }

    private let lineView = UIView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor(named: "SubColor")?.cgColor
    }
    
    private let profileImageButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.backgroundColor = UIColor(named: "PlaceholderColor")?.cgColor
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor(named: "TitleColor")?.cgColor
        $0.makeCircleView()
    }
    
    private let cameraButton = UIButton().then {
        $0.setImage(UIImage(named: "camera_button"), for: .normal)
    }
    
    private let nextButton = UIButton().then {
        $0.setTitle("선택하기", for: .normal)
        $0.setDefaultStyle()
    }
    
    func configure(familyName: String) {
        self.familyName = familyName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setImagePicker()
        setBinding()
    }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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


extension MyProfileViewController {

    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([welcomeTitle, familyNameLabel, backgroundImage, descriptionLabel,
                          nicknameTextField, lineView, profileImageButton, cameraButton, nextButton])
        familyNameLabel.text = familyName
        descriptionLabel.text = familyName + descriptionFormat
    }

    private func setConstraints() {
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(60)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        familyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(familyNameLabel.snp.bottom).offset(18)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(94)
            make.leading.trailing.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(nicknameTextField).offset(8)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(2)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(profileImageButton.defaultProfileSize)
            make.top.equalTo(lineView).offset(51)
            make.centerX.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.trailing.equalTo(profileImageButton).offset(-10)
            make.bottom.equalTo(profileImageButton).offset(-15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(nextButton.defaultHeight)
            make.top.lessThanOrEqualTo(profileImageButton.snp.bottom).offset(147)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(nextButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
        
    // MARK: - Rx Event
    private func setBinding() {
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
        
        nextButton.rx.controlEvent(.touchUpInside)
            .bind { [unowned self] in
                let familyViewController = FamilyViewController()
                familyViewController.configure(familyName: self.familyName)
                presentFullScreen(familyViewController)
            }
            .disposed(by: bag)
    }
}
