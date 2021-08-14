//
//  AddMemberViewModel.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import Foundation
import RxSwift

struct Member {
    let image: String
    let name: String
    
    static let EMPTY = Member(image: "", name: "")
    
}

class AddMemberViewModel {
    let members = [//Member(image: "daughter_profile", name: "나"),
                   //Member(image: "daughter_profile", name: "너"),
                   Member(image: "daughter_profile", name: "우리"), Member.EMPTY]
    var memberObsrvable: Observable<[Member]>
    
    init() {
        memberObsrvable = Observable.of(members)
    }
}
