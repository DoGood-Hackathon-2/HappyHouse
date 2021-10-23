//
//  CRAddDelegate.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications

extension CommonRoutineViewController {
    
    func addDelegate() {
        CRcollectionView.delegate = self
        YearTextField.delegate = self
        MonthTextField.delegate = self
        DayTextField.delegate = self
        HourTextField.delegate = self
        MinuteTextField.delegate = self
        
        // add delegate to all textfields to self (this view controller)
        CreateRoutineTextField.delegate = self
        RequestTextView.delegate = self
    }
}
