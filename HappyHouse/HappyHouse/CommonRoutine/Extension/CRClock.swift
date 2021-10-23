//
//  CRTime.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/18.
//

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
    
    func realDateTime() -> String {
        let today = NSDate() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-a" // 2021-09-06-17-12
        //        dateFormatter.locale = Locale(identifier:"ko_KR") // 위치는 한국
        let dateString = dateFormatter.string(from: today as Date)
        //print(dateString)
        return dateString
    }
    
    func nowDateTime(_ index : Int) -> String {
        /*
         사용자는 미래의 일정을 예약함으로 현재 시간을 주면 사용자가 입력하는 동안에 시간이 흘러, 재입력해야 하는 불편함이 발생한다.
         이를 조정하고자 30분 후의 시간을 nowDateTime으로 지정하겠다.
         
         index 0 - year
         index 1 - month
         index 2 - day
         index 3 - hour : 24시간제
         index 4 - minute
         index 5 - AM,PM
         */
        
        let dateString = realDateTime()
        var arr = dateString.components(separatedBy: "-") // 분리해서 내보내주기
        
        arr[4] = "\(Int(arr[4])! + 30)" // 30분 더하기
        
        if self.MonthTextField.text?.count ?? 0 < 2 {
            self.MonthTextField.text = arr[1] // 실제로 반환되지는 않지만, 내부 로직에서 checklastDay와 nowDateTime이 서로서로 참조하고 있어서 자칫 잘못하면 무한루프가 발생함. 무한 루프가 발생함. 이 코드가 존재하면 두 개의 로직을 확인해 보았을 때, 무한루프에 빠지지 않게 되어서 설계상으로 필요한 코드이다.
        }
        
        // MARK:: 30을 더했을 때의 알고리즘 로직
        if Int(arr[4])! >= 60 { // 60분을 넘어가면
            arr[4] = "\(Int(arr[4])! - 60)" //  분에서 60을 뺴준다.
            arr[3] = "\(Int(arr[3])! + 1)"
            
            if arr[3].count == 1 { // 한자리 수이면
                arr[3] = "0\(arr[3])"
            }
            
            if Int(arr[3])! > 23 { // 24부터는 넘어가면 하루를 더해야한다.
                arr[3] = "01" // 시간이 다음 날로 바뀌니까 01로 바꿔준다.
                arr[5] = "AM" // 다음날로 넘어갔다면 AM으로 변경
                if checklastDay() == Int(arr[2]) { // 해당 달의 마지막 날이라면
                    arr[2] = "01" // 1일로 초기화하고
                    arr[1] = "\(Int(arr[1])! + 1)" // 월을 1 올린다.
                    
                    if Int(arr[1])! > 12 { // 12월을 넘어가면
                        arr[1] = "01" // 1월로 초기화하고
                        arr[0] = "\(Int(arr[0])! + 1)" // 년도를 1을 더한다
                    }
                } else { // 해당날이 마지막 날이 아니라면 현재 날짜에 1을 더한다.
                    arr[2] = "\(Int(arr[2])! + 1)" // day에 1을 더한다.
                }
            }
        }
        
        // MARK:: 30분을 더한 후에 문자열 문자열 길이를 완전하게 해주는 로직
        if Int(arr[3])! > 12 { // 24시간제로 받아서 12시간 값을 변환해주는 과정이 필요하다.
            arr[3] = "\(Int(arr[3])! - 12)"
            if arr[3].count == 1 { // 한자리 수이면
                arr[3] = "0\(arr[3])"
            }
        }
        
        if arr[4].count == 1 { // 한자리 수이면
            arr[4] = "0\(arr[4])"
        }
        
        return arr[index]
    }
    
    func checkLeapYear() -> Bool{ // 윤년인지 아닌지 체크하는 함수
        
        guard let year = Int(self.YearTextField.text!) else {
            self.YearTextField.text = nowDateTime(0)
            return false
        }
        
        if( (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) {
            return true // 윤년
        } else {
            return false // 윤년 아님
        }
    }
    
    func checklastDay() -> Int { // 이번달이 몇일까지 있는지 체크하는 함수
        guard let month = Int(self.MonthTextField.text!) else { // 월이 비워져 있으면
            // 여기서 팁! month가 비었지만, else에서 month가 채워져서 guard문으로 끝나지 않고, switch쪽으로 넘어간다.
            self.MonthTextField.text = nowDateTime(1) // 월을 채워주고
            self.Monthborder.backgroundColor = UIColor.green.cgColor
            return 1
        }
        switch month {
        case 1,3,5,7,8,10,12: // 31일까지 있는 달
            return 31
        case 4,6,9,11 : // 30일까지 있는 달
            return 30
        case 2 : // 윤년인지 아닌지 판단해서 리턴해줌
            if checkLeapYear() { return 29 } else { return 28 } // 함수는 3항연산자로 못바꿀까?
        default:
            return -1 // 에러나면 -1 리턴해줌
        }
    }
    
}
