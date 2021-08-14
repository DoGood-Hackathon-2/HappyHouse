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
    }
}

class HomeViewController : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roomTitle: UILabel!
    
    let viewModel = RecommendViewModel()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleUI()
        
        viewModel.recommendsObsrvable
            .bind(to: collectionView.rx
                    .items(
                        cellIdentifier: "HomeViewCell",
                        cellType: HomeViewCell.self)
            ) { index, recommend, cell in
                cell.initUI(of: recommend)
                print(index, recommend, cell)
            }.disposed(by: bag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath.item)
                self?.presentCreateRoutine()
            })
            .disposed(by: bag)
        
//        maincollectionView.rx
//                    .modelSelected(BotMenu.self)
//                    .subscribe({ (item) in
//                        print(item.element?.path ?? "")
//                        let pushVC = PushViewController()
//                        self.present(pushVC, animated: true, completion: nil)
//                    }).disposed(by: disposeBag)
//            }
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
    
    func presentCreateRoutine() {
        let storyboard = UIStoryboard.init(name: "CreateRoutine", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "NewRoutineViewController") as? NewRoutineViewController else { return }
        //vc.navigationController?.pushViewController(vc, animated: true)
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
