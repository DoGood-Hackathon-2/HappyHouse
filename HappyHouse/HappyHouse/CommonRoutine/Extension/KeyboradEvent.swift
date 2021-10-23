//
//  ExCommonRoutineViewController.swift
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

// MARK::: textView 및 textField 이벤트 처리 받기 위해
extension CommonRoutineViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("didbegin txtview")
        self.activeTextView = textView
        print("func activeTextView : \(activeTextView)")
        animateViewMoving(true, self.RequestTextView.frame.height)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("didend txtview")
        self.activeTextView = nil
        print("func activeTextView : \(activeTextView)")
        animateViewMoving(false, 0)
    }
    
    func animateViewMoving (_ up:Bool, _ moveValue :CGFloat){
        
        let movementDuration : TimeInterval = 0.3
        let movement : CGFloat = ( up ? -(moveValue) : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
}
