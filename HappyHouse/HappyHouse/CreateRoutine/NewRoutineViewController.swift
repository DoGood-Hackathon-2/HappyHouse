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
    @IBOutlet weak var monday: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var am: UIButton!
    @IBOutlet weak var pm: UIButton!
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.of(Member.members)
            .asObservable()
            .bind(to: collectionView.rx
                    .items(cellIdentifier: "RoutineMemberCell", cellType: RoutineMemberCell.self))
            { index, member, cell in
                cell.initUI(of: member)
                print(index, member, cell)
            }
            .disposed(by: bag)
    }
    @IBAction func dayClicked(_ sender: UIButton) {

    }
    @IBAction func deactiveTime(_ sender: UIButton) {
        sender.isSelected.toggle()
        timeField.isEnabled = !sender.isSelected
        am.isEnabled = !sender.isSelected
        pm.isEnabled = !sender.isSelected
    }
}

class RoutineMemberCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func initUI(of member: Member) {
        imageView.image = UIImage(named: member.image!)// ?? "daughter_profile")
        //imageView.layer.cornerRadius = imageView.frame.width / 2
        nameLabel.text = member.nickname
    }
}
