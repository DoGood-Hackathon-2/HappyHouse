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
    @IBOutlet weak var NFamDistanceLabel: UILabel! // 나와 가족 사이의 거리는
    @IBOutlet weak var NcontentsBox: UIView! // 하트랑 문구 적을 수 있게끔
    @IBOutlet weak var NcontentsStackView: UIStackView!
    @IBOutlet weak var NContentsLabel: UILabel! // 컨텐츠 안의 문구
    @IBOutlet weak var NContentsHeart: UIImageView!
    @IBOutlet weak var NcontentsRatio: UILabel! // 하트의 퍼센트
    @IBOutlet weak var NRepeatButton: UIButton! // 반복버튼
    @IBOutlet weak var NInstantButton: UIButton! // 일회성버튼
    @IBOutlet weak var NRepeatUnderLine: UIImageView!
    @IBOutlet weak var NInstantUnderLine: UIImageView!
    //    @IBOutlet weak var NRoutineCollectionView: UICollectionView! // 루틴 컬렉션
    @IBOutlet weak var NRoutineTableView: UITableView! // 루틴 테이블 뷰
    
    
    let viewModel = NMyPageViewModel() // MVVM 사용위한 뷰모델 선언
    let bag = DisposeBag()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        NMyfamilyCollectionView.delegate = self
        setData()
        event()
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
            $0.left.equalTo(26)
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
            $0.top.equalTo(NEditButton.snp.bottom).offset(12)
            $0.right.equalToSuperview().offset(0)
            $0.left.equalTo(NProfileName.snp.left)
            $0.height.equalTo(80)
        }
        NFamDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(NMyfamilyCollectionView.snp.bottom).offset(26)
            $0.left.equalTo(NProfileName.snp.left)
        }
        NcontentsBox.snp.makeConstraints {
            $0.top.equalTo(NFamDistanceLabel.snp.bottom).offset(12)
            $0.left.equalTo(12)
            $0.right.equalTo(-12) // left와 값 맞춰야 함.
            $0.height.equalTo(120)
        }
        NcontentsStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280)
        }
        NContentsHeart.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(103)
        }
        NContentsLabel.snp.makeConstraints {
            $0.width.equalTo(128)
        }
        NcontentsRatio.snp.makeConstraints {
            $0.center.equalTo(NContentsHeart)
        }
        NRepeatUnderLine.snp.makeConstraints {
            $0.left.equalTo(NFamDistanceLabel.snp.left)
            $0.top.equalTo(NcontentsStackView.snp.bottom).offset(60)
            $0.height.equalTo(8)
            $0.width.equalTo(51)
        }
        NInstantUnderLine.snp.makeConstraints {
            $0.left.equalTo(NRepeatUnderLine.snp.right)
            $0.top.equalTo(NcontentsStackView.snp.bottom).offset(60)
            $0.height.equalTo(8)
            $0.width.equalTo(51)
        }
        NRepeatButton.snp.makeConstraints {
            $0.bottom.equalTo(NRepeatUnderLine.snp.top)
            $0.left.equalTo(NRepeatUnderLine.snp.left)
            $0.width.equalTo(NRepeatUnderLine.frame.width)
        }
        NInstantButton.snp.makeConstraints {
            $0.bottom.equalTo(NInstantUnderLine.snp.top)
            $0.left.equalTo(NRepeatButton.snp.right)
            $0.width.equalTo(NInstantUnderLine.frame.width)
        }
        
        NRoutineTableView.snp.makeConstraints {
            $0.top.equalTo(NRepeatButton.snp.bottom).offset(8)
            $0.left.equalTo(NcontentsBox.snp.left)
            $0.right.equalTo(NcontentsBox.snp.right)
            $0.bottom.equalToSuperview()
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
        NProfileName.then {
            $0.text = "마마"
        }
        
        NMyfamilyCollectionView.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        }
        NcontentsBox.then {
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        }
        NContentsHeart.then {
            $0.addSubview(NcontentsRatio) // 레이블 추가해주기
        }
        NContentsLabel.then {
            $0.text = "가족들과 가까운 모습 보기 좋네요"
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont(name: "Pretendard-Bold", size: 15)
        }
        NcontentsRatio.then {
            $0.text = "60%"
        }
        
        NRepeatUnderLine.then {
            $0.image = UIImage(named: "Line 12")
        }
        NInstantUnderLine.then {
            $0.image = UIImage(named: "Line 11")
        }
        NRepeatButton.then {
            $0.tintColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
            
        }
        NInstantButton.then {
            $0.tintColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1)
        }
        //        NRoutineCollectionView.then {
        //            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        //        }
    }
    
    func setData() {
        viewModel.dummyObsrvable
            .bind(to: NMyfamilyCollectionView.rx.items(
                    cellIdentifier: "FamilyCell",
                    cellType: MyPageCollectionCell.self)
            ) { index, item, cell in
                let lastindex = self.NMyfamilyCollectionView.lastIndexpath().row // 마지막 인덱스 찾기 (물론 섹션도 찾을 수 있지롱~)
                if index == lastindex {
                    cell.lastinitUI(of: item)
                    cell.NMyPageCellButton.setImage(UIImage(named: "add_mypage"), for: .normal)
                } else {
                    cell.initUI(of: item)
                    cell.NMyPageCellButton.setImage(UIImage(named: item.ButtonImage), for: .normal)
                }
                cell.NMyPageCellButton.isHighlighted = false
            }.disposed(by: bag)
        
        viewModel.dummyRoutineObservable
            .bind(to: NRoutineTableView.rx.items(
                    cellIdentifier: "RoutineCell",
                    cellType: RoutineTableViewCell.self)
            ) {  index, item, cell in
                cell.initUI()
            }
        
    }
    
    func event() {
        NRepeatButton.rx.tap
            .bind{ [self] in
                self.NRepeatUnderLine.image = UIImage(named: "Line 12")
                self.NInstantUnderLine.image = UIImage(named: "Line 11")
                self.NRepeatButton.tintColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
                self.NInstantButton.tintColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1)
            }
        NInstantButton.rx.tap
            .bind{
                self.NRepeatUnderLine.image = UIImage(named: "Line 11")
                self.NInstantUnderLine.image = UIImage(named: "Line 12")
                self.NRepeatButton.tintColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1)
                self.NInstantButton.tintColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
            }
    }
}

extension NMyPageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
}

class MyPageCollectionCell : UICollectionViewCell {
    @IBOutlet weak var NMyPageCellButton: UIButton!
    
    func initUI(of item : MyPageCellModel) {
        NMyPageCellButton.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().offset(0)
        }
        NMyPageCellButton.layer.cornerRadius = 40
        NMyPageCellButton.layer.masksToBounds = true
        NMyPageCellButton.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        
        NMyPageCellButton.rx.controlEvent(UIControl.Event.allTouchEvents).bind{
            // 모든 이벤트를 막아야지!! ㅜㅜ rxCocoa 공부할 때 배운거라 구현했넴 ㅜㅍ
            self.NMyPageCellButton.isHighlighted = false
        }
    }
    
    func lastinitUI(of item : MyPageCellModel) {
        NMyPageCellButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
            $0.bottom.right.equalToSuperview().offset(-10)
        }
        NMyPageCellButton.layer.cornerRadius = 30
        NMyPageCellButton.layer.masksToBounds = true
        NMyPageCellButton.backgroundColor = .gray
        
        NMyPageCellButton.rx.tap
            // dispose하면 작동 안함.
            .bind{
                print("tap")
            }
    }
}

struct MyPageCellModel {
    var ButtonImage : String // 이미지가 들어가지만 클릭해서 이벤트 처리를 해야해서 걍 버튼으로 만들면 더 좋을거 같아서 이렇게 설계하기로
}

class NMyPageViewModel {
    // viewModel은 여러 곳에서 재사용되어야 한다. 그래야 의미가 있어짐
    
    var dummyData = [
        // 나중에 API로 데이터 받아와서 그 배열에 마지막에 add_mypage 넣어주기 또한 더하기 버튼의 경우는 Index컨트롤해서 크기 더 작게 만들기
        MyPageCellModel(ButtonImage: "add_mypage"),
        MyPageCellModel(ButtonImage: "image 1"),
        MyPageCellModel(ButtonImage: "image 2"),
        MyPageCellModel(ButtonImage: "image 3"),
        MyPageCellModel(ButtonImage: "image 1"),
    ]
    
    var dummyRoutineData = [
        RoutineModel(RprofileImage: "image 1", Rtitle: "약 챙겨먹기", Rdescription: "엄마 건강은 챙기고 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오후 3시")
    ]
    
    var dummyObsrvable: Observable<[MyPageCellModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
    var dummyRoutineObservable : Observable<[RoutineModel]> // NMyPageRoutineTableView에 들어갈 정보들
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
        dummyRoutineObservable = Observable.of(dummyRoutineData)
    }
}

extension UICollectionView {
    // 마지막 인덱스 찾는 함수 구현하여 collectionView쪽에 넣어둠 Util로 나중에 빼기
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfItems(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
}

struct RoutineModel {
    var RprofileImage : String // 루틴 이미지
    var Rtitle : String // 루틴 타이틀
    var Rdescription : String // 상세내용
    var Rdate : String // 루틴 날짜
    var Riterator : String // 루틴 반복
    var Rtime : String // 루틴 시간
}

class RoutineTableViewCell : UITableViewCell {
    @IBOutlet weak var RImage: UIImageView!
    @IBOutlet weak var RTitle: UILabel!
    @IBOutlet weak var RDescription: UILabel!
    @IBOutlet weak var RDate: UILabel!
    @IBOutlet weak var RDateImage: UIImageView!
    @IBOutlet weak var RIterator: UILabel!
    @IBOutlet weak var RTime: UILabel!
    @IBOutlet weak var RTimeImage: UIImageView! // 시간이미지
    @IBOutlet weak var REditButton: UIButton! // 수정하기
    @IBOutlet weak var REditUnderLine: UIView! // 수정하기 밑줄
    @IBOutlet weak var RChallengeButton: UIButton! // 챌린지 시작버튼
    
    func initUI() {
        cellLayout() // cell 내에서의 레이아웃 배치
        // setUI 구성
    }
    
    func cellLayout() {
        
    }
}
