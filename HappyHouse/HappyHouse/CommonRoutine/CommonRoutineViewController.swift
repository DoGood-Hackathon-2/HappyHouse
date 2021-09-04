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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceHeight = view.frame.height
        DeviceRatio = DeviceHeight / figmaHeight < 1.0 ? 1.0 : DeviceHeight / figmaHeight + 0.35
        addDelegate()
        layout()
        setUI()
        setData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // UIViewController에 있는 메소드로 화면 클릭시 내려감 단, collectionView가 위에 있으면 컬렉션 뷰 클릭스 반응하지 않게 된다는 단점 존재
        self.YearTextField.resignFirstResponder()
    }
    
    func addDelegate() {
        CRcollectionView.delegate = self
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
            Yearborder.isHidden = true
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
            Monthborder.backgroundColor = UIColor.red.cgColor
            $0.layer.addSublayer(Monthborder)
            Monthborder.isHidden = true
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
            Dayborder.backgroundColor = UIColor.red.cgColor
            $0.layer.addSublayer(Dayborder)
            Dayborder.isHidden = true
            
        }
        WeekButtonUI() // 버튼 배치 UI구성
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
        
    }
    
    func nowDateTime(_ index : Int) -> String {
        /*
         index 0 - year
         index 1 - month
         index 2 - day
         */
        let today = NSDate() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: today as Date)
        let arr = dateString.components(separatedBy: "-") // 분리해서 내보내주기!
        print(arr) //"2021"
        
        return arr[index]
    }
}

extension CommonRoutineViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 60)
    }
}

extension CommonRoutineViewController {   // 텍스트 필드 제약조건을 주기 위해서
    /*
     텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     1. 입력받는 길이를 제한하기 -> 코드로 최대길이 제한
     2. 입력이 끝나면 자동으로 키보드 내리기 -> 최대길이 도달하면 내리게 코드로 주기
     3. 터무니없는 입력값을 아예 비워버리기
     4. 입력이 끝나지 않았다면 다른 곳을 터치하여 포커스를 헤제하기
     5. 다시 입력할 때, 자동으로 텍스트 필드 비워버리기 -> UX 향상 -> 스토리보드에서 clear when editing begin으로 설정
     
     + Month나 Day의 경우에는 한자리만 입력하는 경우가 종종 발생할 수 있는데, 유저의 인식 향상을 위해 placeholder를 제공하면 좋겠다.
     placeholder에 제공하는 값은 오늘 날짜로 제공하면 좋지 않을까?
     + Year의 경우에는 대부분 고정되어 있으니 처음부터 값을 줘도 좋겠다!
     Year을 기본으로 주는 만큼 만약에 현재 날짜 및 시간보다 앞의 값을 입력한다면 입력하지 정보를 정정하고 Year의 조절이 있을 경우 언더라인이 나타나게한다.
     */
    private func YearTextField4(_ str : String) { // 최대길이 4까지
        self.Yearborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
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
        self.Monthborder.backgroundColor = UIColor.red.cgColor // 재입력시 빨간색으로
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
        self.Dayborder.backgroundColor = UIColor.red.cgColor
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

