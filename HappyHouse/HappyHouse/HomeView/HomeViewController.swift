//
//  HomeViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func initUI(of recommend: Recommend) {
        imageView.image = UIImage(named: recommend.image)
//        imageView.layer.cornerRadius = imageView.frame.width / 2
//        imageView.layer.masksToBounds = true
    }
}

class HomeViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roomTitle: UILabel!
    
    let viewModel = RecommendViewModel()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.recommendsObsrvable
            .bind(to: collectionView.rx
                    .items(
                        cellIdentifier: "HomeViewCell",
                        cellType: HomeViewCell.self)
            ) { index, recommend, cell in
                cell.initUI(of: recommend)
            }.disposed(by: bag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath.item)
                self?.presentCreateRoutine()
            })
            .disposed(by: bag)
    }
    
    @IBAction func exitHome(sender : UIStoryboardSegue){
    }
    
}

extension HomeViewController {
    
    func presentCreateRoutine() {
        let storyboard = UIStoryboard.init(name: "CreateRoutine", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "NewRoutineViewController") as? NewRoutineViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemSpacing : CGFloat = 3
        
            let width : CGFloat = (collectionView.bounds.width - itemSpacing) / 2
            let height : CGFloat = width * 0.8
            
            return CGSize(width: width, height: height)
        }
    
}
