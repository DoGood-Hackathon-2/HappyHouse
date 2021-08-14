//
//  NewRoutineViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/15.
//

import UIKit
import RxSwift
import RxCocoa

class NewRoutineViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = NewRoutineViewModel()
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.members
            .bind(to: collectionView.rx
                    .items(cellIdentifier: "RoutineMemberCell", cellType: RoutineMemberCell.self))
            { index, member, cell in
                cell.initUI(of: member)
                print(index, member, cell)
            }
            .disposed(by: bag)
    }
}

class RoutineMemberCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func initUI(of member: Member) {
        imageView.image = UIImage(named: member.image ?? "daughter_profile")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        nameLabel.text = member.nickname
    }
}
