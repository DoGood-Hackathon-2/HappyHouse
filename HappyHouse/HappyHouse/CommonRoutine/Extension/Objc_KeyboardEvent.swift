//
//  Objc_KeyboardEvent.swift
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
    
    @objc private func adjustTextFieldConstraintsToKeyboard(notification : Notification){
        
        print("txtview in")
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            print("keyboardSize gurad out")
            
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextView = activeTextView {
            
            let bottomOfTextView = activeTextView.convert(activeTextView.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextView > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if (shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        print("txtfield in")
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            print("keyboardSize gurad out")
            
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            //print("keyboardWillShow : activeTextField \(activeTextField)")
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            //print("keyboardWillShow : bottomOfTextField \(bottomOfTextField)")
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            //print("keyboardWillShow : topOfKeyboard \(topOfKeyboard)")
            
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
                
                //print("keyboardWillShow : bottomOfTextField > topOfKeyboard true")
            }
            //print("keyboardWillShow : bottomOfTextField > topOfKeyboard false")
            print("textfield on")
        }
        
        // if active text field is not nil
        print("active txt view : \(activeTextView)")
        if let activeTextView = activeTextView {
            
            let bottomOfTextView = activeTextView.convert(activeTextView.bounds, to: self.view).maxY;
            print("bottomOfTextView : \(bottomOfTextView)")
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            print("topOfKeyboard : \(topOfKeyboard)")
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextView > topOfKeyboard {
                shouldMoveViewUp = true
            }
            
            print("txtview on")
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
            
            //print("keyboardWillShow : viewframeoring \(self.view.frame.origin.y = 0 - keyboardSize.height)")
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
        print("out")
      self.view.frame.origin.y = 0
    }
    
}

