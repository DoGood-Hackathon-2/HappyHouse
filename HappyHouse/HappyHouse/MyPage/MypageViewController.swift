//
//  MypageViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/15.
//

import UIKit
import RxSwift
import RxCocoa

class MypageViewController : UIViewController {
    
    @IBOutlet weak var myPageTitle: UILabel!
    @IBOutlet weak var myProfile: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var instanceButton: UIButton!
    @IBOutlet weak var repeatUnderline: UIImageView!
    @IBOutlet weak var instanceUnderline: UIImageView!
    
    let viewModel = RecommendViewModel() // MVVM이지 이게 재사용이 가능하네 ^__^ 캬~ 이맛이지
    var bag = DisposeBag()
    var TableViewModel = MypageTableViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        collectionRx() // rx의 컬렉션 처리들 등록
        onClick() // 반복 - 일회성
        TableViewModel.APICALL("mypage", 6)
    }
}

extension MypageViewController {
    
    func initUI() {
        myProfile.layer.cornerRadius = 50
        myProfile.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 12
    }
    
    func collectionRx() {
        viewModel.mypagesObsrvable
            .bind(to: collectionView.rx
                    .items(
                        cellIdentifier: "MyPageCell",
                        cellType: HomeViewCell.self)
            ) { index, recommend, cell in
                cell.initUI(of: recommend)
                print(index, recommend, cell)
            }.disposed(by: bag)
        
        collectionView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                // 추가하는 곳으로 화면 전환
                // 로직은 ViewModel쪽에 데이터 넣기
            }).disposed(by: bag)
    }
    
    func onClick() {
        repeatButton.rx.tap
            .bind{
                self.repeatButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                self.instanceButton.setTitleColor(#colorLiteral(red: 0.8116930127, green: 0.8118106723, blue: 0.8116673231, alpha: 1), for: .normal)
                self.repeatUnderline.image = UIImage(named: "Line 12")
                self.instanceUnderline.image = UIImage(named: "Line 11")
            }.disposed(by: bag)
          
        instanceButton.rx.tap
            .bind{
                self.instanceButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                self.repeatButton.setTitleColor(#colorLiteral(red: 0.8116930127, green: 0.8118106723, blue: 0.8116673231, alpha: 1), for: .normal)
                self.instanceUnderline.image = UIImage(named: "Line 12")
                self.repeatUnderline.image = UIImage(named: "Line 11")
            }.disposed(by: bag)
    }
    
    
}

extension MypageViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 3
        
        let height : CGFloat = (collectionView.bounds.height)
        let width : CGFloat = height + itemSpacing
        
        return CGSize(width: width, height: height)
    }
}

