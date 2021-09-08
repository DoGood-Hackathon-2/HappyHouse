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
    
    let loadingTitle = UIImageView().then {
        $0.image = UIImage(named: "34px_bold") // 이미지대신 UILabel 로 변경 * 폰트설치 필요?
    }
    
    let loadingImage = UIImageView().then {
        $0.image = UIImage(named: "pablo-surprise 1")
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                // 현재 폰트적용이 안됨 UIFont(name: "Pretendard-Bold", size: 30)
        $0.text = "웃음꽃이 피는\n화목한 우리 가족"
        $0.textAlignment = .center
        $0.numberOfLines = 0
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
        view.addSubViews([loadingImage, loadingTitle, titleLabel, startButton])
    }
    
    private func setConstraints() {
        loadingTitle.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.equalTo(view.safeArea.top).offset(80)
            make.leading.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        loadingImage.snp.makeConstraints { make in
            make.height.equalTo(296)
            make.leading.width.equalToSuperview()
            make.top.equalTo(loadingTitle.snp.bottom).offset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.top.greaterThanOrEqualTo(loadingImage.snp.bottom)
            make.leading.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.height.equalTo(startButton.defaultHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
    }
    
    private func subscribeButtonEvent() {
        startButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
//                let viewController = OnboardingSecondViewController()
//                self?.navigationController?.pushViewController(viewController, animated: true)

                let secondViewController = OnboardingSecondViewController()
                secondViewController.modalPresentationStyle = .fullScreen
                secondViewController.modalTransitionStyle = .crossDissolve
                self?.present(secondViewController, animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
}

