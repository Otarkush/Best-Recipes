//
//  ProfileViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    // MARK: - Temp Properties
    
    private var score = 0
    private var recipeTitle = " "
    private var image = " "
    private var recipes: [RecipeModel] = []
    private var recipe: Recipe!
//    private var id: Int!
    
    // MARK: - Life Cycle
    
//    init(id: Int) {
//        self.id = id
//        super .init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My profile"

        profileView.setDelegate(self)
        
        
    }
}

func fetchRecipe() {
    ApiService.random(4).request(type: Recipe.self) { result in
        switch result {
        case .success(let success):
            print(success)
            self.recipes
        }
    }
    
}

// MARK: - Extensions UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recipes.count)
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = ProfileTableViewCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
}
