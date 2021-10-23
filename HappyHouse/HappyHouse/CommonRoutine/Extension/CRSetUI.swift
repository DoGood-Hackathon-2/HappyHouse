//
//  File.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications

// MARK::: SetUI -> Then이용하여 데이터 처리
extension CommonRoutineViewController {
    func setUI() {
        //let figmaRatio : CGFloat = 374*219
        //let DateBoxRatio = DateBoxView.frame.width * 150 / figmaRatio
        let BoxViewWidth = view.frame.width - (view.frame.width/7)
        
        BackButton.then {
            $0.layoutMargins = .zero
            $0.tintColor = UIColor(red: 0.458, green: 0.458, blue: 0.458, alpha: 1)
        }
        PageTitle.then {
            $0.text = "챌린지 만들기"
        }
        
        RoutineTitle.then {
            $0.text = "챌린지를 만들어 보세요." // 여기에는 sender통해서 인자값 줘서 조정하기
        }
        
        VerfityTitle.then {
            $0.text = "\(verifyTitle)"
            $0.textColor = UIColor(red: 0.133, green: 0.422, blue: 1, alpha: 1)
            //$0.font = UIFont(name: "Pretendard-Bold", size: 28)
        }
        
        CreateRoutineTextField.then {
            $0.placeholder = "챌린지 제목을 적어주세요."
        }
        CRUnderLineView.then {
            $0.backgroundColor = #colorLiteral(red: 0.5654320121, green: 0.7023948431, blue: 0.9619845748, alpha: 1)
            CRUnderLineView.addSubview(CreateRoutineTextField)
        }
        WithWhoLabel.then {
            $0.text = "누구와 함께 할까요?"
        }
        CRcollectionView.then {
            $0.backgroundColor = .none
        }
        WhenStartLabel.then {
            $0.text = "언제 시작할까요?"
        }
        DateBoxView.then {
            $0.layer.cornerRadius = (150 * BoxViewWidth * 20) / (374 * 219) // 피그마에 있는거 화면사이즈에 맞게 수학식으로 변환
            // 추후에 shadow 넣어주어야 함.
        }
        InnerDateBoxViewSetUI()
        RequsetTextViewContainer.then {
            $0.layer.cornerRadius = (56 * BoxViewWidth * 44) / (374 * 219)
        }
        RequestTextView.then {
            if $0.text.count == 0 {
                $0.text = "간단한 메시지를 적어보세요~!"
                $0.textColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
            }
            //RequestTextField.borderStyle = .none
        }
        ChallengeAddButton.then {
            $0.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = (36 * BoxViewWidth * 44) / (374 * 219)
            $0.setTitle("챌린지를 추가하세요", for: .normal)
        }
    }

}
