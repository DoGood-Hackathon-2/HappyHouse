//
//  NMyPageViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/26.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class NMyPageViewController : UIViewController {
    
    @IBOutlet weak var NBackgroundImage: UIImageView!
    @IBOutlet weak var NMypageTitle: UILabel! // 가족 이름
    @IBOutlet weak var NProfileName: UILabel! // 프로필 이름
    @IBOutlet weak var NEditButton: UIButton! // 수정하기 버튼
    @IBOutlet weak var HELLOLabel: UILabel! // 헬로글자
    @IBOutlet weak var NEditUnderBar: UIImageView! // 수정하기 아래에 언더바
    @IBOutlet weak var NMyfamilyCollectionView: UICollectionView! // 패밀리 정보
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        
    }
}

extension NMyPageViewController {
    func layout() {
        NBackgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35) // 15는 safeArea값으로 해야하는데 정확히 몇인지 기억이 안나서 찾아봐야함
            $0.left.right.bottom.equalTo(0)
        }
        HELLOLabel.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.left.equalTo(30)
        }
        NProfileName.snp.makeConstraints {
            $0.top.equalTo(HELLOLabel.snp.bottom).offset(12)
            $0.left.equalTo(HELLOLabel.snp.left)
        }
        NEditButton.snp.makeConstraints {
            $0.top.equalTo(NProfileName.snp.top)
            $0.right.equalToSuperview().offset(-12)
            $0.width.equalTo(50)
        }
        NEditUnderBar.snp.makeConstraints {
            $0.top.equalTo(NEditButton.snp.bottom).offset(-5)
            $0.right.equalTo(NEditButton.snp.right)
            $0.width.equalTo(NEditButton.frame.width)
        }
        NMyfamilyCollectionView.snp.makeConstraints {
            $0.top.equalTo(NEditButton.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().offset(0)
            $0.height.equalTo(100)
        }
    }
    
    func setUI() {
        NMypageTitle.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9017189145, blue: 0.9212634563, alpha: 1)
            $0.clipsToBounds = true // 이거 있어야 Label의 cornerRadius 적용된다.
            $0.layer.cornerRadius = 11
            $0.text = "  러블리하우스  " // 앞뒤로 띄어쓰기 2칸 있어야 글자가 잘 보인다.
            $0.font = UIFont(name: "Pretendard-Bold", size: 13)
        }
    }
}

class MyPageCollectionCell : UICollectionViewCell {
    
}
