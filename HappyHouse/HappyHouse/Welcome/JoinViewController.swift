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
        
        print("Tt")
        
        // go to main (routine page)
        let svc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewTabBar")
        svc!.modalPresentationStyle = .fullScreen
        self.present(svc!,animated: true)
    }
    
}
