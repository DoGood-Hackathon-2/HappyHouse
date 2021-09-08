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
    @IBOutlet weak var WeekendStackView: UIStackView! // week 담을 스택뷰
    @IBOutlet weak var WeekStackIndex0: UIButton! // 매주
    @IBOutlet weak var WeekStackIndex1: UIButton! // 월
    @IBOutlet weak var WeekStackIndex2: UIButton! // 화
    @IBOutlet weak var WeekStackIndex3: UIButton! // 수
    @IBOutlet weak var WeekStackIndex4: UIButton! // 목
    @IBOutlet weak var WeekStackIndex5: UIButton! // 금
    @IBOutlet weak var WeekStackIndex6: UIButton! // 토
    @IBOutlet weak var WeekStackIndex7: UIButton! // 일
    @IBOutlet weak var ClockIcon: UIImageView!
    @IBOutlet weak var TimeStackView: UIView! // 시간, 콜론, 분을 포함함
    @IBOutlet weak var HourTextField: UITextField! // inner StackView
    @IBOutlet weak var Colon: UILabel! // inner StackView
    @IBOutlet weak var MinuteTextField: UITextField! // inner StackView
    @IBOutlet weak var AMButton: UIButton!
    @IBOutlet weak var PMButton: UIButton!
    @IBOutlet weak var TimeActivationButton: UIButton!
    
    // bottom field
    @IBOutlet weak var RequestLabel: UILabel! // 요청메시지를 보내봐요
    @IBOutlet weak var RequsetTextFieldContainer: UIView! // RequestTextField 배경 -> 글자에 inset 주려면 있어야 해
    @IBOutlet weak var RequestTextField: UITextField! // 기기별로 동적대응
    @IBOutlet weak var ChallengeAddButton: UIButton! // 챌린지 추가하기 버튼
    
    
    let viewModel = CRCollectionViewModel() // 프로필 얼굴 + 이름 나오는 컬렉션 뷰
    let bag = DisposeBag()
    var DeviceHeight : CGFloat = 0.0
    var figmaHeight : CGFloat = 896 // 414 * 896
    var DeviceRatio : CGFloat = 1.0
    
    let Yearborder = CALayer() // 텍스트 필드에 값을 잘못 입력할 경우 사용자에게 알려주기 인지시켜 주기 위해 underline
    let Monthborder = CALayer()
    let Dayborder = CALayer()
    let Hourborder = CALayer()
    let Minuteborder = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceHeight = view.frame.height
        DeviceRatio = DeviceHeight / figmaHeight < 1.0 ? 1.0 : DeviceHeight / figmaHeight + 0.35
        addDelegate()
        layout()
        setUI()
        setData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // UIViewController에 있는 메소드로 화면 클릭시 내려감 단, collectionView가 위에 있으면 컬렉션 뷰 영역을 클릭하면 사임하지 않기에, 이 부분에 대한 로직 처리가 별도로 필요하다.
        self.YearTextField.resignFirstResponder()
        self.MonthTextField.resignFirstResponder()
        self.DayTextField.resignFirstResponder()
        self.HourTextField.resignFirstResponder()
        self.MinuteTextField.resignFirstResponder()
        
        // 텍스트 필드의 포커싱을 놓아줄 때, 입력된 글자가 부족할 때, 완전한 조건으로 보정해주는 작업이 있다면 UX를 향상
    }
    
    func addDelegate() {
        CRcollectionView.delegate = self
        YearTextField.delegate = self
        MonthTextField.delegate = self
        DayTextField.delegate = self
        HourTextField.delegate = self
        MinuteTextField.delegate = self
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
            $0.height.equalTo(150 * DeviceRatio)
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
            $0.height.equalTo(30)
            $0.left.equalToSuperview().offset((view.frame.width/14))
            $0.right.equalToSuperview().offset(-(view.frame.width/14))
        }
    }
    
    func InnerDateBoxViewLayout() {
        let DateBoxWidth = view.frame.width - (view.frame.width/7)
        let DateBoxHeightRatio : CGFloat = 150 * DeviceRatio / 219
        let DateBoxWidthRatio : CGFloat = DateBoxWidth / 374
        let DateBoxStaticHeight : CGFloat = 150 * DeviceRatio / 219
        
        CalenderIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        YearTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY) // 와 이렇게하면 정렬 가능하네 ㅜㅜ 대박,,
            $0.left.equalTo(CalenderIcon.snp.right).offset(19.1 * DateBoxWidthRatio)
            $0.width.equalTo(71.91 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        YearText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(YearTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        MonthTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(YearText.snp.right).offset(15.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        MonthText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(MonthTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        DayTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(MonthText.snp.right).offset(16.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        DayText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(DayTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        WeekendStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(91.31 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(27 * DateBoxWidthRatio)
            $0.right.equalTo(DayText.snp.right)
            $0.height.equalTo(49 * DateBoxStaticHeight)
        }
        ClockIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171.75 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        TimeStackView.snp.makeConstraints {
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(ClockIcon.snp.right).offset(10.08 * DateBoxWidthRatio)
            $0.width.equalTo(116 * DateBoxWidthRatio)
            $0.height.equalTo(36 * DateBoxStaticHeight)
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
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(TimeStackView.snp.right).offset(14 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxStaticHeight)
        }
        PMButton.snp.makeConstraints {
            $0.bottom.equalTo(TimeStackView.snp.bottom)
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(TimeStackView.snp.right).offset(58 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxStaticHeight)
        }
        TimeActivationButton.snp.makeConstraints {
            $0.centerY.equalTo(ClockIcon.snp.centerY)
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
            $0.layer.cornerRadius = (150 * BoxViewWidth * 20) / (374 * 219) // 피그마에 있는거 화면사이즈에 맞게 수학식으로 변환
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
            $0.layer.cornerRadius = (36 * BoxViewWidth * 44) / (374 * 219)
            $0.setTitle("챌린지를 추가하세요", for: .normal)
        }
    }
    
    func InnerDateBoxViewSetUI() {
        let figmaBoxRatio : CGFloat = 374 * 219
        let DateBoxRatio = DateBoxView.frame.width * 150 / figmaBoxRatio // 내 박스의 비율로 전환 - 세로길이 150 고정
        
        let DateBoxWidth = view.frame.width - (view.frame.width/7)
        let DateBoxWidthRatio = DateBoxWidth / 374
        
        
        YearTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(0)
            
            // UnderLine
            Yearborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 71.91 * DateBoxWidthRatio, height: 1.5)
            Yearborder.cornerRadius =  (DateBoxRatio * 9)
            Yearborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Yearborder)
            //Yearborder.isHidden = true
        }
        MonthTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(1)
            
            // UnderLine
            Monthborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 51.93 * DateBoxWidthRatio, height: 1.5)
            Monthborder.cornerRadius =  (DateBoxRatio * 9)
            Monthborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Monthborder)
            //Monthborder.isHidden = true
        }
        DayTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(2)
            
            // UnderLine
            Dayborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 51.93 * DateBoxWidthRatio, height: 1.5)
            Dayborder.cornerRadius =  (DateBoxRatio * 9)
            Dayborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Dayborder)
            //Dayborder.isHidden = true
            
        }
        WeekButtonUI() // 버튼 배치 UI구성
        TimeStackView.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.clipsToBounds = true
            
        }
        //MARK ::: INNER TimeStackView
        HourTextField.then {
            //$0.backgroundColor = .red
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(3)
            
            // UnderLine
            Hourborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: (116 * DateBoxWidthRatio - Colon.frame.width)/2, height: 1.5)
            Hourborder.cornerRadius =  (DateBoxRatio * 9)
            Hourborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Hourborder)
            //Hourborder.isHidden = true
        }
        Colon.then {
            $0.text = ":"
        }
        MinuteTextField.then {
            //$0.backgroundColor = .blue
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(4)
            
            // UnderLine
            Minuteborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: (116 * DateBoxWidthRatio - Colon.frame.width)/2, height: 1.5)
            Minuteborder.cornerRadius =  (DateBoxRatio * 9)
            Minuteborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Minuteborder)
            //Minuteborder.isHidden = true
        }
        AMButton.then {
            if nowDateTime(5) == "AM" {
                $0.setTitleColor(.black, for: .normal)
            } else {
                $0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }
        }
        PMButton.then {
            if nowDateTime(5) == "PM" {
                $0.setTitleColor(.black, for: .normal)
            } else {
                $0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }
        }
        TimeActivationButton.then {
            $0.setTitle("", for: .normal)
        }
        
        RequestLabel.then {
            $0.text = "요청메시지를 보내봐요"
        }
    }
    
    func WeekButtonUI() {
        WeekStackIndex0.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex1.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex2.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex3.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex4.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex5.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex6.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        }
        WeekStackIndex7.then {
            $0.tintColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
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

        YearTextField.rx.text.orEmpty
            .skip(1) // 구독 시 bind코드가 적용되는데 밑줄이 우리가 포커스를 잡은 시점부터 나타나길 바래서
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.YearTextField4($0)
                self.Yearborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag) // 메모리 누수를 막읍시다.
        
        MonthTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.MonthTextField2($0)
                self.Monthborder.isHidden = false
            })
            .disposed(by: bag)
        
        DayTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.DayTextField2($0)
                self.Dayborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        HourTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.HourTextField2($0)
                self.Hourborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        MinuteTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.MinuteTextField2($0)
                self.Minuteborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        AMButton.rx.tap
            .bind{
                self.AMButton.setTitleColor(.black, for: .normal)
                self.PMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }.disposed(by: bag)
        
        PMButton.rx.tap
            .bind{
                self.PMButton.setTitleColor(.black, for: .normal)
                self.AMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }.disposed(by: bag)
        
        TimeActivationButton.rx.tap
            .bind{
                if self.TimeActivationButton.image(for: .normal) == UIImage(systemName: "plus.circle") { // 비활성화 상태 -> 활성화 상태
                    if self.nowDateTime(5) == "AM" {
                        self.AMButton.setTitleColor(.black, for: .normal)
                        self.PMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                    } else {
                        self.PMButton.setTitleColor(.black, for: .normal)
                        self.AMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                    }
                    self.TimeActivationButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
                    self.PMButton.isEnabled = true
                    self.AMButton.isEnabled = true
                    self.MinuteTextField.isEnabled = true
                    self.MinuteTextField.textColor = .black
                    self.Minuteborder.isHidden = false
                    self.HourTextField.isEnabled = true
                    self.HourTextField.textColor = .black
                    self.Hourborder.isHidden = false
                    self.ClockIcon.tintColor = .black
                } else { // 활성화 상태 -> 비활성화 상태
                    self.TimeActivationButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
                    self.PMButton.isEnabled = false
                    self.PMButton.setTitleColor(.gray, for: .normal)
                    self.AMButton.isEnabled = false
                    self.AMButton.setTitleColor(.gray, for: .normal)
                    self.MinuteTextField.isEnabled = false
                    self.MinuteTextField.textColor = .gray
                    self.Minuteborder.isHidden = true
                    self.HourTextField.isEnabled = false
                    self.HourTextField.textColor = .gray
                    self.Hourborder.isHidden = true
                    self.ClockIcon.tintColor = .gray
                }
            }.disposed(by: bag)
        
        // MARK:: WeekendButtonClick 상태 확인
        WeekStackIndex0.rx.tap
            .bind{
                if self.WeekStackIndex0.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex0.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex1.rx.tap
            .bind{
                if self.WeekStackIndex1.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex1.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex1.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex2.rx.tap
            .bind{
                if self.WeekStackIndex2.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex2.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex2.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex3.rx.tap
            .bind{
                if self.WeekStackIndex3.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex3.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex3.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex4.rx.tap
            .bind{
                if self.WeekStackIndex4.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex4.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex4.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex5.rx.tap
            .bind{
                if self.WeekStackIndex5.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex5.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex5.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex6.rx.tap
            .bind{
                if self.WeekStackIndex6.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex6.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex6.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex7.rx.tap
            .bind{
                if self.WeekStackIndex7.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex7.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex7.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        
    }
    
    func realDateTime() -> String {
        let today = NSDate() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-a" // 2021-09-06-17-12
//        dateFormatter.locale = Locale(identifier:"ko_KR") // 위치는 한국
        let dateString = dateFormatter.string(from: today as Date)
        print(dateString)
        return dateString
    }
    
    func nowDateTime(_ index : Int) -> String {
        /*
         사용자는 미래의 일정을 예약함으로 현재 시간을 주면 사용자가 입력하는 동안에 시간이 흘러, 재입력해야 하는 불편함이 발생한다.
         이를 조정하고자 30분 후의 시간을 nowDateTime으로 지정하겠다.
         
         index 0 - year
         index 1 - month
         index 2 - day
         index 3 - hour : 24시간제
         index 4 - minute
         index 5 - AM,PM
         */

        
        let dateString = realDateTime()
        var arr = dateString.components(separatedBy: "-") // 분리해서 내보내주기
        
        arr[4] = "\(Int(arr[4])! + 30)" // 30분 더하기
        
        self.MonthTextField.text = arr[1] // 실제로 반환되지는 않지만, 내부 로직에서 checklastDay와 nowDateTime이 서로서로 참조하고 있어서 자칫 잘못하면 무한루프가 발생함. 무한 루프가 발생함. 이 코드가 존재하면 두 개의 로직을 확인해 보았을 때, 무한루프에 빠지지 않게 되어서 설계상으로 필요한 코드이다.
        
        // MARK:: 30을 더했을 때의 알고리즘 로직
        if Int(arr[4])! > 60 { // 60분을 넘어가면
            arr[4] = "\(Int(arr[4])! - 60)" //  분에서 60을 뺴준다.
            arr[3] = "\(Int(arr[3])! + 1)"
            
            if Int(arr[3])! > 23 { // 24부터는 넘어가면 하루를 더해야한다.
                arr[3] = "01" // 시간이 다음 날로 바뀌니까 01로 바꿔준다.
                arr[5] = "AM" // 다음날로 넘어갔다면 AM으로 변경
                if checklastDay() == Int(arr[2]) { // 해당 달의 마지막 날이라면
                    arr[2] = "01" // 1일로 초기화하고
                    arr[1] = "\(Int(arr[1])! + 1)" // 월을 1 올린다.
                    
                    if Int(arr[1])! > 12 { // 12월을 넘어가면
                        arr[1] = "01" // 1월로 초기화하고
                        arr[0] = "\(Int(arr[0])! + 1)" // 년도를 1을 더한다
                    }
                } else { // 해당날이 마지막 날이 아니라면 현재 날짜에 1을 더한다.
                    arr[2] = "\(Int(arr[2])! + 1)" // day에 1을 더한다.
                }
            }
            
        }
        
        // MARK:: 30분을 더한 후에 문자열 문자열 길이를 완전하게 해주는 로직
        if Int(arr[3])! > 12 { // 24시간제로 받아서 12시간 값을 변환해주는 과정이 필요하다.
            arr[3] = "\(Int(arr[3])! - 12)"
            if arr[3].count == 1 { // 한자리 수이면
                arr[3] = "0\(arr[3])"
            }
        }
        
        if arr[4].count == 1 { // 한자리 수이면
            arr[4] = "0\(arr[4])"
        }
        
        return arr[index]
    }
    
    func checkLeapYear() -> Bool{ // 윤년인지 아닌지 체크하는 함수
        
        guard let year = Int(self.YearTextField.text!) else {
            self.YearTextField.text = nowDateTime(0)
            return false
        }
        
        if( (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) {
            return true // 윤년
        } else {
            return false // 윤년 아님
        }
    }
    
    func checklastDay() -> Int { // 이번달이 몇일까지 있는지 체크하는 함수
        guard let month = Int(self.MonthTextField.text!) else { // 월이 비워져 있으면
            // 여기서 팁! month가 비었지만, else에서 month가 채워져서 guard문으로 끝나지 않고, switch쪽으로 넘어간다.
            self.MonthTextField.text = nowDateTime(1) // 월을 채워주고
            self.Monthborder.backgroundColor = UIColor.green.cgColor
            return 1
        }
        switch month {
        case 1,3,5,7,8,10,12: // 31일까지 있는 달
            return 31
        case 4,6,9,11 : // 30일까지 있는 달
            return 30
        case 2 : // 윤년인지 아닌지 판단해서 리턴해줌
            if checkLeapYear() { return 29 } else { return 28 } // 함수는 3항연산자로 못바꿀까?
        default:
            return -1 // 에러나면 -1 리턴해줌
        }
    }
    
    func fillOtherField() {
        // 이 함수는 텍스트 필드 입력 중 다른 텍스트 필드 클릭 시, 텍스트 필드가 완전한 형태가 아니라면 완전하게 채워주는 작업
        if YearTextField.text?.count != 4 {
            YearTextField.text = nowDateTime(0)
        }
    }
}

extension CommonRoutineViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 60)
    }
}

extension CommonRoutineViewController : UITextFieldDelegate {   // 텍스트 필드 제약조건을 주기 위해서
    /*
     함수명 규칙 : IBOutlet 이름 + 최대 글자 길이
     
     첫번째 줄 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     1. 입력받는 길이를 제한하기 -> 코드로 최대길이 제한
     2. 입력이 끝나면 자동으로 키보드 내리기 -> 최대길이 도달하면 내리게 코드로 주기
     3. 터무니없는 입력값에는 현재 날짜로 초기화 -> 코드로 구현
     4. 입력이 끝나지 않았다면 다른 곳을 터치하여 포커스를 헤제하기
     5. 다시 입력할 때, 자동으로 텍스트 필드 비워버리기 -> UX 향상 -> 스토리보드에서 clear when editing begin으로 설정
     
     + Month나 Day의 경우에는 한자리만 입력하는 경우가 종종 발생할 수 있는데, 유저의 인식 향상을 위해 placeholder를 제공하면 좋겠다.
     placeholder에 제공하는 값은 오늘 날짜로 제공하면 좋지 않을까?
     + Year의 경우에는 대부분 고정되어 있으니 처음부터 값을 줘도 좋겠다!
     Year을 기본으로 주는 만큼 만약에 현재 날짜 및 시간보다 앞의 값을 입력한다면 입력하지 정보를 정정하고 Year의 조절이 있을 경우 언더라인이 나타나게한다.
     
     Hour, Minute 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
    
     세번째 줄 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     1. 입력받는 길이 제한 -> 코드로 길이 제한
     2. 입력이 끝나면 자동으로 키보드 내리기 -> 최대길이 도달하면 내리게 코드로 주기
     3. 터무니없는 값에는 현재 시간으로 초기화 -> 코드로 구현
     4. 입력이 끝나지 않았다면 다른 곳 터치시 포커스 헤제
     5.
     */
    
    func textFieldDidEndEditing(_ textField: UITextField) { // 텍스트 필드가 포커스를 사임하기 직전에 호출되는 메소드 이 코드가 존재하는 이유는 포커스를 놓을 때, 필드를 안전하게 채워주기 위함.
        // 텍스트 필드에서 다른 텍스트 필드 클릭 시, touchesBegan 메소드로는 사임 여부를 확인할 수가 없어서 코드로 구현하였다.
        if textField == YearTextField && YearTextField.text?.count ?? 0 < 4 { // 사임하는 텍스트 필드의 내용 길이가 조건보다 작다면, 채워주자.
            YearTextField.text = nowDateTime(0)
            Yearborder.backgroundColor = UIColor.green.cgColor
        }
        
        if textField == MonthTextField && MonthTextField.text?.count ?? 0 < 2 {
            if MonthTextField.text?.count == 1 && MonthTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                MonthTextField.text = "0\(MonthTextField.text!)"
            } else {
                MonthTextField.text = nowDateTime(1)
            }
            Monthborder.backgroundColor = UIColor.green.cgColor
        } else if textField == DayTextField && DayTextField.text?.count ?? 0 < 2 {
            if DayTextField.text?.count == 1 && DayTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                DayTextField.text = "0\(DayTextField.text!)"
            } else {
                DayTextField.text = nowDateTime(2)
            }
            self.Dayborder.backgroundColor = UIColor.green.cgColor
        } else if textField == HourTextField && HourTextField.text?.count ?? 0 < 2 {
            if HourTextField.text?.count == 1 && HourTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                HourTextField.text = "0\(HourTextField.text!)"
            } else {
                HourTextField.text = nowDateTime(3)
            }
            self.Hourborder.backgroundColor = UIColor.green.cgColor
        } else if textField == MinuteTextField && MinuteTextField.text?.count ?? 0 < 2 {
            if MinuteTextField.text?.count == 1 { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                MinuteTextField.text = "0\(MinuteTextField.text!)"
            } else {
                MinuteTextField.text = nowDateTime(4)
            }
            self.Minuteborder.backgroundColor = UIColor.green.cgColor
        }
        
        
    }
    
    // MARK:: InnerBox 첫번째 줄
    
    private func YearTextField4(_ str : String) { // 최대길이 4까지
        
        if YearTextField.text?.count ?? 0 < 4 { // 입력 시에 호출 된다.
            self.Yearborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 4 {
            let index = str.index(str.startIndex, offsetBy: 4)
            self.YearTextField.text = String(str[..<index])
        } else if str.count == 4 {
            if Int(str)! < Int(nowDateTime(0))! { // 올해보다 이전이라면
                self.YearTextField.text = nowDateTime(0) // 올해값으로 정정
            }
            
            if !checkLeapYear() && self.MonthTextField.text == "02" && self.DayTextField.text == "29" { // 윤년이 아닌데, 2월 29일로 설정되어 있다면
                self.DayTextField.text = "28" // 28일로 변경
            }
            
            self.Yearborder.backgroundColor = UIColor.green.cgColor
            self.YearTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    private func MonthTextField2(_ str : String) { // 최대길이 2까지
        
        if MonthTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Monthborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.MonthTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 12 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 이번달로 설정
                self.MonthTextField.text = nowDateTime(1)
            } else { // 정상적으로 입력 되었으면
                self.Monthborder.backgroundColor = UIColor.green.cgColor
            }
            
            if self.DayTextField.text != "" { // 일이 비어있다면 넘어가도록 설계
                if checklastDay() < Int(self.DayTextField.text!)! { // 일이 입력되어 있는 상태에서 월을 변경할 때, 마지막 날이 이번달에 없는 날이면 변경하기 위한 로직
                    self.DayTextField.text = "\(checklastDay())"
                }
            }
            
            self.MonthTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    private func DayTextField2(_ str : String) { // 최대길이 2까지
        
        if DayTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Dayborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.DayTextField.text = String(str[..<index])
        } else if str.count == 2 {
            // 고려 해야할 점 -> 윤년, 월, 년,월이 입력되지 않은 경우
            if checklastDay() < Int(self.DayTextField.text!)! { // 그 달에 없는 날짜이면
                self.DayTextField.text = "\(checklastDay())"
            }
            self.Dayborder.backgroundColor = UIColor.green.cgColor
            self.DayTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    
    
    // MARK:: InnerBox 세번째 줄
    
    private func HourTextField2(_ str : String) { // 시간 최대 2자리까지
        
        if HourTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Hourborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.HourTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 12 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 시간값 현재 시간으로 초기화
                self.HourTextField.text = nowDateTime(3)
            } else { // 정상적으로 입력 되었으면
    
            }
            
            self.Hourborder.backgroundColor = UIColor.green.cgColor
            self.HourTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    
    private func MinuteTextField2(_ str : String) { // 시간 최대 2자리까지
        
        if MinuteTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Minuteborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.MinuteTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 59 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 시간값 현재 시간으로 초기화
                self.MinuteTextField.text = nowDateTime(3)
            } else { // 정상적으로 입력 되었으면

            }
            
            self.Minuteborder.backgroundColor = UIColor.green.cgColor
            self.MinuteTextField.resignFirstResponder() // 키보드 내리기
        }
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

