//
//  NMyPageViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/08/26.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class NMyPageViewController : UIViewController {
    
    @IBOutlet weak var NBackgroundImage: UIImageView!
    @IBOutlet weak var NMypageTitle: UILabel! // 가족 이름
    @IBOutlet weak var NProfileName: UILabel! // 프로필 이름
    @IBOutlet weak var NEditButton: UIButton! // 수정하기 버튼
    @IBOutlet weak var HELLOLabel: UILabel! // 헬로글자
    @IBOutlet weak var NEditUnderBar: UIImageView! // 수정하기 아래에 언더바
    @IBOutlet weak var NMyfamilyCollectionView: UICollectionView! // 패밀리 정보
    
    let viewModel = NMyPageViewModel() // MVVM 사용위한 뷰모델 선언
    let bag = DisposeBag()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setUI()
        NMyfamilyCollectionView.delegate = self
        setData()
        event()
        
    }
}

extension NMyPageViewController {
    func layout() {
        NBackgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35) // 15는 safeArea값으로 해야하는데 정확히 몇인지 기억이 안나서 찾아봐야함
            $0.left.right.bottom.equalTo(0)
        }
        HELLOLabel.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.left.equalTo(30)
        }
        NProfileName.snp.makeConstraints {
            $0.top.equalTo(HELLOLabel.snp.bottom).offset(12)
            $0.left.equalTo(HELLOLabel.snp.left)
        }
        NEditButton.snp.makeConstraints {
            $0.top.equalTo(NProfileName.snp.top)
            $0.right.equalToSuperview().offset(-12)
            $0.width.equalTo(50)
        }
        NEditUnderBar.snp.makeConstraints {
            $0.top.equalTo(NEditButton.snp.bottom).offset(-5)
            $0.right.equalTo(NEditButton.snp.right)
            $0.width.equalTo(NEditButton.frame.width)
        }
        NMyfamilyCollectionView.snp.makeConstraints {
            $0.top.equalTo(NEditButton.snp.bottom).offset(5)
            $0.right.equalToSuperview().offset(0)
            $0.left.equalTo(NProfileName.snp.left)
            $0.height.equalTo(80)
        }
    }
    
    func setUI() {
        NMypageTitle.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9017189145, blue: 0.9212634563, alpha: 1)
            $0.clipsToBounds = true // 이거 있어야 Label의 cornerRadius 적용된다.
            $0.layer.cornerRadius = 11
            $0.text = "  러블리하우스  " // 앞뒤로 띄어쓰기 2칸 있어야 글자가 잘 보인다.
            $0.font = UIFont(name: "Pretendard-Bold", size: 13)
        }
        NProfileName.then {
            $0.text = "마마"
        }
        
        NMyfamilyCollectionView.then {
            $0.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        }
    }
    
    func setData() {
        viewModel.dummyObsrvable
            .bind(to: NMyfamilyCollectionView.rx.items(
                    cellIdentifier: "FamilyCell",
                    cellType: MyPageCollectionCell.self)
            ) { index, item, cell in
                let lastindex = self.NMyfamilyCollectionView.lastIndexpath().row // 마지막 인덱스 찾기 (물론 섹션도 찾을 수 있지롱~)
                if index == lastindex {
                    cell.lastinitUI(of: item)
                    cell.NMyPageCellButton.setImage(UIImage(named: "add_mypage"), for: .normal)
                    //cell.NMyPageCellButton.isEnabled = true
                } else {
                    cell.initUI(of: item)
                    cell.NMyPageCellButton.setImage(UIImage(named: item.ButtonImage), for: .normal)
                    //cell.NMyPageCellButton.isEnabled = false
                }
                
            }.disposed(by: bag)
    }
    
    func event() {
        
    }
    
    
}

extension NMyPageViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
}

class MyPageCollectionCell : UICollectionViewCell {
    @IBOutlet weak var NMyPageCellButton: UIButton!
    
    func initUI(of item : MyPageCellModel) {
        NMyPageCellButton.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().offset(0)
        }
        NMyPageCellButton.layer.cornerRadius = 40
        NMyPageCellButton.layer.masksToBounds = true
        NMyPageCellButton.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        //NMyPageCellButton.isHighlighted = nil
    }
    
    func lastinitUI(of item : MyPageCellModel) {
        NMyPageCellButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
            $0.bottom.right.equalToSuperview().offset(-10)
        }
        NMyPageCellButton.layer.cornerRadius = 30
        NMyPageCellButton.layer.masksToBounds = true
        NMyPageCellButton.backgroundColor = .gray
        
        NMyPageCellButton.rx.tap
            // dispose하면 작동 안함.
            .bind{
                print("tap")
            }
    }
    
    
}

struct MyPageCellModel {
    var ButtonImage : String // 이미지가 들어가지만 클릭해서 이벤트 처리를 해야해서 걍 버튼으로 만들면 더 좋을거 같아서 이렇게 설계하기로
}

class NMyPageViewModel {
    
    var dummyData = [
        // 나중에 API로 데이터 받아와서 그 배열에 마지막에 add_mypage 넣어주기 또한 더하기 버튼의 경우는 Index컨트롤해서 크기 더 작게 만들기
        MyPageCellModel(ButtonImage: "add_mypage"),
        MyPageCellModel(ButtonImage: "image 1"),
        MyPageCellModel(ButtonImage: "image 2"),
        MyPageCellModel(ButtonImage: "image 3"),
        MyPageCellModel(ButtonImage: "image 1"),
    ]
    
    var dummyObsrvable: Observable<[MyPageCellModel]> // NHomeViewController의 컬렉션 뷰에 들어갈 정보
    
    init() {
        dummyObsrvable = Observable.of(dummyData)
    }
}

extension UICollectionView {
    // 마지막 인덱스 찾는 함수 구현하여 collectionView쪽에 넣어둠 Util로 나중에 빼기
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfItems(inSection: section) - 1, 0)

        return IndexPath(row: row, section: section)
    }
}
