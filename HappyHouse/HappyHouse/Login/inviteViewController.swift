//
//  inviteViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// 초대 확인 페이지
class inviteViewController : UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        onClick()
    }
}

extension inviteViewController {
    func onClick() {
        createButton.rx.tap
            .bind {
                print("Clicked")
            }.disposed(by: bag)
    }
}
