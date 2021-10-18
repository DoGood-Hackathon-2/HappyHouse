//
//  CRCollectionViewCell.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications

class CRCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var ProfileButtonImage: UIButton!
    @IBOutlet weak var ProfileName: UILabel!
    
    func initUI(of item : CRCollectionModel) {
        cellLayout()
        ProfileButtonImage.then{
            $0.setImage(UIImage(named: item.profileButtonImage), for: .normal)
            $0.setTitle("", for: .normal)
            $0.layer.cornerRadius = 30 // width의 절반
            $0.clipsToBounds = true
        }
        ProfileName.then {
            $0.text = item.name
        }
    }
    
    func cellLayout() {
        ProfileButtonImage.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        ProfileName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(ProfileButtonImage.snp.bottom)
            $0.width.equalTo(60)
            $0.bottom.equalToSuperview()
        }
    }
}
