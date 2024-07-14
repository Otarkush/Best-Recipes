//
//  ProfileViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let favoritesView = FavoritesView()
    private let recipeService = RecipeService()
    
    // MARK: - temp properties
    
    private var score = 0
    private var recipeTitle = ""
    private var image = ""
    private var cuisine = ["Home"]
    private var recipes: [Recipe] = []
    
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
    
    var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileRecipeCell.self, forCellReuseIdentifier: ProfileRecipeCell.identifier)
        return tableView
    }()
    
    
    
        // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        addGestureRecognizers()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        ApiService.random(3).request(type: RandomResponse.self) { respons in
            switch respons {
            case .success(let success):
                if let recipe = success.recipes {
                    DispatchQueue.main.async {
                        self.recipes.append(contentsOf: recipe)
                        self.favoriteTableView.reloadData()
                    }
                }
                
            case .failure(let failure):
                break
            }
        }
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
        view.addSubviews(favoriteTableView)
        
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
            make.height.width.equalTo(80)
        }
        
        myRecipesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(avatarImageView.snp.bottom).offset(40)
        }
        
        favoriteTableView.snp.makeConstraints { make in
            make.top.equalTo(myRecipesLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}


// MARK: - Extensions TableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileRecipeCell.identifier, for: indexPath) as? ProfileRecipeCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
    
}
