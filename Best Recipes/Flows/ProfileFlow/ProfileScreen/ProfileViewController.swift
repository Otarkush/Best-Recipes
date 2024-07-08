//
//  ProfileViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UI Properties
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillProportionally
        return element
    }()
    
    private lazy var myProfileLabel: UILabel = {
        let element = UILabel()
        element.text = "My profile"
        element.font = UIFont(name: "Poppins-Bold", size: 35.0)
        return element
    }()
    
    private lazy var settingsButton: UIButton = {
        let element = UIButton()
        let ellipsis = UIImage(systemName: "ellipsis")
        element.setImage(ellipsis, for: .normal)
        element.tintColor = .black
        return element
    }()
        
    private lazy var avatarImageView: UIImageView = {
        let element = UIImageView()
        //element.setImage(UIImage(systemName: "person.circle"), for: .normal)
        element.image = UIImage(systemName: "person.circle")
        element.tintColor = .black
        element.backgroundColor = .lightGray
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        element.isUserInteractionEnabled = true
        return element
    }()
    
    private lazy var myRecipesLabel: UILabel = {
        let element = UILabel()
        element.text = "My recipes"
        element.font = UIFont(name: "Poppins-Bold", size: 35.0)
        return element
    }()
    
        // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        addGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(headerStackView)
        view.addSubview(avatarImageView)
        view.addSubview(myRecipesLabel)
        
        headerStackView.addArrangedSubview(myProfileLabel)
        headerStackView.addArrangedSubview(settingsButton)
    }
    
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    // MARK: - Selector methods
    @objc private func changeAvatar() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
    // MARK: - Selector methods
extension ProfileViewController {
    private func setupConstraints() {
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(headerStackView.snp.bottom).offset(40)
            make.height.width.equalTo(140)
        }
        
        myRecipesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(avatarImageView.snp.bottom).offset(40)
        }
    }
}
