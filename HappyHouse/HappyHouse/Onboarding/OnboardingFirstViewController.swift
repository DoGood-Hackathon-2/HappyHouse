//
//  LoadingViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class OnboardingFirstViewController : UIViewController {
    
    // MARK: - Properties
    var bag = DisposeBag()
    
    let titleLabel = UILabel().then {
        $0.text = "happy\ntogether!"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
        $0.font = UIFont.systemFont(ofSize: 34, weight: .black) // RammettoOne-Regular
        $0.numberOfLines = 2
    }
    
    let loadingImage = UIImageView().then {
        $0.image = UIImage(named: "pablo-surprise 1")
    }
    
    let subTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold) // Pretendard-Bold
        $0.text = "웃음꽃이 피는\n화목한 우리 가족"
        $0.textAlignment = .center
        $0.numberOfLines = 2
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

extension OnboardingFirstViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([loadingImage, titleLabel, subTitleLabel, startButton])
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.equalTo(view.safeArea.top).offset(80)
            make.leading.centerX.equalToSuperview()
        }
        loadingImage.snp.makeConstraints { make in
            make.height.equalTo(296)
            make.leading.width.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.greaterThanOrEqualTo(loadingImage.snp.bottom)
            make.leading.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.height.equalTo(startButton.defaultHeight)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(50)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(startButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func subscribeButtonEvent() {
        startButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
                self?.presentFullScreen(OnboardingSecondViewController())
            }
            .disposed(by: bag)
    }
}

