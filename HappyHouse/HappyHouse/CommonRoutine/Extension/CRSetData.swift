//
//  CRSetData.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/18.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import UserNotifications

// MARK::: setData UI Then이용하여 처리
extension CommonRoutineViewController {
    
    func setData() {
        
        viewModel.dummyObsrvable
            .bind(to: CRcollectionView.rx
                    .items(
                        cellIdentifier: "CRCell",
                        cellType: CRCollectionViewCell.self)
            ) { index, item, cell in
                cell.initUI(of: item)
            }.disposed(by: bag)
        
        YearTextField.rx.text.orEmpty
            .skip(1) // 구독 시 bind코드가 적용되는데 밑줄이 우리가 포커스를 잡은 시점부터 나타나길 바래서
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.YearTextField4($0)
                self.Yearborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag) // 메모리 누수를 막읍시다.
        
        MonthTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.MonthTextField2($0)
                self.Monthborder.isHidden = false
            })
            .disposed(by: bag)
        
        DayTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.DayTextField2($0)
                self.Dayborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        HourTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.HourTextField2($0)
                self.Hourborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        MinuteTextField.rx.text.orEmpty
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .bind{
                self.MinuteTextField2($0)
                self.Minuteborder.isHidden = false
            } // 에러 방출할 일 없으니 bind로 사용해보자
            .disposed(by: bag)
        
        AMButton.rx.tap
            .bind{
                self.AMButton.setTitleColor(.black, for: .normal)
                self.PMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }.disposed(by: bag)
        
        PMButton.rx.tap
            .bind{
                self.PMButton.setTitleColor(.black, for: .normal)
                self.AMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
            }.disposed(by: bag)
        
        TimeActivationButton.rx.tap
            .bind{
                if self.TimeActivationButton.image(for: .normal) == UIImage(systemName: "plus.circle") { // 비활성화 상태 -> 활성화 상태
                    if self.nowDateTime(5) == "AM" {
                        self.AMButton.setTitleColor(.black, for: .normal)
                        self.PMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                    } else {
                        self.PMButton.setTitleColor(.black, for: .normal)
                        self.AMButton.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                    }
                    self.TimeActivationButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
                    self.PMButton.isEnabled = true
                    self.AMButton.isEnabled = true
                    self.MinuteTextField.isEnabled = true
                    self.MinuteTextField.textColor = .black
                    self.Minuteborder.isHidden = false
                    self.HourTextField.isEnabled = true
                    self.HourTextField.textColor = .black
                    self.Hourborder.isHidden = false
                    self.ClockIcon.tintColor = .black
                } else { // 활성화 상태 -> 비활성화 상태
                    self.TimeActivationButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
                    self.PMButton.isEnabled = false
                    self.PMButton.setTitleColor(.gray, for: .normal)
                    self.AMButton.isEnabled = false
                    self.AMButton.setTitleColor(.gray, for: .normal)
                    self.MinuteTextField.isEnabled = false
                    self.MinuteTextField.textColor = .gray
                    self.Minuteborder.isHidden = true
                    self.HourTextField.isEnabled = false
                    self.HourTextField.textColor = .gray
                    self.Hourborder.isHidden = true
                    self.ClockIcon.tintColor = .gray
                }
            }.disposed(by: bag)
        
        // MARK:: WeekendButtonClick 상태 확인
        WeekStackIndex0.rx.tap
            .bind{
                if self.WeekStackIndex0.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex0.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex0.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex1.rx.tap
            .bind{
                if self.WeekStackIndex1.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex1.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex1.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex2.rx.tap
            .bind{
                if self.WeekStackIndex2.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex2.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex2.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex3.rx.tap
            .bind{
                if self.WeekStackIndex3.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex3.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex3.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex4.rx.tap
            .bind{
                if self.WeekStackIndex4.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex4.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex4.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex5.rx.tap
            .bind{
                if self.WeekStackIndex5.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex5.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex5.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex6.rx.tap
            .bind{
                if self.WeekStackIndex6.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex6.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex6.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        WeekStackIndex7.rx.tap
            .bind{
                if self.WeekStackIndex7.currentTitleColor == UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1) {
                    self.WeekStackIndex7.setTitleColor(.black, for: .normal)
                } else {
                    self.WeekStackIndex7.setTitleColor(UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1), for: .normal)
                }
            }
            .disposed(by: bag)
        
        RequestTextView.rx.didBeginEditing
            .bind{ _ in
                if self.RequestTextView.text == "간단한 메시지를 적어보세요~!" {
                    self.RequestTextView.text = ""
                }
                self.RequestTextView.textColor = .black
            }.disposed(by: bag)
        
        RequestTextView.rx.didEndEditing
            .bind{
                if self.RequestTextView.text.count == 0 {
                    self.RequestTextView.text = "간단한 메시지를 적어보세요~!"
                    self.RequestTextView.textColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
                }
            }.disposed(by: bag)
    //
    //                CreateRoutineTextField.rx.controlEvent([.editingDidBegin])
    //                    .bind{
    //                        print("touch begin")
    //                    }.disposed(by: bag)
        
        
        ChallengeAddButton.rx.tap
            .bind{
                /*
                 확인해야하는 사항
                 1. 제목이 정상적으로 들어가 있는지
                 2. 누구와 함께할지 선택 하였는지 - 선택하지 않았다면 그냥 default
                 3. 날짜는 잘 들어가 있고, 오늘 날짜보다 뒤인지.
                 4. 시간은 어떻게 설정했는지, 아예 막았을 수도 있어서 AM,PM도 검사
                 5. 요일 선택은 어떻게 했는지
                 6. 요청 메시지는 어떻게 입력했는지. -> 요청 메시지는 없어도 돼.
                 */
                if self.ChallengeAddButton.currentTitle == "챌린지를 추가하세요" {
                    self.ChecktheOption()
                } else { // 글 확인하기
                    // 도전 중인 챌린지에 넣거나, 데이터 모델 안에 챌린지 도전 여부를 바로 넣어서 확인한다.
                    self.alert("챌린지를 시작합니다") {
                        self.myPageTable.dummyRoutineData[self.idxpath].RChallengeState = "  챌린지 중  "
                        print(self.myPageTable.dummyRoutineData)
                        self.dismiss(animated: false) {
                            print("AD")
                            
                        }
                    }
                }
                
                
            }.disposed(by: bag)
        
        BackButton.rx.tap
            .bind{
                self.dismiss(animated: true, completion: nil)
            }.disposed(by: bag)
        
    }

}
