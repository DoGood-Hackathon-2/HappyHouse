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

// MARK::: CRInnerDateBoxViewSetUI -> Then이용하여 데이터 처리
extension CommonRoutineViewController {
    func InnerDateBoxViewSetUI() {
        let figmaBoxRatio : CGFloat = 374 * 219
        let DateBoxRatio = DateBoxView.frame.width * 150 / figmaBoxRatio // 내 박스의 비율로 전환 - 세로길이 150 고정
        
        let DateBoxWidth = view.frame.width - (view.frame.width/7)
        let DateBoxWidthRatio = DateBoxWidth / 374
        
        
        YearTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(0)
            
            // UnderLine
            Yearborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 71.91 * DateBoxWidthRatio, height: 1.5)
            Yearborder.cornerRadius =  (DateBoxRatio * 9)
            Yearborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Yearborder)
            //Yearborder.isHidden = true
        }
        MonthTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(1)
            
            // UnderLine
            Monthborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 51.93 * DateBoxWidthRatio, height: 1.5)
            Monthborder.cornerRadius =  (DateBoxRatio * 9)
            Monthborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Monthborder)
            //Monthborder.isHidden = true
        }
        DayTextField.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(2)
            
            // UnderLine
            Dayborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: 51.93 * DateBoxWidthRatio, height: 1.5)
            Dayborder.cornerRadius =  (DateBoxRatio * 9)
            Dayborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Dayborder)
            //Dayborder.isHidden = true
            
        }
        WeekButtonUI() // 버튼 배치 UI구성
        TimeStackView.then {
            $0.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.clipsToBounds = true
            
        }
        //MARK ::: INNER TimeStackView
        HourTextField.then {
            //$0.backgroundColor = .red
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(3)
            
            // UnderLine
            Hourborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: (116 * DateBoxWidthRatio - Colon.frame.width)/2, height: 1.5)
            Hourborder.cornerRadius =  (DateBoxRatio * 9)
            Hourborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Hourborder)
            //Hourborder.isHidden = true
        }
        Colon.then {
            $0.text = ":"
        }
        MinuteTextField.then {
            //$0.backgroundColor = .blue
            $0.layer.cornerRadius = (DateBoxRatio * 17)
            $0.textAlignment = .center
            $0.borderStyle = .none
            $0.keyboardType = .numberPad
            $0.text = nowDateTime(4)
            
            // UnderLine
            Minuteborder.frame = CGRect(x: 0, y: $0.frame.size.height/4 * 3, width: (116 * DateBoxWidthRatio - Colon.frame.width)/2, height: 1.5)
            Minuteborder.cornerRadius =  (DateBoxRatio * 9)
            Minuteborder.backgroundColor = UIColor.green.cgColor
            $0.layer.addSublayer(Minuteborder)
            //Minuteborder.isHidden = true
        }
        AMButton.then {
            if nowDateTime(5) == "AM" {
                $0.setTitleColor(.black, for: .normal)
            } else {
                $0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }
        }
        PMButton.then {
            if nowDateTime(5) == "PM" {
                $0.setTitleColor(.black, for: .normal)
            } else {
                $0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }
        }
        TimeActivationButton.then {
            $0.setTitle("", for: .normal)
        }
        
        RequestLabel.then {
            $0.text = "요청메시지를 보내봐요"
        }
    }

}
