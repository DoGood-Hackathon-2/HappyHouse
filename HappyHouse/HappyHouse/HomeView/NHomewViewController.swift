//
//  NHomewViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

// HomeViewControllt -> NewHomeViewController
class NHomewViewController : ViewController{
    
    @IBOutlet weak var NRoomTitle: UILabel! // 방 제목
    @IBOutlet weak var NBackgroundImage: UIImageView! // 이미지로 되어 있어서 다크모드 대응시 이미지 변경 필요
    @IBOutlet weak var NSuggetLabel: UILabel! // 제안하는 레이블 이름
    @IBOutlet weak var NCreateButton: UIButton! // 버튼
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
    }
    
}

extension NHomewViewController {
    func layout() {
        NRoomTitle.snp.makeConstraints {
            $0.top.left.equalTo(30)
        }
        NBackgroundImage.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.top.equalTo(100)
            $0.bottom.equalTo(-200)
        }
        NSuggetLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(NBackgroundImage.snp.bottom).offset(10)
        }
        NCreateButton.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(NSuggetLabel.snp.bottom).offset(10)
            $0.height.greaterThanOrEqualTo(100)
        }
    }
    
    func setUI() {
        NRoomTitle.then {
            $0.backgroundColor = .systemPink
            $0.text = "러블리하우스"
        }
        NSuggetLabel.then{
            $0.text = "새로운 챌린지도 만들 수 있어요!"
        }
    }
}
