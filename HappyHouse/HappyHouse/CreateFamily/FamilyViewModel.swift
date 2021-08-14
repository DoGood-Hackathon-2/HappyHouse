//
//  AddMemberViewModel.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import Foundation
import RxSwift
import RxAlamofire

struct Member: Codable {
    let id: Int
    let nickname: String
    let image: String?
    
    static let EMPTY = Member(id: 0, nickname: "", image: "")
}

struct FamilyList: Codable {
    let message: String
    let memberList: [Member]
}

class FamilyViewModel {
    var bag = DisposeBag()
    var members = PublishSubject<[Member]>()
    
    init() {
        _ = RxAlamofire.requestData(.get, APIManager.getFamilyList(User.memberId))
            .map { (statusCode, data) in
                try JSONDecoder().decode(FamilyList.self, from: data)
            }
            .debug()
            .subscribe(onNext: { [weak self] familyList in
                var members = familyList.memberList
                members.append(Member.EMPTY)
                self?.members.onNext(members)
            })
            .disposed(by: bag)
    }
}
