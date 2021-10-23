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

// MARK::: textView 및 textField Input 조건을 제한하기 위해 -> 유저의 잘못된 입력 막기
extension CommonRoutineViewController : UITextFieldDelegate {   // 텍스트 필드 제약조건을 주기 위해서
    /*
     함수명 규칙 : IBOutlet 이름 + 최대 글자 길이
     
     첫번째 줄 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     1. 입력받는 길이를 제한하기 -> 코드로 최대길이 제한
     2. 입력이 끝나면 자동으로 키보드 내리기 -> 최대길이 도달하면 내리게 코드로 주기
     3. 터무니없는 입력값에는 현재 날짜로 초기화 -> 코드로 구현
     4. 입력이 끝나지 않았다면 다른 곳을 터치하여 포커스를 헤제하기
     5. 다시 입력할 때, 자동으로 텍스트 필드 비워버리기 -> UX 향상 -> 스토리보드에서 clear when editing begin으로 설정
     
     + Month나 Day의 경우에는 한자리만 입력하는 경우가 종종 발생할 수 있는데, 유저의 인식 향상을 위해 placeholder를 제공하면 좋겠다.
     placeholder에 제공하는 값은 오늘 날짜로 제공하면 좋지 않을까?
     + Year의 경우에는 대부분 고정되어 있으니 처음부터 값을 줘도 좋겠다!
     Year을 기본으로 주는 만큼 만약에 현재 날짜 및 시간보다 앞의 값을 입력한다면 입력하지 정보를 정정하고 Year의 조절이 있을 경우 언더라인이 나타나게한다.
     
     Hour, Minute 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     
     세번째 줄 텍스트필드 제약조건에 대해서 고려해야 하는 점들.
     1. 입력받는 길이 제한 -> 코드로 길이 제한
     2. 입력이 끝나면 자동으로 키보드 내리기 -> 최대길이 도달하면 내리게 코드로 주기
     3. 터무니없는 값에는 현재 시간으로 초기화 -> 코드로 구현
     4. 입력이 끝나지 않았다면 다른 곳 터치시 포커스 헤제
     5.
     */
    
    // when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
        print("tx did begin editing")
    }
    
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) { // 텍스트 필드가 포커스를 사임하기 직전에 호출되는 메소드 이 코드가 존재하는 이유는 포커스를 놓을 때, 필드를 안전하게 채워주기 위함.
        
        self.activeTextField = nil // 활동하는 키보드 날려주기
        print("tx did end editing")
        
        // 텍스트 필드에서 다른 텍스트 필드 클릭 시, touchesBegan 메소드로는 사임 여부를 확인할 수가 없어서 코드로 구현하였다.
        if textField == YearTextField && YearTextField.text?.count ?? 0 < 4 { // 사임하는 텍스트 필드의 내용 길이가 조건보다 작다면, 채워주자.
            YearTextField.text = nowDateTime(0)
            Yearborder.backgroundColor = UIColor.green.cgColor
        }
        
        if textField == MonthTextField && MonthTextField.text?.count ?? 0 < 2 {
            if MonthTextField.text?.count == 1 && MonthTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                MonthTextField.text = "0\(MonthTextField.text!)"
            } else {
                MonthTextField.text = nowDateTime(1)
            }
            Monthborder.backgroundColor = UIColor.green.cgColor
        } else if textField == DayTextField && DayTextField.text?.count ?? 0 < 2 {
            if DayTextField.text?.count == 1 && DayTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                DayTextField.text = "0\(DayTextField.text!)"
            } else {
                DayTextField.text = nowDateTime(2)
            }
            self.Dayborder.backgroundColor = UIColor.green.cgColor
        } else if textField == HourTextField && HourTextField.text?.count ?? 0 < 2 {
            if HourTextField.text?.count == 1 && HourTextField.text != "0" { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                HourTextField.text = "0\(HourTextField.text!)"
            } else {
                HourTextField.text = nowDateTime(3)
            }
            self.Hourborder.backgroundColor = UIColor.green.cgColor
        } else if textField == MinuteTextField && MinuteTextField.text?.count ?? 0 < 2 {
            if MinuteTextField.text?.count == 1 { // 이 경우는 사용자가 "01" 이 아니라 "1" 이렇게만 입력했을 수도 있으므로
                MinuteTextField.text = "0\(MinuteTextField.text!)"
            } else {
                MinuteTextField.text = nowDateTime(4)
            }
            self.Minuteborder.backgroundColor = UIColor.green.cgColor
        }
        
    }
    
    // MARK:: InnerBox 첫번째 줄
    func YearTextField4(_ str : String) { // 최대길이 4까지
        
        if YearTextField.text?.count ?? 0 < 4 { // 입력 시에 호출 된다.
            self.Yearborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 4 {
            let index = str.index(str.startIndex, offsetBy: 4)
            self.YearTextField.text = String(str[..<index])
        } else if str.count == 4 {
            if Int(str)! < Int(nowDateTime(0))! { // 올해보다 이전이라면
                self.YearTextField.text = nowDateTime(0) // 올해값으로 정정
            }
            
            if !checkLeapYear() && self.MonthTextField.text == "02" && self.DayTextField.text == "29" { // 윤년이 아닌데, 2월 29일로 설정되어 있다면
                self.DayTextField.text = "28" // 28일로 변경
            }
            
            self.Yearborder.backgroundColor = UIColor.green.cgColor
            self.YearTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    
     func MonthTextField2(_ str : String) { // 최대길이 2까지
        
        if MonthTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Monthborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.MonthTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 12 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 이번달로 설정
                self.MonthTextField.text = nowDateTime(1)
            } else { // 정상적으로 입력 되었으면
                self.Monthborder.backgroundColor = UIColor.green.cgColor
            }
            
            if self.DayTextField.text != "" { // 일이 비어있다면 넘어가도록 설계
                if checklastDay() < Int(self.DayTextField.text!)! { // 일이 입력되어 있는 상태에서 월을 변경할 때, 마지막 날이 이번달에 없는 날이면 변경하기 위한 로직
                    self.DayTextField.text = "\(checklastDay())"
                }
            }
            
            self.MonthTextField.resignFirstResponder() // 키보드 내리기
        }
    }
     func DayTextField2(_ str : String) { // 최대길이 2까지
        
        if DayTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Dayborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.DayTextField.text = String(str[..<index])
        } else if str.count == 2 {
            // 고려 해야할 점 -> 윤년, 월, 년,월이 입력되지 않은 경우
            if checklastDay() < Int(self.DayTextField.text!)! { // 그 달에 없는 날짜이면
                self.DayTextField.text = "\(checklastDay())"
            }
            self.Dayborder.backgroundColor = UIColor.green.cgColor
            self.DayTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    
    
    // MARK:: InnerBox 세번째 줄
    
     func HourTextField2(_ str : String) { // 시간 최대 2자리까지
        
        if HourTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Hourborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.HourTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 12 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 시간값 현재 시간으로 초기화
                self.HourTextField.text = nowDateTime(3)
            } else { // 정상적으로 입력 되었으면
                
            }
            
            self.Hourborder.backgroundColor = UIColor.green.cgColor
            self.HourTextField.resignFirstResponder() // 키보드 내리기
        }
    }
    
     func MinuteTextField2(_ str : String) { // 시간 최대 2자리까지
        
        if MinuteTextField.text?.count ?? 0 < 2 { // 입력 시에 호출 된다.
            self.Minuteborder.backgroundColor = UIColor.red.cgColor // 입력시 빨간색으로
        }
        
        if str.count > 2 {
            let index = str.index(str.startIndex, offsetBy: 2)
            self.MinuteTextField.text = String(str[..<index])
        } else if str.count == 2 {
            
            if Int(str)! > 59 || Int(str)! < 1 { // 여기서 터무니 없는 숫자면 시간값 현재 시간으로 초기화
                self.MinuteTextField.text = nowDateTime(3)
            } else { // 정상적으로 입력 되었으면
                
            }
            
            self.Minuteborder.backgroundColor = UIColor.green.cgColor
            self.MinuteTextField.resignFirstResponder() // 키보드 내리기
        }
    }
 
}
