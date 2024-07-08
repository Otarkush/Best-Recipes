//
//  RecipeViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit
import SnapKit

final class RecipeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let ingredients: [Ingredient] = [
//        Ingredient(image: UIImage(named: "fish") ?? UIImage(), name: "Fish", quantity: 200),
//        Ingredient(image: UIImage(named: "ginger") ?? UIImage(), name: "Ginger", quantity: 100),
//        Ingredient(image: UIImage(named: "oil") ?? UIImage(), name: "Vegetable Oil", quantity: 80),
//        Ingredient(image: UIImage(named: "salt") ?? UIImage(), name: "Salt", quantity: 50),
//        Ingredient(image: UIImage(named: "cucumber") ?? UIImage(), name: "Cucumber", quantity: 200)
    ]
    
    private let recipeView = RecipeView()
    private var recipe: Recipe?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRecipe()
    }
}

//MARK: - Private Methods

extension RecipeViewController {
    
    private func setupUI() {
        view.addSubview(recipeView)
        
        recipeView.tableView.dataSource = self
        recipeView.tableView.delegate = self
        
        recipeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Запрос на получение рецепта
    func fetchRecipe() {
        ApiService.detail("716429").request(type: Recipe.self) { result in
            switch result {
            case .success(let success):
                print(success)
                self.recipe = success
                DispatchQueue.main.async {
                    self.updateRecipeView()
                }
            case .failure(let failure):
                print("ошибка!!!\(failure)")
            }
        }
    }
    
    //Update RecipeView
    func updateRecipeView() {
        guard let recipe = recipe else { return }
        
        recipeView.configure(with: recipe)
    }
}

//MARK: - UITableViewDataSource and UITableViewDelegate

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else { return  UITableViewCell() }
        
        cell.configure(with: ingredients[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
