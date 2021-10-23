//
//  NMyPageRoutionCell.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

struct RoutineModel {
    var RoutineType : String // 일회성인지 반복인지 타입을 지정
    var RprofileImage : String // 루틴 이미지
    var Rtitle : String // 루틴 타이틀
    var Rdescription : String // 상세내용
    var Rdate : String // 루틴 날짜
    var Riterator : String // 루틴 반복
    var Rtime : String // 루틴 시간
    var RChallengeState : String // 챌린지 도전중인지 확인하려고
}

class RoutineTableViewCell : UITableViewCell {
    
    @IBOutlet weak var RImage: UIImageView!
    @IBOutlet weak var RTitle: UILabel!
    @IBOutlet weak var RDescription: UILabel!
    @IBOutlet weak var RDate: UILabel!
    @IBOutlet weak var RDateImage: UIImageView!
    @IBOutlet weak var RIterator: UILabel!
    @IBOutlet weak var RTime: UILabel!
    @IBOutlet weak var RTimeImage: UIImageView! // 시간이미지
    @IBOutlet weak var REditButton: UIButton! // 수정하기
    @IBOutlet weak var REditUnderLine: UIView! // 수정하기 밑줄
    @IBOutlet weak var RChallengeButton: UIButton! // 챌린지 시작버튼
    
    
    let cellHeightRatio : Double = 143/374 // cell height가 width에 종속적(가변한다)이라서 화면 비율 맞춰줄 필요가 있음
    
    
    func initUI(of item : RoutineModel) {
        cellLayout() // cell 내에서의 레이아웃 배치
        cellColor() // cell 모양 및 색
        event()
        
        //REditButton.isHidden = true // 기능 구현이 어려워서 일단 히든해버리자.
        REditUnderLine.isHidden = true // 기능 구현이 어려워서 일단 히든해두기
        // setUI 구성
        RImage.then {
            $0.image = UIImage(named: item.RprofileImage)
            //print(57.65/2)
            $0.layer.cornerRadius = (57.65/2) // 이미지 크기 나누기 2해도 원 만들 수 있지롱
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        RTitle.then {
            $0.text = item.Rtitle
        }
        RDescription.then {
            $0.text = item.Rdescription
        }
        RDate.then {
            $0.text = item.Rdate
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        RIterator.then {
            $0.text = item.Riterator
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        RTime.then {
            $0.text = item.Rtime
            $0.textColor = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        }
        REditButton.then {
            $0.tintColor = UIColor(red: 0.442, green: 0.442, blue: 0.442, alpha: 1)
            $0.isUserInteractionEnabled = true
        }
        REditUnderLine.then {
            $0.backgroundColor = UIColor(red: 0.442, green: 0.442, blue: 0.442, alpha: 1)
        }
        RChallengeButton.then {
            print("item ::: \(item)")
            $0.setTitle(item.RChallengeState, for: .normal) // 2칸 띄어야 모양 예뻐
            $0.tintColor = .white
            $0.layer.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1).cgColor
            $0.layer.cornerRadius = CGFloat((18 * cellHeightRatio)) + CGFloat((10 * cellHeightRatio))
        }
        
    }
    
    func cellLayout() {
        
        RImage.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.left.equalTo(12)
            $0.width.height.equalTo(57.65)
        }
        RTitle.snp.makeConstraints {
            $0.left.equalTo(RImage.snp.right).offset(10.11)
            $0.top.equalTo(17)
        }
        RDescription.snp.makeConstraints {
            $0.left.equalTo(RImage.snp.right).offset(11.11)
            $0.top.equalTo(RTitle.snp.bottom).offset(5 * cellHeightRatio)
            //$0.right.equalTo(REditButton.snp.left).offset(-24)
            $0.width.lessThanOrEqualTo(contentView.frame.width / 2)
        }
        RDateImage.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RDescription.snp.bottom).offset(11.17 * cellHeightRatio)
            $0.width.height.equalTo(RDate.frame.height)
        }
        RDate.snp.makeConstraints {
            $0.left.equalTo(RDateImage.snp.right).offset(7.75)
            $0.top.equalTo(RDateImage.snp.top)
        }
        RIterator.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RDate.snp.bottom).offset(4 * cellHeightRatio)
        }
        RTimeImage.snp.makeConstraints {
            $0.left.equalTo(RDescription.snp.left)
            $0.top.equalTo(RIterator.snp.bottom).offset(8 * cellHeightRatio)
            $0.width.height.equalTo(RTime.frame.height)
        }
        RTime.snp.makeConstraints {
            $0.left.equalTo(RTimeImage.snp.right).offset(7.75)
            $0.top.equalTo(RTimeImage.snp.top)
        }
        RChallengeButton.snp.makeConstraints {
            $0.bottom.equalTo(-14 * cellHeightRatio)
            $0.right.equalTo(-13)
            $0.height.equalTo(38 * cellHeightRatio + 10)
        }
        REditButton.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.right.equalTo(-22)
        }
        REditUnderLine.snp.makeConstraints {
            $0.top.equalTo(REditButton.snp.bottom).offset(-1)
            $0.width.equalTo(REditButton.frame.width)
            $0.height.equalTo(1)
            $0.right.equalTo(REditButton.snp.right)
        }
    }
    
    func cellColor() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        contentView.superview?.backgroundColor = #colorLiteral(red: 1, green: 0.9551523328, blue: 0.9602802396, alpha: 1)
        contentView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    func event() { // UITableCell에 구현된 함수이다.
        RChallengeButton.rx.tap
            .bind {
                // NcameraPage로 넘어가야 한다. id : NCameraViewController
                let vc = UIStoryboard.init(name: "HomeView", bundle: nil).instantiateViewController(identifier: "NCameraViewController") as! NCameraViewController
                vc.modalPresentationStyle = .fullScreen
                
                
                self.RChallengeButton.setTitle("  도전중...  ", for: .normal)
                self.RChallengeButton.backgroundColor = .red
            }
        
        REditButton.rx.tap
            .bind {
                let commonRoutineStoryboard = UIStoryboard.init(name: "CommonRoutine", bundle: nil) // 스토리보드 객체 생성
                guard let vc = commonRoutineStoryboard.instantiateViewController(identifier: "CommonRoutine") as? CommonRoutineViewController else { return }
                vc.fromController = 2 // 어디서 왔는지 알리고 -> 2는 수정하기에서 왔다.
                
                let contentViewCS = self.REditButton.superview // 슈퍼뷰로 접근해서
                let cell = contentViewCS?.superview
                print(type(of: cell))
                
                
            }
    }
}
