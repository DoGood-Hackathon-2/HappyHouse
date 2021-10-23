//
//  WelcomeViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    var bag = DisposeBag()
    
    private let helloLabel = UILabel().then {
        $0.text = "Hello!"
        $0.font = UIFont.systemFont(ofSize: 48, weight: .black) // Pretendard-ExtraBold
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    private let inviteInfoLabel = UILabel().then {
        $0.text = "딸에게 알람이 왔어요!" // (딸 = 초대장을 보낸 사람의 별명) 서버에서 받아오기
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Bold
    }
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "Rectangle 697") // 이미지 에셋 의미있는 이름으로 변경하기
        $0.contentMode = .top
    }
    
    private let backgroundDecoImage = UIImageView().then {
        $0.image = UIImage(named: "Group 3079") // 이미지 에셋 의미있는 이름으로 변경하기
    }
    
    private let profileImage = UIImageView().then {
        $0.image = UIImage(named: "daughter_profile")
        $0.makeCircleView()
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "welcome!"
        $0.font = UIFont.systemFont(ofSize: 34, weight: .black) // RammettoOne-Regular
        $0.textColor = UIColor(named: "ButtonColor")
        $0.textAlignment = .center
    }
    
    private let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setDefaultStyle()
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setBinding()
    }
}

extension WelcomeViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([helloLabel, inviteInfoLabel, backgroundImage, profileImage,
                          backgroundDecoImage, welcomeLabel, startButton])
    }
    
    private func setConstraints() {
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(80)
            make.leading.trailing.equalToSuperview().offset(32)
        }
        
        inviteInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().offset(32)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(66)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(profileImage.defaultProfileSize)
            make.top.lessThanOrEqualTo(backgroundImage.snp.top).offset(170)
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(30)
            make.bottom.equalTo(startButton.snp.top).offset(-80)
        }
        
        backgroundDecoImage.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalTo(startButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(startButton.defaultHeight)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(startButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Rx event
    private func setBinding() {
        startButton.rx.controlEvent(.touchUpInside)
            .bind { [weak self] in
                self?.presentFullScreen(JoinViewController())
            }
            .disposed(by: bag)
    }
}
