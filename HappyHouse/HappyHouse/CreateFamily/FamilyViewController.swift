//
//  AddMemberViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class FamilyViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var completeButton: UIButton!
    let viewModel = FamilyViewModel()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Data binding
        viewModel.members
            .map { $0.count <= 2 }
            .bind(to: completeButton.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.members
            .bind(to: collectionView.rx
                    .items(cellIdentifier: "MemberCell", cellType: MemberCell.self))
            { index, member, cell in
                cell.initUI(of: member)
                print(index, member, cell)
            }
            .disposed(by: bag)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

class MemberCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func initUI(of member: Member) {
        if member.id == 0 {
            imageView.image = UIImage(named: "member_placeholder")
        } else {
            imageView.image = UIImage(named: member.image ?? "daughter_profile")
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
        nameLabel.text = member.nickname
    }
}



