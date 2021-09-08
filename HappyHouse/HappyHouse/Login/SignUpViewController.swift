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
    let hausLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 54.24, weight: .black) // Pretendard-Black
        $0.text = "HAUS"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    let signUpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold) // Pretendard-Black
        $0.text = "회원가입하기"
        $0.textAlignment = .center
        $0.textColor = UIColor(named: "TitleColor")
    }
    
    let signUpButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "ButtonColor")
        $0.setTitle("이메일로 로그인하기", for: .normal)
    }
    
    let loginButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "ButtonColor")
        $0.setTitle("이메일로 회원가입하기", for: .normal)
    }
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        setUpView()
        setConstraints()
    }
    
}

extension SignUpViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([hausLabel, signUpLabel, signUpButton, loginButton])
    }
    
    private func setConstraints() {
        
    }
}
