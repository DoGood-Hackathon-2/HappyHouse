//
//  HomeViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roomTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleUI()
    }
    
}

extension HomeViewController {
    func titleUI() {
        roomTitle.text = "서버에서 정보를 받아오자" //서버에서 룸 정보 받아오기;
        roomTitle.backgroundColor = #colorLiteral(red: 1, green: 0.9017189145, blue: 0.9212634563, alpha: 1)
        roomTitle.layer.cornerRadius = 12
        roomTitle.clipsToBounds = true
        roomTitle.font = UIFont(name: roomTitle.font.fontName, size: 11)
    }
    
    
}
