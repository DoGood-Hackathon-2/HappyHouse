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
    @IBOutlet weak var GoMyPageHomeButton: UIButton!
    @IBOutlet weak var GoHomeButton: UIButton!
    
    let figmaWidth = 414
    let figmaHeight = 896
    var DeviceWidth : CGFloat = 0
    var DeviceHeight : CGFloat = 0
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceWidth = view.frame.width
        DeviceHeight = view.frame.height
        layout()
        setUI()
    }
    
    func setUI() {
        VerifyTitle.then {
            $0.text = "챌린지가 추가되었습니다!"
            //$0.font = UIFont(name: "Pretendard-Bold", size: 34)
            $0.textColor = UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1)
        }
        VerifySubTitle.then {
            $0.text = "마이페이지에서 확인하시겠어요?"
            //$0.font = UIFont(name: "Pretendard-Bold", size: 24)
            $0.textColor = UIColor(red: 0.338, green: 0.338, blue: 0.338, alpha: 1)
        }
        GoMyPageHomeButton.then {
            $0.setTitle("예, 마이페이지로 가기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(red: 0.953, green: 0.42, blue: 0.498, alpha: 1)
            $0.layer.cornerRadius = 28 * (view.frame.width - 34) / 380
        }
        GoHomeButton.then {
            $0.setTitle("아니오, 홈으로 가기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1)
            // 380 * 56 : 44 = (view.frame.width - 34) * 56 : x
            $0.layer.cornerRadius = 28 * (view.frame.width - 34) / 380
        }
    }
    func layout() {
        VerifyTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        VerifySubTitle.snp.makeConstraints {
            $0.top.equalTo(VerifyTitle.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        GoMyPageHomeButton.snp.makeConstraints {
            $0.top.equalTo(VerifySubTitle.snp.bottom).offset(48)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
            $0.height.equalTo(56 * Int(DeviceHeight) / figmaHeight)
        }
        GoHomeButton.snp.makeConstraints {
            $0.top.equalTo(GoMyPageHomeButton.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
            $0.height.equalTo(56 * Int(DeviceHeight) / figmaHeight)
        }
    }
}

