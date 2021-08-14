//
//  TableViewModel.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/15.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire



class MypageTableViewModel : UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var time: UILabel!
    
    let bag = DisposeBag()
    static let baseURL = "http://3.38.92.134/api/"
    let jsconDecoder: JSONDecoder = JSONDecoder()
}

extension MypageTableViewModel {
    func APICALL(_ requset : String, _ id : Int) {
        let urlString = MypageTableViewModel.baseURL + "\(id)/\(requset)"
        var data = json(.get, urlString)
            .debug()
            .subscribe(onNext : { print($0) })
            .disposed(by: bag)
//        let searchInfo: Welcome = try self.jsconDecoder.decode(Welcome.self, from: data)
//        
        
        //print(ss)
    }
}
//
//class RecommendViewModel {
//    
//    var recommends = [
//        Recommend(image: "recommend_1"),
//        Recommend(image: "recommend_2"),
//        Recommend(image: "recommend_3"),
//        Recommend(image: "recommend_4"),
//    ]
//    
//    var mypages = [
//        Recommend(image: "add_mypage_1x"),
//    ]
//    
//    
//    var recommendsObsrvable: Observable<[Recommend]> // HomeViewController에서 루틴 추천
//    var mypagesObsrvable: Observable<[Recommend]> // MyPageViewController에서 컬렉션 뷰
//    
//    init() {
//        recommendsObsrvable = Observable.of(recommends)
//        mypagesObsrvable = Observable.of(mypages)
//    }
//}
