//
//  CommunityViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class CommunityViewController : UIViewController {
    
    @IBOutlet weak var CBackgroundView: UIImageView! // 백그라운드
    @IBOutlet weak var headTitle: UILabel! // 커뮤니티 글자
    @IBOutlet weak var CommunityCollectionView: UICollectionView!
    
    let viewModel = CommunityViewModel()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        CommunityCollectionView.delegate = self
        setData()
    }
}

extension CommunityViewController {
    func layout() {
        CBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35) // 15는 safeArea값으로 해야하는데 정확히 몇인지 기억이 안나서 찾아봐야함
            $0.left.right.bottom.equalTo(0)
        }
        headTitle.snp.makeConstraints {
            $0.top.equalTo(CBackgroundView.snp.top).offset(7)
            $0.centerX.equalToSuperview()
        }
        CommunityCollectionView.snp.makeConstraints {
            $0.top.equalTo(headTitle.snp.bottom).offset(95)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setUI() {
        CommunityCollectionView.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        }
    }
    
    func setData() {
        viewModel.dummyObsrvable
            .bind(to: CommunityCollectionView.rx.items(
                    cellIdentifier: "CommunityCell", cellType: CommunityCell.self)
            ){ index, item, cell in
                cell.initUI(of: item)
            }
    }
}

extension CommunityViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        //let textAreaHeight : CGFloat = 65
        
        let width : CGFloat = (collectionView.bounds.width - 20 - itemSpacing ) / 2
        let height : CGFloat = width * 10/7 // + textAreaHeight
        
        return CGSize(width: width, height: height)
        }
    
    // case A
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // case B
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

struct CommunityModel {
    var CProfileImage : String // 프로필 이미지
    var CProfileName : String // 프로필 이름
    var CImageButton : String // 이미지 클릭 처리하기 위해 버튼
}

class CommunityCell : UICollectionViewCell {
    @IBOutlet weak var ProfileImage: UIImageView! // 프로필 이미지
    @IBOutlet weak var ProfileName: UILabel! // 프로필 이름
    @IBOutlet weak var CommunityImageButton: UIButton! // 이미지 버튼
    
    func initUI(of item : CommunityModel) {
        cellLayout()
        ProfileImage.then {
            $0.image = UIImage(named: item.CProfileImage)
            //$0.backgroundColor = .blue
            $0.layer.cornerRadius = 25
        }
        ProfileName.then {
            $0.text = item.CProfileName
            $0.backgroundColor = .red
        }
        CommunityImageButton.then {
            $0.setImage(UIImage(systemName: "ticket"), for: .normal)
            $0.backgroundColor = .brown
        }
    }
    
    func cellLayout() {
        ProfileImage.snp.makeConstraints {
            $0.top.left.equalTo(10)
            $0.width.height.equalTo(50)
        }
        ProfileName.snp.makeConstraints {
            //$0.centerY.equalTo(ProfileImage.snp.top)
            $0.top.equalTo(ProfileImage.snp.top).offset(25)
            $0.left.equalTo(ProfileImage.snp.right).offset(3)
            $0.right.equalToSuperview()

        }
        CommunityImageButton.snp.makeConstraints {
            $0.top.equalTo(ProfileImage.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
    }
}

class CommunityViewModel {
    var dummyData = [
        CommunityModel(CProfileImage: "image 1", CProfileName: "공주", CImageButton: "image 1"),
        CommunityModel(CProfileImage: "image 1", CProfileName: "공주", CImageButton: "image 1"),
        CommunityModel(CProfileImage: "image 1", CProfileName: "공주", CImageButton: "image 1"),
        CommunityModel(CProfileImage: "image 1", CProfileName: "공주", CImageButton: "image 1")
    ]
    var dummyObsrvable: Observable<[CommunityModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보

    init() {
        dummyObsrvable = Observable.of(dummyData)
    }
}
