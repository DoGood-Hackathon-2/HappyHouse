//
//  CustomExtension.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/08.
//

import UIKit
import SnapKit

extension UIButton {
    
    /// HAUS 앱에서 이용되는 버튼의 기본 높이
    var defaultHeight: Int {
        return 56
    }
    
    /// UIButton 의 모서리만 둥글게 만든다.
    func setCornerRadius() {
        self.layer.cornerRadius = CGFloat(defaultHeight / 2)
    }
}

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
