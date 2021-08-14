//
//  CreateMemberViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift
import RxAlamofire

class CreateFamilyViewController: UIViewController {

    @IBOutlet weak var familyName: UITextField!
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        familyName.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.familyName.text! }
            .subscribe(onNext: { [weak self] text in
                User.familyName = text
                self?.presentMyProfile()
            })
            .disposed(by: bag)
    }
    
    func presentMyProfile() {
        guard let vc = storyboard?.instantiateViewController(identifier: "MyProfileViewController") as? MyProfileViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func touchUpFinish(_ sender: Any) {
        presentMyProfile()
    }
}
