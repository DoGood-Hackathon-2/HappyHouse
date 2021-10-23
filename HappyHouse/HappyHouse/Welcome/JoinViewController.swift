//
//  JoinViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class JoinViewController: ProfileViewController {
    
    // MARK: - Properties
    private let tapGesture = UITapGestureRecognizer()

    private let welcomeLabel = UILabel().then {
        $0.text = "Welcome"
        $0.font = UIFont.systemFont(ofSize: 48, weight: .black) // Pretendard-ExtraBold
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    private let familyNameLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
                .bold(string: "러블리하우스\n", fontSize: 28) // 가족 이름 서버에서 받아오기 // Pretendard-Bold
                .regular(string: "참여하기", fontSize: 28) // Pretendard-Regular
        $0.numberOfLines = 2
    }
    
    private let profileInfoLabel = UILabel().then {
        $0.text = "러블리하우스 안에서의\n역할을 입력해주세요" // (러블리하우스) = familyName
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.numberOfLines = 2
    }
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임"
        $0.textAlignment = .center
        $0.borderStyle = .none
    }

    private let lineView = UIView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor(named: "SubColor")?.cgColor
    }
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "Rectangle 697") // 이미지 에셋 의미있는 이름으로 변경하기
        $0.contentMode = .top
    }
    
    private let joinButton = UIButton().then {
        $0.setTitle("참여하기", for: .normal)
        $0.setDefaultStyle()
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setBinding()
    }
    
    override func setBinding() {
        super.setBinding()
        tapGesture.rx.event
            .bind { [unowned self] _ in
                self.nicknameTextField.resignFirstResponder()
            }
            .disposed(by: bag)
    }
}

extension JoinViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addGestureRecognizer(tapGesture)
        view.addSubViews([backgroundImage, welcomeLabel, familyNameLabel, profileInfoLabel,
                          nicknameTextField, lineView, profileImageButton, cameraButton, joinButton])
    }
    
    private func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(80)
            make.leading.trailing.equalToSuperview().offset(32)
        }
        
        familyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().offset(32)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(66)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        profileInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(72)
            make.leading.trailing.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileInfoLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(nicknameTextField).offset(5)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(2)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(profileImageButton.defaultProfileSize)
            make.top.equalTo(lineView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.trailing.equalTo(profileImageButton).offset(-10)
            make.bottom.equalTo(profileImageButton).offset(-15)
        }
        
        joinButton.snp.makeConstraints { make in
            make.height.equalTo(joinButton.defaultHeight)
            make.top.lessThanOrEqualTo(profileImageButton.snp.bottom).offset(147)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(joinButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func presentMain() {
        // go to main (routine page)
        let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewTabBar")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

