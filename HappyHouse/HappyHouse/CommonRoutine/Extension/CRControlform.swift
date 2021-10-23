//
//  CRControlform.swift
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
import UserNotifications

// MARK::: CommonRoutione으로 사용하다보니, 어디서 왔는지 확인해야할 필요가 있는데, 예를 들면 생성인지, 아니면 확인인지에 따라서 UI를 다르게 보여주기 위함.
extension CommonRoutineViewController {
    
    func controlloerForm(_ option : Int) { // 0이면 생성, 1이면 확인
        // 어디서 왔는지에 따라 확인할 페이지인지, 아니면 생성 페이지인지를 결정
        if option == 1 {
            PageTitle.isHidden = true
            VerfityTitle.isHidden = false
            
            RoutineTitle.isHidden = true
            CreateRoutineTextField.isHidden = true
            CRUnderLineView.isHidden = true
            
            // MARK:: 데이터
            WithWhoLabel.text = "함께하는 사람"
            WhenStartLabel.text = "챌린지 시간"
            
            YearTextField.text = dateSplit(0)// 0000
            MonthTextField.text = dateSplit(1)// 00
            DayTextField.text = dateSplit(2)// 00
            Yearborder.isHidden = true
            Monthborder.isHidden = true
            Dayborder.isHidden = true
            
            WeekStackIndex0.isUserInteractionEnabled = false
            WeekStackIndex1.isUserInteractionEnabled = false
            WeekStackIndex2.isUserInteractionEnabled = false
            WeekStackIndex3.isUserInteractionEnabled = false
            WeekStackIndex4.isUserInteractionEnabled = false
            WeekStackIndex5.isUserInteractionEnabled = false
            WeekStackIndex6.isUserInteractionEnabled = false
            WeekStackIndex7.isUserInteractionEnabled = false
            
            for i in iteratorSplit() {
                if i == "매주" {
                    WeekStackIndex0.setTitleColor(.black, for: .normal)
                } else if i == "월" {
                    WeekStackIndex1.setTitleColor(.black, for: .normal)
                } else if i == "화" {
                    WeekStackIndex2.setTitleColor(.black, for: .normal)
                } else if i == "수" {
                    WeekStackIndex3.setTitleColor(.black, for: .normal)
                } else if i == "목" {
                    WeekStackIndex4.setTitleColor(.black, for: .normal)
                } else if i == "금" {
                    WeekStackIndex5.setTitleColor(.black, for: .normal)
                } else if i == "토" {
                    WeekStackIndex6.setTitleColor(.black, for: .normal)
                } else if i == "일" {
                    WeekStackIndex7.setTitleColor(.black, for: .normal)
                }
            }
            
            RequestLabel.text = "요청 메시지~!"
            
            HourTextField.isUserInteractionEnabled = false
            MinuteTextField.isUserInteractionEnabled = false
            AMButton.isUserInteractionEnabled = false
            PMButton.isUserInteractionEnabled = false
            Hourborder.isHidden = true
            Minuteborder.isHidden = true
            TimeActivationButton.isHidden = true
            
            HourTextField.text = timeSplit()[1]
            MinuteTextField.text = timeSplit()[2]
            
            if timeSplit()[0] == "오전" {
                AMButton.setTitleColor(.black, for: .normal)
                PMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            } else {
                PMButton.setTitleColor(.black, for: .normal)
                AMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }
            
            RequestTextView.isUserInteractionEnabled = false
            RequestTextView.text = detail
            RequestTextView.textColor = .black
            
            //ChallengeAddButton.setTitle("챌린지 시작하기", for: .normal)
            ChallengeAddButton.isHidden = true
            
        } else {
            PageTitle.isHidden = false
            VerfityTitle.isHidden = true
            
            RoutineTitle.isHidden = false
            CreateRoutineTextField.isHidden = false
            CRUnderLineView.isHidden = false
            ChallengeAddButton.isHidden = false
            // MARK:: 데이터
            
        }
    }
    
}
