//
//  AddRoutineFinishViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import UIKit

class AddRoutineFinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func showMypage(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MypageViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showHome(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewTabBar")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
