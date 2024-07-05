//
//  FavoritesViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

struct Recipes {
    let id: Int
    let title: String
    let image: String
    let imageCuisine: String
    let cuisine: String
    let raiting: String
}

final class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    
    //    данные c API с картинкой и текстом
    let recipeGarlic = Recipes(id: 716429,
                              title: "Pasta with Garlic, Scallions",
                              image: "716429.jpg", imageCuisine: "fish.jpg", cuisine: "China", raiting: "5.0")
    let recipePork = Recipes(id: 715538, title: "What to make for dinner", image: "715538.jpg", imageCuisine: "fish.jpg", cuisine: "Tay", raiting: "4.5")
    
    lazy var recipe: [Recipes] = [recipeGarlic, recipePork, recipeGarlic, recipePork]
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesView.setDelegate(self)
    }
    
}

// MARK: - Extinsions

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = FavoritesTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: recipe[indexPath.row])
        return cell
    }
    
}
