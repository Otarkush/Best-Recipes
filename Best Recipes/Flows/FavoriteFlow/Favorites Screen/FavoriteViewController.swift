//
//  FavoritesViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit
import Kingfisher


final class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    private let recipeService = RecipeService()
    
    // MARK: - temp properties
    
    private var score = 0
    private var recipeTitle = ""
    private var image = ""
    private var cuisine = ["Home"]
    private var recipes: [RecipeModel] = []
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesView.setDelegate(self)
        recipeService.delegate = self
//        запрос
        recipeService.performRequest("https://api.spoonacular.com/recipes/random?number=4", key: "3aadffa0a33849f4ac3edcaa269851d8")
    }
}

// MARK: - Extinsions

extension FavoritesViewController: RequestRecipeDelegate {
    func didReceiveRecipe(recipeData: [RecipeModel]) {
//        обновление данных в контроллере
        self.recipes = recipeData
        
//        обновление таблицы
        DispatchQueue.main.async {
            self.favoritesView.favoriteTableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print("We have parse error: \(error)")
    }
}

// MARK: - Extensions TableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = FavoritesTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
    
}
