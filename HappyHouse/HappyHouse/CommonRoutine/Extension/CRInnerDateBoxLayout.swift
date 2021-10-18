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

extension CommonRoutineViewController {
    func InnerDateBoxViewLayout() {
        let DateBoxWidth = view.frame.width - (view.frame.width/7)
        let DateBoxHeightRatio : CGFloat = 150 * DeviceRatio / 219
        let DateBoxWidthRatio : CGFloat = DateBoxWidth / 374
        let DateBoxStaticHeight : CGFloat = 150 * DeviceRatio / 219
        
        CalenderIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32.37 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        YearTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY) // 와 이렇게하면 정렬 가능하네 ㅜㅜ 대박,,
            $0.left.equalTo(CalenderIcon.snp.right).offset(19.1 * DateBoxWidthRatio)
            $0.width.equalTo(71.91 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        YearText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(YearTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        MonthTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(YearText.snp.right).offset(15.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        MonthText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(MonthTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        DayTextField.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(MonthText.snp.right).offset(16.56 * DateBoxWidthRatio)
            $0.width.equalTo(51.93 * DateBoxWidthRatio)
            $0.height.equalTo(35.87 * DateBoxStaticHeight)
        }
        DayText.snp.makeConstraints {
            $0.centerY.equalTo(CalenderIcon.snp.centerY)
            $0.left.equalTo(DayTextField.snp.right).offset(5.59 * DateBoxWidthRatio)
        }
        WeekendStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(91.31 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(27 * DateBoxWidthRatio)
            $0.right.equalTo(DayText.snp.right)
            $0.height.equalTo(49 * DateBoxStaticHeight)
        }
        ClockIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(171.75 * DateBoxHeightRatio)
            $0.left.equalToSuperview().offset(29.12 * DateBoxWidthRatio)
        }
        TimeStackView.snp.makeConstraints {
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(ClockIcon.snp.right).offset(10.08 * DateBoxWidthRatio)
            $0.width.equalTo(116 * DateBoxWidthRatio)
            $0.height.equalTo(36 * DateBoxStaticHeight)
        }
        let TimeStackViewWidth = 116 * DateBoxWidthRatio
        let TimeStackViewHeight = 36 * DateBoxHeightRatio
        HourTextField.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo((TimeStackViewWidth - Colon.frame.width)/2)
        }
        Colon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        MinuteTextField.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo((TimeStackViewWidth - Colon.frame.width)/2)
        }
        
        AMButton.snp.makeConstraints {
            $0.bottom.equalTo(TimeStackView.snp.bottom)
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(TimeStackView.snp.right).offset(14 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxStaticHeight)
        }
        PMButton.snp.makeConstraints {
            $0.bottom.equalTo(TimeStackView.snp.bottom)
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.left.equalTo(TimeStackView.snp.right).offset(58 * DateBoxWidthRatio)
            $0.width.equalTo(42 * DateBoxStaticHeight)
        }
        TimeActivationButton.snp.makeConstraints {
            $0.centerY.equalTo(ClockIcon.snp.centerY)
            $0.right.equalTo(DayText.snp.right)
        }
    }
}
