//
//  SignUpViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class SignUpViewController: UIViewController {

    // MARK: - Properties
    private var bag = DisposeBag()

    private var doneAction: EmptyClosure = {}
    
    private let contentView = UIView()
    
    private let hausLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 54.24, weight: .black) // Pretendard-Black
        $0.text = "HAUS"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    private let signUpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Black
        $0.text = "회원가입하기"
        $0.textAlignment = .center
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.setDefaultStyle()
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.setDefaultStyle()
    }
    
    private let passwordCheckTextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.setDefaultStyle()
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setDefaultStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        subscribeLoginButtonEvent()
    }
}

extension SignUpViewController {
    
    /// 로그인 이후 Start View Controller에서 필요한 작업을 수행하기 위해 클로져를 전달한다.
    func configure(doneAction: @escaping EmptyClosure) {
        self.doneAction = doneAction
    }
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([contentView, loginButton])
        contentView.addSubViews([hausLabel, signUpLabel, emailTextField, passwordTextField, passwordCheckTextField])
    }
    
    private func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        hausLabel.snp.makeConstraints { make in
            make.top.leading.centerX.equalToSuperview()
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(hausLabel.snp.bottom).offset(25)
            make.leading.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.defaultHeight)
            make.top.equalTo(signUpLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.defaultHeight)
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
        
        passwordCheckTextField.snp.makeConstraints { make in
            make.height.equalTo(emailTextField.defaultHeight)
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(17)
            make.bottom.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(loginButton.defaultHeight)
            make.top.greaterThanOrEqualTo(contentView.snp.bottom)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
        }
    }
    
    private func subscribeLoginButtonEvent() {
        loginButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
                // TODO - 회원가입 서버연동, 이메일 형식체크(regex), 비밀번호 확인(두 값 비교)
                self?.dismiss(animated: true, completion: self?.doneAction)
            }
            .disposed(by: bag)
    }
}
