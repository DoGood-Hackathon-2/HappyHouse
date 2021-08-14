//
//  LoadingViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

// 로딩 페이지
class loadingViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    @IBAction func StartButton(_ sender: Any) {
        let svc = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as! loginViewController
        
        svc.modalPresentationStyle = .fullScreen
        
        self.present(svc,animated: true)
    }
}

