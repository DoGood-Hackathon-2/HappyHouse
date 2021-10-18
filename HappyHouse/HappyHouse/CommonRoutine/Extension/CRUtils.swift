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
    func alert(_ message : String, completion : (()->Void)? = nil) {
             // 메인 스레드에서 실행하도록 변경
             DispatchQueue.main.async {
                 let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                     completion?() // completion 매개변수의 값이 nil이 아닐 때에만 실행되도록
                 }
                 alert.addAction(okAction)
                 self.present(alert, animated: false, completion: nil)
             }
         }
    
        func okOption() {
            // 조건이 모두 만족되었을 때, 페이지 전환
            let vc = storyboard?.instantiateViewController(identifier: "RoutineVerifyViewController") as! RoutineVerifyViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    
}
