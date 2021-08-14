//
//  CreateRoutineViewModel.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class NewRoutineViewModel {
    var bag = DisposeBag()
    var members = PublishSubject<[Member]>()
    
    init() {
        _ = RxAlamofire.requestData(.get, APIManager.getFamilyList(User.memberId))
            .map { (statusCode, data) in
                try JSONDecoder().decode(FamilyList.self, from: data)
            }
            .debug()
            .subscribe(onNext: { [weak self] familyList in
                self?.members.onNext(familyList.memberList)
            })
            .disposed(by: bag)
    }
}
