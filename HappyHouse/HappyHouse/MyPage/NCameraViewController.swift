//
//  CameraViewController.swift
//  HappyHouse
//
//  Created by Hamlit Jason on 2021/10/12.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import UserNotifications


class NCameraViewController : UIViewController {
    
    @IBOutlet weak var PhotoImage: UIImageView!
    @IBOutlet weak var PhotoButton: UIButton!
    @IBOutlet weak var MemoTitle: UILabel!
    @IBOutlet weak var MomoView: UITextView!
    @IBOutlet weak var okButton: UIButton!
    
    let bag = DisposeBag()
    
    let safetyArea: UIView = {
        let v = UIView()
        return v
    }()
    
    var DeviceWidth : CGFloat = 0.0
    var DeviceHeight : CGFloat = 0.0
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        DeviceWidth = view.frame.width
        DeviceHeight = view.frame.height
        
        picker.delegate = self
        //picker.allowsEditing = true
        
        setData()
        setBaseView()
        layout()
        event() 
    }
    
}

extension NCameraViewController {
    
    func setBaseView(){
        safetyArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safetyArea)
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            safetyArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            safetyArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            safetyArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            safetyArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            
        } else {
            safetyArea.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
            safetyArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
            safetyArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            safetyArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    func layout() {
        
        safetyArea.addSubview(PhotoImage)
        safetyArea.addSubview(PhotoButton)
        safetyArea.addSubview(MemoTitle)
        safetyArea.addSubview(MomoView)
        safetyArea.addSubview(okButton)
        
        PhotoImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(DeviceWidth)
        }
        PhotoButton.snp.makeConstraints {
            $0.bottom.equalTo(PhotoImage)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(73)
        }
        MemoTitle.snp.makeConstraints {
            $0.top.equalTo(PhotoImage.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        MomoView.snp.makeConstraints {
            $0.top.equalTo(MemoTitle.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(okButton.snp.top).offset(-16)
        }
        okButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
    }
    
    func setData() {
        
        _ = PhotoImage.then{
            $0.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            
        }
        
        _ = MemoTitle.then {
            $0.text = "간단한 메모도 남길 수 있어요!"
            $0.textColor = UIColor(red: 0.296, green: 0.296, blue: 0.296, alpha: 1)
        }
        
        _ = MomoView.then {
            $0.text = "메모를 입력해주세요."
            $0.textColor = .lightGray
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1).cgColor
        }
        
        _ = okButton.then{
            $0.setTitle("인증하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(red: 0.446, green: 0.631, blue: 1, alpha: 1)
            $0.layer.cornerRadius = (DeviceWidth-32) * 24 / 380
            
        }
    }
    
    func event() {
        MomoView.rx.didBeginEditing
            .bind{
                if self.MomoView.text.count == 0 {
                    self.MomoView.text = "메모를 입력해주세요."
                    self.MomoView.textColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
                } else {
                    self.MomoView.text = ""
                    self.MomoView.textColor = .black
                    
                }
                self.MomoView.textColor = .black
            }.disposed(by: bag)
        
        PhotoButton.rx.tap
            .bind{
                let alert = UIAlertController(title: "", message: "갤러리", preferredStyle: .actionSheet)
                let library = UIAlertAction(title: "사진 앨범", style: .default)  {_ in
                    self.openLibrary()
                }
                let camera = UIAlertAction(title: "카메라", style: .default) {_ in
                    self.openCamera()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(library)
                alert.addAction(camera)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        
        okButton.rx.tap
            .bind{
                // 데이터 처리
                print("okbutton click")
                self.dismiss(animated: true, completion: nil)
            }.disposed(by: bag)
    }
}

extension NCameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            PhotoImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
