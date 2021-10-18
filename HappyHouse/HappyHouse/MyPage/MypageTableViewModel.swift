/*
 ~MyPage/NMyPageViewController
 리팩토링 과정을 거치면서 변경
 (건우)
 */

////
////  TableViewModel.swift
////  HappyHouse
////
////  Created by Hamlit Jason on 2021/08/15.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//import RxAlamofire
//
//struct MypageTableItem {
//    let img: String
//    let title: String
//    let subTitle: String
//    let date : String
//    let day : String
//    let time : String
//}
//
//class MypageTableCell : UITableViewCell {
//    
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var subTitle: UILabel!
//    @IBOutlet weak var date: UILabel!
//    @IBOutlet weak var day: UILabel!
//    @IBOutlet weak var time: UILabel!
//    //@IBOutlet weak var challengeStartButton: UIButton!
//    @IBOutlet weak var TutorialButton: UIButton!
//    @IBAction func TutorialGo(_ sender: Any) {
//        TutorialButton.isHidden = true
//    }
//    
//    
//    func initUI(of recommend: MypageTableItem) {
//        self.imgView.image = UIImage(named: recommend.img)
//        self.imgView.layer.cornerRadius = imgView.frame.width / 2
//        self.imgView.layer.masksToBounds = true
//        self.title.text = recommend.title
//        self.subTitle.text = recommend.subTitle
//        self.date.text = recommend.date
//        self.day.text = recommend.day
//        self.time.text = recommend.time
////        self.challengeStartButton.backgroundColor = #colorLiteral(red: 0.4463604689, green: 0.6324821115, blue: 0.9996365905, alpha: 1)
////        self.challengeStartButton.layer.cornerRadius = 12
////        self.challengeStartButton.clipsToBounds = true
//    }
//    
//    
//    
//}
//
//class MypageTableViewModel{
//
//    
//    var repeatItems = [
//        MypageTableItem(img: "image 1", title: "학교가야지 얼릉 일어나", subTitle: "아침도 꼭 챙겨먹고", date: "2021.08.13", day: "매주 월 화 수 목 금", time: "오전 7시"),
//        MypageTableItem(img: "daughter_profile", title: "약 챙겨먹기", subTitle: "약 꼭 챙겨먹어", date: "2021.08.22", day: "매주 토 일", time: "오후 8시"),
//        MypageTableItem(img: "pablo-done 1", title: "수영강습", subTitle: "우리 모두 같이가요!", date: "2021.08.17", day: "매주 목 토", time: "오전 6시"),
//    ]
//    
//    var instanceItems = [
//        MypageTableItem(img: "Group 3072", title: "다음주 지방 출장~", subTitle: "집 청소도 하고 너무 어지럽히지마", date: "2021.08.20", day: "금 토", time: "오전 7시"),
//        MypageTableItem(img: "Group 3072", title: "장보기", subTitle: "필요한거 미리 말해줘", date: "2021.08.21", day: "토", time: "오후 3시"),
//        MypageTableItem(img: "pablo-done 1", title: "토익시험", subTitle: "목표는 990!", date: "2021.08.21", day: "토", time: "오전 8시"),
//    ]
//    
//    var instanceObsrvable: Observable<[MypageTableItem]> // HomeViewController에서 루틴 추천
//    var repeatObsrvable: Observable<[MypageTableItem]> // MyPageViewController에서 컬렉션 뷰
//    
//    init() {
//        instanceObsrvable = Observable.of(instanceItems)
//        repeatObsrvable = Observable.of(repeatItems)
//    }
//    
//    
//}
