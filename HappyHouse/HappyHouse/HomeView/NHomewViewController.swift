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
    @IBOutlet weak var NProfileImage: UIImageView! // 프로필 이미지
    @IBOutlet weak var StackView: UIStackView! // 스택 뷰
    @IBOutlet weak var NProfileName: UILabel! // 스택 뷰 안의 이름
    @IBOutlet weak var NMention: UILabel! // 추천 멘트
    @IBOutlet weak var NCollectionView: UICollectionView! // 추천 루틴
    
    let viewModel = NHomeViewModel() // MVVM 사용위한 뷰모델 선언
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        Buttonevent()
    }
    
}

extension NHomewViewController {
    func layout() {
        NRoomTitle.snp.makeConstraints {
            if #available(iOS 11, *) {
                // 노치가 존재하면 
                let guide = view.safeAreaLayoutGuide
                $0.top.equalTo(guide).offset(20)
            } else {
                $0.top.equalToSuperview().offset(60)
            }
            $0.left.equalTo(41)
        }
        NBackgroundImage.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.top.equalTo(100)
            $0.bottom.equalTo(-200)
        }
        NSuggetLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(NBackgroundImage.snp.bottom).offset(16)
        }
        NCreateButton.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(NSuggetLabel.snp.bottom).offset(12)
            $0.height.greaterThanOrEqualTo(70)
        }
        NProfileImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(NBackgroundImage.snp.top)
            $0.width.height.equalTo(100)
        }
        StackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(NProfileImage.snp.bottom).offset(15)
        }
        NMention.snp.makeConstraints {
            $0.left.equalTo(32)
            $0.top.equalTo(StackView.snp.bottom).offset(43)
        }
        NCollectionView.snp.makeConstraints {
            $0.top.equalTo(NMention.snp.bottom).offset(16)
            $0.left.right.equalTo(0)
            $0.bottom.equalTo(NBackgroundImage.snp.bottom)
        }
    }
    
    func setUI() {
        NRoomTitle.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9017189145, blue: 0.9212634563, alpha: 1)
            $0.clipsToBounds = true // 이거 있어야 Label의 cornerRadius 적용된다.
            $0.layer.cornerRadius = 11
            $0.text = "  러블리하우스  " // 앞뒤로 띄어쓰기 2칸 있어야 글자가 잘 보인다.
            $0.font = UIFont(name: "Pretendard-Bold", size: 13)
        }
        NSuggetLabel.then{
            $0.tintColor = .black
            $0.text = "새로운 챌린지도 만들 수 있어요!"
        }
        NCreateButton.then {
            $0.backgroundColor = #colorLiteral(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
            //$0.setTitle("챌린지 만들기", for: .normal)
            $0.layer.cornerRadius = 23.5
        }
        NProfileName.then {
            $0.text = "마마"
        }
        NCollectionView.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        }
        
    }
    
    
    func Buttonevent() {
        NCreateButton.rx.tap
            .bind{
                print("tap")
            }.disposed(by: bag)
    }
}

class NHomeViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func initUI(of recommend: Recommend) {
        imageView.image = UIImage(named: recommend.image)
//        imageView.layer.cornerRadius = imageView.frame.width / 2
//        imageView.layer.masksToBounds = true
    }
}

//
//struct NHomeViewCell {
//    let img : UIImage
//    let title : String
//}
//
//class NHomeViewModel {
//    
//    var dummyData = [
//        NHomeViewCell(img: UIImage(named: "ticket")! ,title: "1"),
//        NHomeViewCell(img: UIImage(named: "ticket")! ,title: "2"),
//        NHomeViewCell(img: UIImage(named: "ticket")! ,title: "3"),
//        NHomeViewCell(img: UIImage(named: "ticket")! ,title: "4"),
//    ]
//    
//    var dummyObsrvable: Observable<[NHomeViewCell]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
//    
//    init() {
//        dummyObsrvable = Observable.of(dummyData)
//    }
//}
