//
//  File.swift
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

// MARK::: WeekButton UI Then이용하여 처리
extension CommonRoutineViewController {
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
}
