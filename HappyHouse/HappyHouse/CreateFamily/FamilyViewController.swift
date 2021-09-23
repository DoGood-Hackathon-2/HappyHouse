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

    // MARK: - Properties
    private var familyName = ""
    private var bag = DisposeBag()
    private let viewModel = FamilyViewModel()
            
    private let welcomeTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 48, weight: .black) // Pretendard-ExtraBold
        $0.text = "welcome"
        $0.textColor = UIColor(named: "TitleColor")
    }

    private let familyNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Pretendard-Bold
        $0.text = "가족이름"
    }
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "Rectangle 697") // 이미지 에셋 의미있는 이름으로 변경하기
        $0.contentMode = .top
    }
    
    private let doneButton = UIButton().then {
        $0.setTitle("가족만들기 완료", for: .normal)
        $0.isHidden = true
        $0.setDefaultStyle()
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 158, height: 200) // 기본
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
        $0.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.identifier)
    }
    
    func configure(familyName: String) {
        self.familyName = familyName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        setUpView()
        setConstraints()
        setBinding()
    }
}

extension FamilyViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        let cellSquareSize: CGFloat = (collectionViewWidth / 2.0) - 10
        
        return CGSize.init(width: cellSquareSize, height: cellSquareSize*1.3)
    }
}

extension FamilyViewController {
    
    // MARK: - Setting View
    private func setUpView() {
        view.setWhiteBackground()
        view.addSubViews([welcomeTitle, familyNameLabel, backgroundImage, collectionView, doneButton])
        familyNameLabel.text = familyName
    }
    
    private func setConstraints() {
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(60)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        familyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(familyNameLabel.snp.bottom).offset(18)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(familyNameLabel.snp.top).offset(131)
            make.bottom.equalTo(doneButton).offset(-30)
        }
        
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(doneButton.defaultHeight)
            //make.top.lessThanOrEqualTo(profileImageButton.snp.bottom).offset(147)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.leading.equalToSuperview().offset(doneButton.defaultMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Data binding
    private func setBinding() {
        viewModel.members
            .map { $0.count <= 2 }
            .bind(to: doneButton.rx.isHidden)
            .disposed(by: bag)
        
        viewModel.members
            .bind(to: collectionView.rx
                    .items(cellIdentifier: MemberCell.identifier, cellType: MemberCell.self))
            { index, member, cell in
                cell.initUI(of: member)
            }
            .disposed(by: bag)
        
        // Last item clicked -> Create new member profile
        collectionView.rx.modelSelected(Member.self)
            .filter { $0 == Member.EMPTY }
            .bind { [unowned self] _ in
                let newMemberProfileViewController = MemberProfileViewController()
                newMemberProfileViewController.configure(familyName: self.familyName)
                self.presentFullScreen(newMemberProfileViewController)
            }
            
    }
}

class MemberCell: UICollectionViewCell {

    static let identifier = "MemberCell"
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
    }
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // storybaord 를 이용하지 않는 경우의 초기화함수
        //print("init frame")
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initUI(of member: Member) {
        if member.id == 0 {
            imageView.image = UIImage(named: "member_placeholder")
        } else {
            imageView.image = UIImage(named: member.image ?? "daughter_profile")
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
        nameLabel.text = member.nickname
    }
    
    func setUpView() {
        contentView.backgroundColor = .clear
        contentView.addSubViews([nameLabel, imageView])
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}



