//
//  RecommadModel.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/15.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct Recommend {
    let image: String
    static let EMPTY = Recommend(image: "")
}

class RecommendViewModel {
    
    var recommends = [
        Recommend(image: "recommend_1"),
        Recommend(image: "recommend_2"),
        Recommend(image: "recommend_3"),
        Recommend(image: "recommend_4"),
    ]
    
    var mypages = [
        //Recommend(image: "Mask Group"),
        Recommend(image: "Mask Group (3)"),
        Recommend(image: "Mask Group (2)-1"),
        Recommend(image: "add_mypage_1x"),
    ]
    
    
    var recommendsObsrvable: Observable<[Recommend]> // HomeViewController에서 루틴 추천
    var mypagesObsrvable: Observable<[Recommend]> // MyPageViewController에서 컬렉션 뷰
    
    init() {
        recommendsObsrvable = Observable.of(recommends)
        mypagesObsrvable = Observable.of(mypages)
    }
}
