//
//  CommonRoutineCRViewModel.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications


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
