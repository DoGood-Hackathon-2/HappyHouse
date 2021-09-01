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

/*
 기기별 사이즈 대응 : RequestTextField의 height를 동적으로 규정하여 대응한다.
 */

class CommonRoutineViewController : UIViewController {
    
    @IBOutlet weak var PageTitle: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var RoutineTitle: UILabel!
    @IBOutlet weak var CreateRoutineTextField: UITextField!
    @IBOutlet weak var CRUnderLineView: UIView! // 크리에이티브 루틴 언더라인 뷰
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var WithWhoLabel: UILabel! // 누구와 함께 할까요 이름
    @IBOutlet weak var CRcollectionView: UICollectionView!
    @IBOutlet weak var WhenStartLabel: UILabel! // 언제 시작할까요?
    @IBOutlet weak var DateBoxView: UIView! // 시간이 들어갈 곳
    
    // DateBoxView IBOutlet
    @IBOutlet weak var CalenderIcon: UIImageView!
    @IBOutlet weak var YearTextField: UITextField!
    @IBOutlet weak var YearText: UILabel!
    @IBOutlet weak var MonthTextField: UITextField!
    @IBOutlet weak var MonthText: UILabel!
    @IBOutlet weak var DayTextField: UITextField!
    @IBOutlet weak var DayText: UILabel!
    @IBOutlet weak var WeekendCollectionView: UICollectionView!
    @IBOutlet weak var ClockIcon: UIImageView!
    @IBOutlet weak var TimeStackView: UIView! // 시간, 콜론, 분을 포함함
    @IBOutlet weak var HourTextField: UITextField! // inner StackView
    @IBOutlet weak var Colon: UILabel! // inner StackView
    @IBOutlet weak var MinuteTextField: UITextField! // inner StackView
    @IBOutlet weak var AMButton: UIButton!
    @IBOutlet weak var PMButton: UIButton!
    @IBOutlet weak var TimeActivationButton: UIButton!
    
    @IBOutlet weak var RequestLabel: UILabel! // 요청메시지를 보내봐요
    @IBOutlet weak var RequsetTextFieldContainer: UIView! // RequestTextField 배경 -> 글자에 inset 주려면 있어야 해
    @IBOutlet weak var RequestTextField: UITextField! // 기기별로 동적대응
    @IBOutlet weak var ChallengeAddButton: UIButton! // 챌린지 추가하기 버튼
 
    let viewModel = CRCollectionViewModel()
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CRcollectionView.delegate = self
        layout()
        setUI()
        setData()
    }
}

extension CommonRoutineViewController {
    
    func layout() { // 메인 레이아웃
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
            //$0.bottom.equalTo(-100)
            $0.height.equalTo(80)
        }
        WhenStartLabel.snp.makeConstraints {
            $0.top.equalTo(CRcollectionView.snp.bottom).offset(10)
            $0.left.equalTo(BackButton.snp.left)
            $0.width.lessThanOrEqualToSuperview()
        }
        DateBoxView.snp.makeConstraints {
            $0.top.equalTo(WhenStartLabel.snp.bottom).offset(10)
            $0.left.equalTo(BackButton.snp.left)
            $0.right.equalToSuperview().offset(-(view.frame.width/14))
            $0.height.equalTo(200)
        }
        InnerDateBoxViewLayout()
        RequestLabel.snp.makeConstraints {
            $0.top.equalTo(DateBoxView.snp.bottom).offset(10)
            $0.left.equalTo(BackButton.snp.left)
        }
        RequsetTextFieldContainer.snp.makeConstraints {
            $0.top.equalTo(RequestLabel.snp.bottom).offset(10)
            $0.left.equalTo(BackButton.snp.left)
            $0.right.equalToSuperview().offset(-(view.frame.width/14))
            $0.bottom.equalTo(ChallengeAddButton.snp.top).offset(-10)
        }
        RequestTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset((view.frame.width/14))
            $0.right.equalToSuperview().offset(-(view.frame.width/14))
        }
        ChallengeAddButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(42)
            $0.left.equalToSuperview().offset((view.frame.width/14))
            $0.right.equalToSuperview().offset(-(view.frame.width/14))
        }
    }
    
    func InnerDateBoxViewLayout() {
        // figma width heigth : 374 * 219
        let DateBoxWidth = view.frame.width - (view.frame.width/7)
        let DateBoxHeightRatio : CGFloat = 200/219
        let DateBoxWidthRatio : CGFloat = DateBoxWidth/374
        
        CalenderIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        YearTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(CalenderIcon.snp.right).offset(19.1 * DateBoxWidthRatio)
            $0.width.equalTo(71.91 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxHeightRatio)
        }
        YearText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(YearTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        MonthTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(YearText.snp.right).offset(15.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxHeightRatio)
        }
        MonthText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(MonthTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        DayTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(MonthText.snp.right).offset(16.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxHeightRatio)
        }
        DayText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalTo(DayTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        WeekendCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(91.31 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(27 * DateBoxWidthRatio)
            $0.right.equalTo(DayText.snp.right)
            $0.height.equalTo(49 * DateBoxHeightRatio)
        }
        ClockIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171.75 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        TimeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171.75 * DateBoxHeightRatio)
            $0.left.equalTo(ClockIcon.snp.right).offset(10.08 * DateBoxWidthRatio)
            $0.width.equalTo(116 * DateBoxWidthRatio)
            $0.height.equalTo(36 * DateBoxHeightRatio)
        }
        let TimeStackViewWidth = 116 * DateBoxWidthRatio
        let TimeStackViewHeight = 36 * DateBoxHeightRatio
        HourTextField.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo((TimeStackViewWidth - Colon.frame.width)/2)
        }
        Colon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        MinuteTextField.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo((TimeStackViewWidth - Colon.frame.width)/2)
        }
        
        AMButton.snp.makeConstraints {
            $0.bottom.equalTo(TimeStackView.snp.bottom)
            $0.top.equalTo(TimeStackView.snp.top)
            $0.left.equalTo(TimeStackView.snp.right).offset(14 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxWidthRatio)
        }
        PMButton.snp.makeConstraints {
            $0.bottom.equalTo(TimeStackView.snp.bottom)
            $0.top.equalTo(TimeStackView.snp.top)
            $0.left.equalTo(TimeStackView.snp.right).offset(58 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxWidthRatio)
        }
        TimeActivationButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171.75 * DateBoxHeightRatio)
            $0.right.equalTo(DayText.snp.right)
        }

    }
    
    func setUI() {
        //let figmaRatio : CGFloat = 374*219
        //let DateBoxRatio = DateBoxView.frame.width * 150 / figmaRatio
        let BoxViewWidth = view.frame.width - (view.frame.width/7)
        
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
        CRcollectionView.then {
            $0.backgroundColor = .none
        }
        WhenStartLabel.then {
            $0.text = "언제 시작할까요?"
        }
        DateBoxView.then {
            $0.layer.cornerRadius = (200 * BoxViewWidth * 20) / (374 * 219) // 피그마에 있는거 화면사이즈에 맞게 수학식으로 변환
            // 추후에 shadow 넣어주어야 함.
        }
        InnerDateBoxViewSetUI()
        RequsetTextFieldContainer.then {
            $0.layer.cornerRadius = (56 * BoxViewWidth * 44) / (374 * 219)
        }
        RequestTextField.then {
            $0.placeholder = "간단한 메시지를 적어보세요~!"
            RequestTextField.borderStyle = .none
        }
        ChallengeAddButton.then {
            $0.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = (42 * BoxViewWidth * 44) / (374 * 219)
            $0.setTitle("챌린지를 추가하세요", for: .normal)
        }
    }
    
    func InnerDateBoxViewSetUI() {
        let figmaRatio : CGFloat = 374*219
        let DateBoxRatio = DateBoxView.frame.width * 150 / figmaRatio // 내 박스의 비율로 전환 - 세로길이 150 고정
        
        YearTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
        MonthTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
        DayTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
        WeekendCollectionView.backgroundColor = .red
        TimeStackView.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.clipsToBounds = true
        }
        //MARK ::: INNER TimeStackView
        HourTextField.then {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
        Colon.then {
            $0.text = ":"
        }
        MinuteTextField.then {
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
        AMButton.then {
            $0.setTitleColor(.black, for: .normal)
        }
        PMButton.then {
            $0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
        }
        TimeActivationButton.then {
            $0.setTitle("", for: .normal)
        }
        
        RequestLabel.then {
            $0.text = "요청메시지를 보내봐요"
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
            }.disposed(by: bag)
    }
}

extension CommonRoutineViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 60)
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
