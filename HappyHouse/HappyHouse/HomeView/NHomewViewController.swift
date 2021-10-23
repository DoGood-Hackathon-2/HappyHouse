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
    @IBOutlet weak var NCreateButton: UIButton! // 챌린지 만들기 버튼
    @IBOutlet weak var NProfileImage: UIImageView! // 프로필 이미지
    @IBOutlet weak var StackView: UIStackView! // 스택 뷰
    @IBOutlet weak var NProfileName: UILabel! // 스택 뷰 안의 이름
    @IBOutlet weak var NMention: UILabel! // 추천 멘트
    @IBOutlet weak var NCollectionView: UICollectionView! // 추천 루틴
    
    @IBAction func currHomePage(sender: UIStoryboardSegue) {
        // unwind 세그웨이
    }
    
    let viewModel = NHomeViewModel() // MVVM 사용위한 뷰모델 선언
    let bag = DisposeBag()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        event()
        NCollectionView.delegate = self
        setData()
    }
}

extension NHomewViewController {
    func layout() {
        /*
         NRoomTitle의 경우에는 스토리보드에서 레이아웃 잡음
         이유 : safe 대응은 가능하나, 스크롤 뷰와 제대로 매칭되서 작동하지 않기에 시간 절약을 위해 그렇게 작성
         */
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
    
    func setData() {
        viewModel.dummyObsrvable
            .bind(to: NCollectionView.rx.items(
                    cellIdentifier: "NHomeViewCell",
                    cellType: NHomeViewCell.self)
            ) { index, item, cell in
                cell.initUI(of: item)
            }.disposed(by: bag)
    }
    
    func event() {
        NCreateButton.rx.tap
            .bind{
                print("tap")
                
                let commonRoutineStoryboard = UIStoryboard.init(name: "CommonRoutine", bundle: nil) // 스토리보드 객체 생성
                guard let vc = commonRoutineStoryboard.instantiateViewController(identifier: "CommonRoutine") as? CommonRoutineViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: false, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true) // 네비 형식으로
                
            }.disposed(by: bag)
    }
}

extension NHomewViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        //let textAreaHeight : CGFloat = 65
        
        let width : CGFloat = (collectionView.bounds.width - 20 - itemSpacing ) / 2
        let height : CGFloat = width * 135/180 // + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
    // case A
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // case B
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


class NHomeViewCell : UICollectionViewCell {
    
    @IBOutlet weak var NBackContainer: UIView!
    @IBOutlet weak var Nimg: UIImageView!
    @IBOutlet weak var NRoutineTitle: UILabel!
    
    func initUI(of nHomeModel: NHomeModel) {
        
        NBackContainer.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(0)
        }
        NBackContainer.layer.cornerRadius = 10
        NBackContainer.backgroundColor = .gray
        
        Nimg.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(20)
            $0.width.height.equalTo(50)
        }
        Nimg.layer.cornerRadius = 25
        Nimg.layer.masksToBounds = true
        Nimg.layer.borderWidth = 0
        Nimg.backgroundColor = .blue
        
        NRoutineTitle.snp.makeConstraints {
            $0.top.equalTo(Nimg.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(NBackContainer.frame.width)
        }
        NRoutineTitle.text = "\(nHomeModel.title)"
        NRoutineTitle.numberOfLines = 2
        Nimg.image = UIImage(named: "rice2")
        //        imageView.layer.cornerRadius = imageView.frame.width / 2
        //        imageView.layer.masksToBounds = tru
    }
}


struct NHomeModel {
    let img : UIImage
    let title : String
}

class NHomeViewModel {
    
    var dummyData = [
        // 여기서 systemName을 Model로 옮겨서 혹시나도 발생할 수 있는 에러의 경우 이미지를 systemName으로 이미지를 잘 처리해보자
        NHomeModel(img: UIImage(systemName: "ticket")!, title: "0"),
        NHomeModel(img: UIImage(systemName: "ticket")! ,title: "1"),
        NHomeModel(img: UIImage(systemName: "ticket")! ,title: "2"),
        NHomeModel(img: UIImage(systemName: "ticket")! ,title: "3"),
        NHomeModel(img: UIImage(systemName: "ticket")! ,title: "4"),
    ]
    
    var dummyObsrvable: Observable<[NHomeModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
    }
}
