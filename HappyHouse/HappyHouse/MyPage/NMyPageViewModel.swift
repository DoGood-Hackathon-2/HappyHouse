//
//  NMyPageViewModel.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then


struct MyPageCellModel {
    var ButtonImage : String // 이미지가 들어가지만 클릭해서 이벤트 처리를 해야해서 걍 버튼으로 만들면 더 좋을거 같아서 이렇게 설계하기로
}

class NMyPageViewModel {
    // viewModel은 여러 곳에서 재사용되어야 한다. 그래야 의미가 있어짐
    
    var dummyData = [
        // 나중에 API로 데이터 받아와서 그 배열에 마지막에 add_mypage 넣어주기 또한 더하기 버튼의 경우는 Index컨트롤해서 크기 더 작게 만들기
        MyPageCellModel(ButtonImage: "add_mypage"),
        MyPageCellModel(ButtonImage: "image 1"),
        MyPageCellModel(ButtonImage: "image 2"),
        MyPageCellModel(ButtonImage: "image 3"),
        MyPageCellModel(ButtonImage: "image 1"),
    ]
    
    // 주의 : 사진 비율 1:1 아니면 완벽한 원이 아니라 짤린 원 만들어지니까 주의
    var dummyRoutineData = [
        RoutineModel(RoutineType: "Repeat", RprofileImage: "image 1", Rtitle: "약 ㅁㄴㅇㅎ", Rdescription: "뮷 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오전 04시 04분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Repeat", RprofileImage: "Mask Group (1)", Rtitle: "약 123", Rdescription: "엄마 ㅅㅎㅅ 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오전 06시 15분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Repeat", RprofileImage: "image 3", Rtitle: "약 ㅅㅎㅅ", Rdescription: "ㅁㄴㄹㅇ? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "매주 월 수 금", Rtime: "오후 04시 10분", RChallengeState: "  챌린지 시작  "),
    ]
    
    var dummyInstRoutineData = [
        RoutineModel(RoutineType: "Instance", RprofileImage: "image 2", Rtitle: "약 ㅁㄴ", Rdescription: "엄마 건강은 챙기고 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "월 수", Rtime: "오후 03시 00분", RChallengeState: "  챌린지 시작  "),
        RoutineModel(RoutineType: "Instance", RprofileImage: "image 3", Rtitle: "약 ㅁㅎ", Rdescription: "엄마 건강은 챙기고 있어? 약 꼭 챙겨먹고 사랑해", Rdate: "2021. 08. 13", Riterator: "금", Rtime: "오후 03시 00분", RChallengeState: "  챌린지 시작  ")
    ]
    
    var dummyObsrvable: Observable<[MyPageCellModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
    var dummyRoutineObservable : Observable<[RoutineModel]> // NMyPageRoutineTableView에 반복하기에 들어갈 정보들
    var dummydummyInstRoutineObservable : Observable<[RoutineModel]> // 일회성 쪽에 들어갈 정보
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
        dummyRoutineObservable = Observable.of(dummyRoutineData)
        dummydummyInstRoutineObservable = Observable.of(dummyInstRoutineData)
    }
}
