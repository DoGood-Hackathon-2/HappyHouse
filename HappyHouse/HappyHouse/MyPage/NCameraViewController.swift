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

class NCameraViewController : UIViewController {
    
    @IBOutlet weak var PhotoImage: UIView!
    @IBOutlet weak var PhotoButton: UIButton!
    @IBOutlet weak var MemoTitle: UILabel!
    @IBOutlet weak var MomoView: UITextView!
    @IBOutlet weak var okButton: UIButton!
    
    let safetyArea: UIView = {
        let v = UIView()
        return v
    }()
    
    var DeviceWidth : CGFloat = 0.0
    var DeviceHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        DeviceWidth = view.frame.width
        DeviceHeight = view.frame.height
        
        setData()
        setBaseView()
        layout()
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
            $0.bottom.equalTo(okButton).offset(-16)
        }
        okButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
    }
    
    func setData() {
        _ = MemoTitle.then {
            $0.text = "메모를 입력하세요"
        }
    }
    
}
