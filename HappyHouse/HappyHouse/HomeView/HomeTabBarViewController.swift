//
//  HomeTabBarViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    var isHome = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isHome {
            self.selectedIndex = 0
        } else {
            self.selectedIndex = 1
        }
    }
}
