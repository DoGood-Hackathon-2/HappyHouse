//
//  CreateMemberViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import SnapKit
import Then

class CreateFamilyViewController: UIViewController {

    // MARK: - Properties
    private var bag = DisposeBag()
    private var familyName: String? = nil
            
    private let englishTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 48, weight: .black) // Pretendard-Black
        $0.text = "Create\nFamily"
        $0.textColor = UIColor(named: "TitleColor")
        $0.numberOfLines = 2
    }

    private let koreanTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Bold
        $0.text = "가족구성원 만들기"
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold) // Pretendard-Bold
        $0.text = "가족구성원의 그룹명을\n입력해주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
        
    private let familyNameTextField = UITextField().then {
        $0.placeholder = "예) 러블리하우스, 모던패밀리"
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
    
    private let nextButton = UIButton().then {
        $0.setTitle("구성원 추가하러가기", for: .normal)
        $0.setDefaultStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setBinding()
    }
}

extension CreateFamilyViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([englishTitle, koreanTitle, descriptionLabel,
                          familyNameTextField, lineView, backgroundImage, nextButton])
    }
    
    private func setConstraints() {
        //constraint 깨지는 것 확인하기 
        englishTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(60)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        koreanTitle.snp.makeConstraints { make in
            make.top.equalTo(englishTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(koreanTitle.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(koreanTitle.snp.bottom).offset(133)
            make.leading.trailing.equalToSuperview()
        }
        
        familyNameTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(familyNameTextField).offset(8)
            make.leading.trailing.equalTo(familyNameTextField)
            make.height.equalTo(2)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(nextButton.defaultHeight)
            make.top.lessThanOrEqualTo(lineView.snp.bottom).offset(308)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(nextButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Rx Event
    private func setBinding() {
        familyNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { self.familyNameTextField.text! }
            .bind { [unowned self] text in
                self.familyName = text
            }
            .disposed(by: bag)
        
        nextButton.rx.controlEvent(.touchUpInside)
            .filter { self.familyName != nil }
            .map { self.familyName! }
            .bind { [unowned self] familyName in
                let myProfileViewController = MyProfileViewController()
                myProfileViewController.configure(familyName: familyName)
                self.presentFullScreen(myProfileViewController)
            }
            .disposed(by: bag)
    }
}
