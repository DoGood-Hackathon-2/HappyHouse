//
//  CRStringSplit.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/23.
//

import Foundation

extension CommonRoutineViewController {
    
    func dateSplit(_ index : Int) -> String {
        let arr = date.components(separatedBy: ".") // 2021.01.01
        
        return arr[index]
    }
    
    func iteratorSplit() -> Array<String>  {
        let arr = iterator.components(separatedBy: " ") // 매주 월 수 금
        
        return arr
    }
    
    func timeSplit() -> Array<String> {
        var arr = time.components(separatedBy: " ") // 오후 3시 00분
        arr[1] = String(arr[1].dropLast()) // 00 "시" 삭제
        arr[2] = String(arr[2].dropLast())// 00 "분" 삭제
        return arr
    }
}
