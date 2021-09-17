//
//  CustomExtension.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/09/08.
//

import UIKit
import SnapKit

typealias EmptyClosure = (() -> ())

extension UIViewController {
    
    /// Modality 방식에서 전체 화면으로 보여준다.
    func presentFullScreen(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        viewControllerToPresent.modalTransitionStyle = .crossDissolve
        present(viewControllerToPresent, animated: true, completion: nil)
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
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    /// HAUS 앱에서 이용되는 텍스트필드의 기본 모양으로 설정한다.
    func setDefaultStyle() {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(defaultHeight / 2)
        backgroundColor = UIColor(named: "PlaceholderColor")
        textAlignment = .center
        textColor = .white
    }
}

extension UIImageView {

    /// HAUS 앱에서 이용되는 프로필 사진의 기본 너비와 높이
    var defaultProfileSize: Int {
        return 180
    }
    
    /// HAUS 앱에서 이용되는 프로필 사진의 너비를 통해 원형으로 만든다.
    func makeCircleView() {
        layer.cornerRadius = CGFloat(defaultProfileSize / 2)
    }
}


extension NSMutableAttributedString {

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
