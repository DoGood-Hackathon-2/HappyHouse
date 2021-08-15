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
        sender.isSelected.toggle()
    }
    
    @IBAction func deactiveTime(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            timeField.isEnabled = false
            am.isEnabled = false
            pm.isEnabled = false
        } else {
            timeField.isEnabled = true
            am.isEnabled = true
            pm.isEnabled = true
        }
    }
    
    @IBAction func addRoutine(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddRoutineFinishViewController") as! AddRoutineFinishViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
}

class RoutineMemberCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func initUI(of member: Member) {
        imageView.image = UIImage(named: member.image!)
        nameLabel.text = member.nickname
    }
}
