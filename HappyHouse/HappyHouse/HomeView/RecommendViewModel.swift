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
    
    
    var recommendsObsrvable: Observable<[Recommend]>
    
    init() {
        recommendsObsrvable = Observable.of(recommends)
    }
}
