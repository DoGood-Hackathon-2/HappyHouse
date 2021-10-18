//
//  CRTextFiledRestraint.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/18.
//

//
//  CRTime.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications

// MARK::: WeekButton UI Then이용하여 처리
extension CommonRoutineViewController {
  
    func fillOtherField() {
        // 이 함수는 텍스트 필드 입력 중 다른 텍스트 필드 클릭 시, 텍스트 필드가 완전한 형태가 아니라면 완전하게 채워주는 작업
        if YearTextField.text?.count != 4 {
            YearTextField.text = nowDateTime(0)
        }
    }
    
    func ChecktheOption() {
        if self.CreateRoutineTextField.text == "" { // 텍스트가 비어있으면
            // out
            //print("CreateRoutineTextField out")
            alert("챌린지 제목을 입력해주세요.")
        } else if Int(self.YearTextField.text!)! < Int(self.nowDateTime(0))! { // 년도가 올해보다 이전이면
            // out
            //print("YearTextField out")
            alert("날짜를 다시 확인해주세요.")
            self.Yearborder.backgroundColor = UIColor.red.cgColor
        } else if Int(self.YearTextField.text!)! == Int(self.nowDateTime(0))! { // 년도가 같아
            if Int(self.MonthTextField.text!)! < Int(self.nowDateTime(1))! { // 월이 뒤야
                // out
                //print("MonthTextField out")
                alert("날짜를 다시 확인해주세요.")
                self.Monthborder.backgroundColor = UIColor.red.cgColor
            } else if Int(self.MonthTextField.text!)! == Int(self.nowDateTime(1))! { // 월이 같아
                if Int(self.DayTextField.text!)! < Int(self.nowDateTime(2))! { // 일이 뒤야
                    // out
                    //print("DayTextField out")
                    alert("날짜를 다시 확인해주세요.")
                    self.Dayborder.backgroundColor = UIColor.red.cgColor
                } else if Int(self.DayTextField.text!)! == Int(self.nowDateTime(2))! { // 일이 같아
                    // TimeActivationButton 상태 검사
                    if self.TimeActivationButton.currentImage == UIImage(systemName: "plus.circle") { // plus.circle이면 비활성화 상태임 -> 조건 만족
                        //print("TimeActivationButton ok")
                        // ok
                        okOption()
                    } else {
                        // 활성화 상태라 AM,PM 검사를 해야한다.
                        let userChoice : String // 유저가 선택한 AM,PM
                        if self.AMButton.currentTitleColor == .black { // 유저가 AM,PM중 고른거
                            userChoice = "AM" // AM
                        } else {
                            userChoice = "PM" // PM
                        }
                        
                        if self.nowDateTime(5) == "PM" && userChoice == "AM" {
                            // out -> 년 월 일 다 같은데 이 조건이면 당연히 안되겠지?
                            //print("userChoice out")
                            alert("시간을 다시 확인해 주세요")
                            self.Hourborder.backgroundColor = UIColor.red.cgColor
                            self.Minuteborder.backgroundColor = UIColor.red.cgColor
                        } else if self.nowDateTime(5) == "AM" && userChoice == "PM" {
                            // 이 상태에서는 조건 만족 -> 년 월 일 다 같은데 실제 시간은 AM인데 유저가 고른시간 PM이면 무조건 만족하지
                            //print("ok")
                            okOption()
                        } else { // self.nowDateTime(5) == userChoice 의 경우 -> 조건 검사를 시행해야 한다.
                            if Int(self.HourTextField.text!)! < Int(self.nowDateTime(3))! { // 시간이 뒤야
                                // out
                                //print("HourTextField out")
                                alert("시간을 다시 확인해 주세요")
                                self.Hourborder.backgroundColor = UIColor.red.cgColor
                            } else if Int(self.HourTextField.text!)! == Int(self.nowDateTime(3))! { // 시간이 같아
                                if Int(self.MinuteTextField.text!)! <= (Int(self.nowDateTime(4))! - 30) { // 분이 같거나 뒤야 + 근데 내가 nowtime에서 분을 30분 앞으로 땡겨두어서 30을 빼주어야 realtime이 된다.
                                    // out
                                    //print("MinuteTextField out")
                                    alert("시간을 다시 확인해 주세요")
                                    self.Minuteborder.backgroundColor = UIColor.red.cgColor
                                } else {
                                    //print("Ok")
                                    okOption()
                                    // 여기에 도착했다면 조건이 완벽하게 설정 되었네요~!^_^
                                }
                            }
                        }
                    }
                    
                    
                } else {
                    //print("else3")
                    // 년 월 같은데 일이 뒤라서 Ok
                    okOption()
                }
            } else {
                //print("else2")
                // 년이 같은데 월이 뒤라서 ok
                okOption()
            }
        } else {
            //print("else1")
            // 년도가 뒤라서 ok
            okOption()
        }
    }
    
}

