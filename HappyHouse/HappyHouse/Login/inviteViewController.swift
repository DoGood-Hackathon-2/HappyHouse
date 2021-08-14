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
    
    @IBOutlet weak var inviteCode: UITextField!
    let bag = DisposeBag()
    
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeInviteCode()
        onClick()

    }
    @IBAction func touchUpCreateFamily(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "CreateFamily", bundle: nil)
        let navigationViewController = storyboard.instantiateViewController(identifier: "NavigationViewController")
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }
}

extension inviteViewController {
    
    func subscribeInviteCode() {
        inviteCode.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.inviteCode.text! }
            .subscribe(onNext: { [weak self] text in
                print(text)
                self?.presentWelcome()
            })
            .disposed(by: bag)
    }
    
    func onClick() {
        createButton.rx.tap
            .bind {
                print("Clicked")
            }.disposed(by: bag)
    }
    
    func presentWelcome() {
        let svc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        svc.modalPresentationStyle = .fullScreen
        self.present(svc,animated: true)
    }
}
