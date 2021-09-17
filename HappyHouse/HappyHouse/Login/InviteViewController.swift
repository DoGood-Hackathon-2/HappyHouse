//
//  inviteViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

// 초대 확인 페이지
class InviteViewController : UIViewController {
    
    // MARK: - Properties
    private var bag = DisposeBag()
    
    private let contentView = UIView()
    
    private let hausLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 54.24, weight: .black) // Pretendard-Black
        $0.text = "HAUS"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    private let codeInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold) // Pretendard-Bold
        $0.text = "초대코드 입력하기"
        $0.textColor = UIColor(named: "SecondLabelColor")
    }
    
    private let codeTextField = UITextField().then {
        $0.placeholder = "초대코드"
        $0.setDefaultStyle()
    }
    
    private let createFamilyInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold) // Pretendard-Bold
        $0.text = "아직 가족구성이 안되었나요?"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "SecondLabelColor")
    }
    
    private let createFamilyButton = UIButton().then {
        $0.setTitle("가족만들기", for: .normal)
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

extension InviteViewController {

    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([contentView, createFamilyInfoLabel, createFamilyButton])
        contentView.addSubViews([hausLabel, codeInfoLabel, codeTextField])
        // todo : add gesture recognizer -> resign (textfield's) first responder
    }
    
    private func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        hausLabel.snp.makeConstraints { make in
            make.top.leading.centerX.equalToSuperview()
        }
        
        codeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(hausLabel.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(33)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.height.equalTo(codeTextField.defaultHeight)
            make.top.equalTo(codeInfoLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(codeTextField.defaultMargin)
            make.centerX.equalToSuperview()
        }
        
        createFamilyInfoLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView.snp.bottom)
            make.leading.centerX.equalToSuperview()
        }
        
        createFamilyButton.snp.makeConstraints { make in
            make.height.equalTo(createFamilyButton.defaultHeight)
            make.top.equalTo(createFamilyInfoLabel.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(createFamilyButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Rx event
    private func setBinding() {
        codeTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { self.codeTextField.text! }
            .bind { [unowned self] _ in
                self.presentFullScreen(WelcomeViewController())
            }
            .disposed(by: bag)
        
        createFamilyButton.rx.tap
            .bind { [unowned self] in
                self.presentFullScreen(CreateFamilyViewController())
            }.disposed(by: bag)
    }
}
