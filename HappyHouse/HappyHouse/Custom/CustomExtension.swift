//
//  CustomExtension.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/08.
//

import UIKit
import SnapKit

typealias EmptyClosure = (() -> ())

extension UIView {
    
    /// SnapKit 에서 쓰기 위한 Safe Area 속성
    var safeArea : ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
    
    func addSubViews(_ subViews: [UIView]) {
        subViews.forEach { subView in
            addSubview(subView)
        }
    }
    
    func setWhiteBackground() {
        backgroundColor = .white
    }
}

extension UIButton {
    
    /// HAUS 앱에서 이용되는 버튼의 기본 높이
    var defaultHeight: Int {
        return 56
    }
    
    /// HAUS 앱에서 이용되는 버튼의 기본 마진
    var defaultMargin: Int {
        return 17
    }
    
    ///  HAUS 앱에서 이용되는 버튼의 기본 모양으로 설정한다.
    func setDefaultStyle() {
        layer.cornerRadius = CGFloat(defaultHeight / 2)
        backgroundColor = UIColor(named: "ButtonColor")
    }
}

extension UITextField {
    
    /// HAUS 앱에서 이용되는 Text Field 의 기본 높이
    var defaultHeight: Int {
        return 58
    }
    
    /// HAUS 앱에서 이용되는  Text Field 의 기본 마진
    var defaultMargin: Int {
        return 23
    }
    
    // HAUS 앱에서 이용되는 텍스트필드의 기본 모양으로 설정한다.
    func setDefaultStyle() {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(defaultHeight / 2)
        backgroundColor = UIColor(named: "TextFieldColor")
        textAlignment = .center
        textColor = .white
    }
}
