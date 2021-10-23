//
//  SecondOnboardingViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class OnboardingSecondViewController: UIViewController {

    // MARK: - Properties
    var bag = DisposeBag()
    
    let titleLabel = UILabel().then {
        $0.text = "always\nhappy!"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
        $0.font = UIFont.systemFont(ofSize: 34, weight: .black) // RammettoOne-Regular
        $0.numberOfLines = 2
    }

    let loadingTitleBackground = UIImageView().then {
        $0.image = UIImage(named: "Group 3079") // 이미지 새로 다운로드
    }

    let loadingImage = UIImageView().then {
        $0.image = UIImage(named: "pablo-visit-parents 1")
    }
        
    let subTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold) // Pretendard-Bold
        $0.text = "행복한 우리 가족을 위한\n루틴만들기"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let hausLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 34, weight: .black) // Pretendard-Black
        $0.text = "HAUS"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    let buttonInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17) // Pretendard-Regular
        $0.text = "즐거운 시간을 보내러 가볼까요?"
        $0.textAlignment = .center
    }
    
    let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setDefaultStyle()
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        subscribeButtonEvent()
    }
}

extension OnboardingSecondViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([titleLabel, loadingTitleBackground, loadingImage,
                          subTitleLabel, hausLabel, buttonInfoLabel, startButton])
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.equalTo(view.safeArea.top).offset(80)
            make.leading.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        loadingTitleBackground.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(view.safeArea.top).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        loadingImage.snp.makeConstraints { make in
            make.height.equalTo(214)
            make.leading.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.greaterThanOrEqualTo(loadingImage.snp.bottom)
            make.leading.centerX.equalToSuperview()
        }
        
        hausLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(25)
            make.leading.centerX.equalToSuperview()
        }
        
        buttonInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(hausLabel.snp.bottom).offset(25)
            make.leading.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(startButton.defaultHeight)
            make.top.equalTo(buttonInfoLabel.snp.bottom).offset(19)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(startButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func subscribeButtonEvent() {
        startButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
                self?.presentFullScreen(StartViewController())
            }
            .disposed(by: bag)
    }
}
