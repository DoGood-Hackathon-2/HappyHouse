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
    @IBOutlet weak var NRoutineRepeatTableView: UITableView! // 루틴 테이블 뷰 - 반복
    @IBOutlet weak var NRoutineInstanceTableView: UITableView! // 루틴 테이블 뷰 - 일회성
    
    @IBAction func currMyPage(sender: UIStoryboardSegue) {
        // unwind 세그웨이
    }
    
    let viewModel = NMyPageViewModel() // MVVM 사용위한 뷰모델 선언
    let bag = DisposeBag()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 컬렉션 뷰에 인셋주려고
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        NRoutineInstanceTableView.isHidden = true
        layout()
        setUI()
        delegate()
        setData()
        event()
        NEditButton.isHidden = true // 기능 구현이 어려워서 일단 히든해버리자.
        NEditUnderBar.isHidden = true // 기능 구현이 어려워서 일단 히든해버리자.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NRoutineRepeatTableView.reloadData()
        print("reload")
    }
    
    func delegate() {
        NMyfamilyCollectionView.delegate = self
        NRoutineRepeatTableView.delegate = self
        NRoutineInstanceTableView.delegate = self
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
        NRoutineRepeatTableView.snp.makeConstraints {
            // 반복
            $0.top.equalTo(NRepeatButton.snp.bottom).offset(8)
            $0.left.equalTo(NcontentsBox.snp.left)
            $0.right.equalTo(NcontentsBox.snp.right)
            $0.bottom.equalToSuperview()
        }
        NRoutineInstanceTableView.snp.makeConstraints {
            // 일회성
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
        NRoutineRepeatTableView.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        }
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
                cell.reloadInputViews()
            }.disposed(by: bag)
        
        
        viewModel.dummyRoutineObservable
            .bind(to: NRoutineRepeatTableView.rx.items(
                    cellIdentifier: "RoutineCell",
                    cellType: RoutineTableViewCell.self)
            ) {  index, item, cell in
                
                cell.initUI(of: item)
                cell.isHighlighted = true
            }.disposed(by: bag)
        
        viewModel.dummydummyInstRoutineObservable
            .bind(to: NRoutineInstanceTableView.rx.items(
                    cellIdentifier: "RoutineCell",
                    cellType: RoutineTableViewCell.self)
            ) {  index, item, cell in
                cell.initUI(of: item)
            }.disposed(by: bag)
        
        
        
    }
    
    func event() {
        NRepeatButton.rx.tap
            .bind{ [self] in
                self.NRepeatUnderLine.image = UIImage(named: "Line 12")
                self.NInstantUnderLine.image = UIImage(named: "Line 11")
                self.NRepeatButton.tintColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
                self.NInstantButton.tintColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1)
                NRoutineRepeatTableView.isHidden = false
                NRoutineInstanceTableView.isHidden = true
            }
        NInstantButton.rx.tap
            .bind{ [self] in
                self.NRepeatUnderLine.image = UIImage(named: "Line 11")
                self.NInstantUnderLine.image = UIImage(named: "Line 12")
                self.NRepeatButton.tintColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1)
                self.NInstantButton.tintColor = UIColor(red: 0.371, green: 0.371, blue: 0.371, alpha: 1)
                NRoutineRepeatTableView.isHidden = true
                NRoutineInstanceTableView.isHidden = false
            }
        
        NEditButton.rx.tap
            .subscribe{
                print("수정하기 버튼")
            }
        
    }
}

extension NMyPageViewController : UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = view.frame.width - (view.frame.width - NcontentsBox.frame.width)
        let height = (143/374) * width
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index row : \(indexPath.row)")
        
        let commonRoutineStoryboard = UIStoryboard.init(name: "CommonRoutine", bundle: nil) // 스토리보드 객체 생성
        guard let vc = commonRoutineStoryboard.instantiateViewController(identifier: "CommonRoutine") as? CommonRoutineViewController else { return }
        vc.fromController = 1 // 어디서 왔는지 알리고
        
        if NRoutineInstanceTableView.isHidden == true { // 반복 버튼일 때,
            vc.verifyTitle = viewModel.dummyRoutineData[indexPath.row].Rtitle
            vc.date = viewModel.dummyRoutineData[indexPath.row].Rdate
            vc.iterator = viewModel.dummyRoutineData[indexPath.row].Riterator
            vc.time = viewModel.dummyRoutineData[indexPath.row].Rtime
            vc.detail = viewModel.dummyRoutineData[indexPath.row].Rdescription
            vc.idxpath = indexPath.row // 몇번째에서 왔는지!
        } else {
            vc.verifyTitle = viewModel.dummyInstRoutineData[indexPath.row].Rtitle
            vc.date = viewModel.dummyInstRoutineData[indexPath.row].Rdate
            vc.iterator = viewModel.dummyInstRoutineData[indexPath.row].Riterator
            vc.time = viewModel.dummyInstRoutineData[indexPath.row].Rtime
            vc.detail = viewModel.dummyInstRoutineData[indexPath.row].Rdescription
            vc.idxpath = indexPath.row // 몇번째에서 왔는지!
        }
        
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: false, completion: nil)
        
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
        
        NMyPageCellButton.rx
            .controlEvent(UIControl.Event.allTouchEvents)
            .bind {
                // 모든 이벤트에 하이라이트를 막아야지!! ㅜㅜ rxCocoa 공부할 때 배운거라 구현했넴 ㅜㅍ
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
                //print("tap")
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
    
    // 주의 : 사진 비율 1:1 아니면 완벽한 원이 아니라 짤린 원 만들어지니까 주의
    var dummyRoutineData = [
        RoutineModel(RoutineType: "Repeat", RprofileImage: "image 1", Rtitle: "약 ㅁㄴㅇㅎ", Rdescription: "뮷 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오전 04시 04분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Repeat", RprofileImage: "Mask Group (1)", Rtitle: "약 123", Rdescription: "엄마 ㅅㅎㅅ 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오전 06시 15분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Repeat", RprofileImage: "image 3", Rtitle: "약 ㅅㅎㅅ", Rdescription: "ㅁㄴㄹㅇ? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오후 04시 10분", RChallengeState: "  챌린지 시작  "),
    ]
    
    var dummyInstRoutineData = [
        RoutineModel(RoutineType: "Instance", RprofileImage: "image 2", Rtitle: "약 ㅁㄴ", Rdescription: "엄마 건강은 챙기고 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "월 수", Rtime: "오후 03시 00분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Instance", RprofileImage: "image 3", Rtitle: "약 ㅁㅎ", Rdescription: "엄마 건강은 챙기고 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "금", Rtime: "오후 03시 00분", RChallengeState: "  챌린지 시작  ")
    ]
    
    var dummyObsrvable: Observable<[MyPageCellModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
    var dummyRoutineObservable : Observable<[RoutineModel]> // NMyPageRoutineTableView에 반복하기에 들어갈 정보들
    var dummydummyInstRoutineObservable : Observable<[RoutineModel]> // 일회성 쪽에 들어갈 정보
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
        dummyRoutineObservable = Observable.of(dummyRoutineData)
        dummydummyInstRoutineObservable = Observable.of(dummyInstRoutineData)
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
    var RoutineType : String // 일회성인지 반복인지 타입을 지정
    var RprofileImage : String // 루틴 이미지
    var Rtitle : String // 루틴 타이틀
    var Rdescription : String // 상세내용
    var Rdate : String // 루틴 날짜
    var Riterator : String // 루틴 반복
    var Rtime : String // 루틴 시간
    var RChallengeState : String // 챌린지 도전중인지 확인하려고
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
    
    let cellHeightRatio : Double = 143/374 // cell height가 width에 종속적(가변한다)이라서 화면 비율 맞춰줄 필요가 있음
    
    
    func initUI(of item : RoutineModel) {
        cellLayout() // cell 내에서의 레이아웃 배치
        cellColor() // cell 모양 및 색
        event()
        
        REditButton.isHidden = true // 기능 구현이 어려워서 일단 히든해버리자.
        REditUnderLine.isHidden = true // 기능 구현이 어려워서 일단 히든해두기
        // setUI 구성
        RImage.then {
            $0.image = UIImage(named: item.RprofileImage)
            //print(57.65/2)
            $0.layer.cornerRadius = (57.65/2) // 이미지 크기 나누기 2해도 원 만들 수 있지롱
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        RTitle.then {
            $0.text = item.Rtitle
        }
        RDescription.then {
            $0.text = item.Rdescription
        }
        RDate.then {
            $0.text = item.Rdate
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        RIterator.then {
            $0.text = item.Riterator
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        RTime.then {
            $0.text = item.Rtime
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        REditButton.then {
            $0.tintColor = UIColor(red: 0.442, green: 0.442, blue: 0.442, alpha: 1)
            $0.isUserInteractionEnabled = true
        }
        REditUnderLine.then {
            $0.backgroundColor = UIColor(red: 0.442, green: 0.442, blue: 0.442, alpha: 1)
        }
        RChallengeButton.then {
            print("item ::: \(item)")
            $0.setTitle(item.RChallengeState, for: .normal) // 2칸 띄어야 모양 예뻐
            $0.tintColor = .white
            $0.layer.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1).cgColor
            $0.layer.cornerRadius = CGFloat((18 * cellHeightRatio)) + CGFloat((10 * cellHeightRatio))
        }
        
    }
    
    func cellLayout() {
        
        RImage.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.left.equalTo(12)
            $0.width.height.equalTo(57.65)
        }
        RTitle.snp.makeConstraints {
            $0.left.equalTo(RImage.snp.right).offset(10.11)
            $0.top.equalTo(17)
        }
        RDescription.snp.makeConstraints {
            $0.left.equalTo(RImage.snp.right).offset(11.11)
            $0.top.equalTo(RTitle.snp.bottom).offset(5 * cellHeightRatio)
            //$0.right.equalTo(REditButton.snp.left).offset(-24)
            $0.width.lessThanOrEqualTo(contentView.frame.width / 2)
        }
        RDateImage.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RDescription.snp.bottom).offset(11.17 * cellHeightRatio)
            $0.width.height.equalTo(RDate.frame.height)
        }
        RDate.snp.makeConstraints {
            $0.left.equalTo(RDateImage.snp.right).offset(7.75)
            $0.top.equalTo(RDateImage.snp.top)
        }
        RIterator.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RDate.snp.bottom).offset(4 * cellHeightRatio)
        }
        RTimeImage.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RIterator.snp.bottom).offset(8 * cellHeightRatio)
            $0.width.height.equalTo(RTime.frame.height)
        }
        RTime.snp.makeConstraints {
            $0.left.equalTo(RTimeImage.snp.right).offset(7.75)
            $0.top.equalTo(RTimeImage.snp.top)
        }
        RChallengeButton.snp.makeConstraints {
            $0.bottom.equalTo(-14 * cellHeightRatio)
            $0.right.equalTo(-13)
            $0.height.equalTo(38 * cellHeightRatio + 10)
        }
        REditButton.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.right.equalTo(-22)
        }
        REditUnderLine.snp.makeConstraints {
            $0.top.equalTo(REditButton.snp.bottom).offset(-1)
            $0.width.equalTo(REditButton.frame.width)
            $0.height.equalTo(1)
            $0.right.equalTo(REditButton.snp.right)
        }
    }
    
    func cellColor() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        contentView.superview?.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        contentView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    func event() {
        RChallengeButton.rx.tap
            .bind {
                self.RChallengeButton.setTitle("  도전중...  ", for: .normal)
                self.RChallengeButton.backgroundColor = .red
            }
        
        REditButton.rx.tap
            .bind {
                let commonRoutineStoryboard = UIStoryboard.init(name: "CommonRoutine", bundle: nil) // 스토리보드 객체 생성
                guard let vc = commonRoutineStoryboard.instantiateViewController(identifier: "CommonRoutine") as? CommonRoutineViewController else { return }
                vc.fromController = 2 // 어디서 왔는지 알리고 -> 2는 수정하기에서 왔다.
                
                let contentView = self.REditButton.superview // 슈퍼뷰로 접근해서
                let cell = contentView?.superview
                
                
            }
    }
}
