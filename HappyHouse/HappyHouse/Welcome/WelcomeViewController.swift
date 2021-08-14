//
//  WelcomeViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedView(_ sender: Any) {
        let svc = storyboard?.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
        svc.modalPresentationStyle = .fullScreen
        svc.modalTransitionStyle = .crossDissolve
        present(svc,animated: true)
    }
}
