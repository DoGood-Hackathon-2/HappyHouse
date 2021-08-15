//
//  JoinViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func join(_ sender: Any) {
                
        // go to main (routine page)
        let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
