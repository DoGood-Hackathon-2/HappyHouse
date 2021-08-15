//
//  Tutorial1.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/15.
//

import Foundation
import UIKit

class Tutorial3 : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tap3(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "CameraViewController") as? CameraViewController else { return }
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
}
