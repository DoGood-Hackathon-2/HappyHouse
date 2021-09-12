//
//  RoutineVerifyViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/09/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class RoutineVerifyViewController : UIViewController {
    
    @IBOutlet weak var VerifyTitle: UILabel!
    @IBOutlet weak var VerifySubTitle: UILabel!
    @IBOutlet weak var GoMyPageHome: UIButton!
    @IBOutlet weak var GoHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
    }
    
    func setUI() {
        VerifyTitle.then {
            $0.text = "챌린지가 추가되었습니다"
        }
        VerifySubTitle.then {
            $0.text = "마이페이지에서 확인하시겠어요?"
        }
    }
    func layout() {
        VerifyTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        VerifySubTitle.snp.makeConstraints {
            $0.top.equalTo(VerifyTitle.snp.bottom)
        }
        GoMyPageHome.snp.makeConstraints {
            $0.top.equalTo(VerifySubTitle.snp.bottom).offset(48)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
        }
        GoHomeButton.snp.makeConstraints {
            $0.top.equalTo(GoMyPageHome.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
        }
    }
}
