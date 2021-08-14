//
//  CreateMemberViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit

class CreateFamilyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? CreateProfileViewController else { return }
        vc.modalPresentationStyle = .fullScreen
    }
}
