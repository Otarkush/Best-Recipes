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
    
    private var recipes: [RecipeModel] = []
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesView.setDelegate(self)
        loadSavedRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedRecipes()
    }
    
    private func loadSavedRecipes() {
        let savedRecipes = StorageRecipe.shared.getRecipes()
        recipes = savedRecipes.map { $0.toRecipeModel() }
        favoritesView.favoriteTableView.reloadData()
    }
    
    private func removeRecipe(at index: Int) {
        let recipe = recipes[index].toRecipe()
        StorageRecipe.shared.removeRecipe(recipe)
        recipes.remove(at: index)
        favoritesView.favoriteTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectItem = recipes[indexPath.row]
        //        действие
        let nextVC = RecipeViewController(id: selectItem.id)
        present(nextVC, animated: true)
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
        cell.delegate = self
        return cell
    }
    
}


extension FavoritesViewController: FavoritesTableViewCellDelegate {
    func didTapBookmarkButton(in cell: FavoritesTableViewCell) {
        if let indexPath = favoritesView.favoriteTableView.indexPath(for: cell) {
            removeRecipe(at: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name("Bookmark Tapped"), object: nil)
        }
    }
}
