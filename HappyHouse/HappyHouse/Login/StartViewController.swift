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
import GoogleSignIn

class StartViewController: UIViewController {

    // MARK: - Properties
    var bag = DisposeBag()
    
    let contentView = UIView()
    
    let hausLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 54.24, weight: .black) // Pretendard-Black
        $0.text = "HAUS"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    let signUpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Black
        $0.text = "시작하기"
        $0.textAlignment = .center
    }
    
    let signUpButton = UIButton().then {
        $0.setTitle("이메일로 회원가입하기", for: .normal)
        $0.setDefaultStyle()
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("이메일로 로그인하기", for: .normal)
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

extension StartViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubview(contentView)
        contentView.addSubViews([hausLabel, signUpLabel, signUpButton, loginButton])
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
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(signUpButton.defaultHeight)
            make.top.equalTo(signUpLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(signUpButton.defaultHeight)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    private func subscribeButtonEvent() {
        signUpButton.rx.controlEvent(.touchUpInside)
            .subscribe { [unowned self] _ in
                // google login test
                GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                    guard error == nil else {
                        print(error)
                        return
                    }
                    print(user)
                }
                
//                let viewController = SignUpViewController()
//                viewController.configure {
//                    self?.presentInviteViewController()
//                }
//                self?.present(viewController, animated: true, completion: nil)
            }
            .disposed(by: bag)
    
        loginButton.rx.controlEvent(.touchUpInside)
            .subscribe { [unowned self] _ in
                let viewController = LoginViewController()
                viewController.configure {
                    self.presentInviteViewController()
                }
                self.present(viewController, animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
    private func presentInviteViewController() {
        presentFullScreen(InviteViewController())
    }
}
