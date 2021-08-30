//
//  CommonRoutine.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class CommonRoutineViewController : UIViewController {
    
    @IBOutlet weak var PageTitle: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var RoutineTitle: UILabel!
    @IBOutlet weak var CreateRoutineTextField: UITextField!
    @IBOutlet weak var CRUnderLineView: UIView! // 크리에이티브 루틴 언더라인 뷰
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var WithWhoLabel: UILabel! // 누구와 함께 할까요 이름
    @IBOutlet weak var CRcollectionView: UICollectionView!
    
    let viewModel = CRCollectionViewModel()
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let DeviceWidth = view.frame.width // 디바이스 길이
        layout()
        setUI()
        setData()
    }
}

extension CommonRoutineViewController {
    
    func layout() {
        PageTitle.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        BackButton.snp.makeConstraints {
            $0.top.equalTo(PageTitle.snp.top).offset(-(PageTitle.frame.height/2))
            $0.left.equalTo(view.frame.width/14)
        }
        RoutineTitle.snp.makeConstraints {
            $0.top.equalTo(BackButton.snp.bottom).offset(35)
            $0.left.equalTo(BackButton.snp.left)
        }
        CreateRoutineTextField.snp.makeConstraints {
            $0.left.equalTo(BackButton.snp.left)
            $0.top.equalTo(RoutineTitle.snp.bottom).offset(11)
            $0.width.lessThanOrEqualTo(250)
        }
        CRUnderLineView.snp.makeConstraints {
            $0.left.equalTo(BackButton.snp.left)
            $0.top.equalTo(CreateRoutineTextField.snp.bottom).offset(-(CreateRoutineTextField.frame.height/4))
            $0.width.equalTo(270)
            $0.height.equalTo(15)
        }
        BackgroundImage.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(CRUnderLineView.snp.bottom).offset(10)
        }
        WithWhoLabel.snp.makeConstraints {
            $0.top.equalTo(BackgroundImage.snp.top).offset(10)
            $0.left.equalTo(BackButton.snp.left)
        }
        CRcollectionView.snp.makeConstraints {
            $0.top.equalTo(WithWhoLabel.snp.bottom).offset(10)
            $0.left.equalTo(BackButton.snp.left)
            $0.right.equalToSuperview().offset(-(view.frame.width/14)) // 백버튼의 좌간격 만큼
            $0.bottom.equalTo(-100)
        }
        
    }
    
    func setUI() {
        BackButton.then {
            $0.layoutMargins = .zero
            $0.tintColor = UIColor(red: 0.458, green: 0.458, blue: 0.458, alpha: 1)
        }
        PageTitle.then {
            $0.text = "챌린지 만들기"
        }
        
        RoutineTitle.then {
            $0.text = "챌린지를 만들어 보세요." // 여기에는 sender통해서 인자값 줘서 조정하기
        }
        
        CreateRoutineTextField.then {
            $0.placeholder = "챌린지 제목을 적어주세요."
        }
        CRUnderLineView.then {
            $0.backgroundColor = #colorLiteral(red: 0.5654320121, green: 0.7023948431, blue: 0.9619845748, alpha: 1)
            CRUnderLineView.addSubview(CreateRoutineTextField)
        }
        WithWhoLabel.then {
            $0.text = "누구와 함께 할까요?"
        }
    }
    
    func setData() {
        viewModel.dummyObsrvable
            .bind(to: CRcollectionView.rx
                    .items(
                        cellIdentifier: "CRCell",
                        cellType: CRCollectionViewCell.self)
            ) { index, item, cell in
                cell.initUI(of: item)
                print(index, item, cell)
            }.disposed(by: bag)
    }
}

extension CommonRoutineViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
}

struct CRCollectionModel {
    var profileButtonImage : String
    var name : String
}

class CRCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var ProfileButtonImage: UIButton!
    @IBOutlet weak var ProfileName: UILabel!
    
    func initUI(of item : CRCollectionModel) {
        cellLayout()
        ProfileButtonImage.then{
            $0.setImage(UIImage(named: item.profileButtonImage), for: .normal)
            $0.setTitle("", for: .normal)
        }
        ProfileName.then {
            $0.text = item.name
        }
    }
    
    func cellLayout() {
        ProfileButtonImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(ProfileButtonImage.frame.height) // 1:1 비율로
        }
        ProfileName.snp.makeConstraints {
            $0.top.equalTo(ProfileButtonImage.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
    }
}

class CRCollectionViewModel {
    var dummyData = [
        CRCollectionModel(profileButtonImage: "image 1", name: " 짱꾸짱꾸 "),
        CRCollectionModel(profileButtonImage: "image 2", name: " 도라에몽이최고"),
        CRCollectionModel(profileButtonImage: "image 3", name: " 왜굮거"),
    ]
    
    var dummyObsrvable: Observable<[CRCollectionModel]>
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
    }
}
