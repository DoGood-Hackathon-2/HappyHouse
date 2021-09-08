//
//  loginViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// 로그인 페이지 - not used 
class loginViewController : UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func startKakaoButton(_ sender: Any) {
        let svc = self.storyboard?.instantiateViewController(withIdentifier: "inviteView") as! inviteViewController
        
        svc.modalPresentationStyle = .fullScreen
        
        self.present(svc,animated: true)
    }
}

