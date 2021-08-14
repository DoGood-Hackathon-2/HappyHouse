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
        addBackgroundView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func addBackgroundView() {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 414, height: 837)
        view.backgroundColor = .white

        view.layer.backgroundColor = UIColor(red: 0.953, green: 0.42, blue: 0.498, alpha: 0.08).cgColor
        view.layer.cornerRadius = 43

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 414).isActive = true
        view.heightAnchor.constraint(equalToConstant: 837).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 242).isActive = true
    }
}
