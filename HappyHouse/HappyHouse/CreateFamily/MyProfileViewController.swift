//
//  CreateProfileViewController.swift
//  HappyHouse
//
//  Created by Dain Song on 2021/08/14.
//

import UIKit
import RxSwift

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var familyName: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nickName: UITextField!
    let imagePicker = UIImagePickerController()
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        setImagePicker()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
    }
    
    func initUI() {
        let familyName = User.familyName
        self.familyName.text = familyName
        self.welcomeLabel.text = "\(familyName) 안에서의 \n역할을 입력해주세요"
        
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
    }
    
    func setImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func touchUpProfile(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    
    @IBAction func touchUpFinishButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "AddMemberViewController") as? FamilyViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        profileButton.setImage(newImage, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
}
