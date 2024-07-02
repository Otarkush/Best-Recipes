//
//  RecipeViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

final class RecipeViewController: UIViewController {
    private let ingredients: [Ingredient] = [
        Ingredient(image: Resources.Images.TabBar.bookmark!, name: "Fish", quantity: 200),
        Ingredient(image: Resources.Images.TabBar.bookmark!, name: "Ginger", quantity: 100),
        Ingredient(image: Resources.Images.TabBar.bookmark!, name: "Vegetable Oil", quantity: 80),
        Ingredient(image: Resources.Images.TabBar.bookmark!, name: "Salt", quantity: 50),
        Ingredient(image: Resources.Images.TabBar.bookmark!, name: "Cucumber", quantity: 200)
    ]
    
    private let recipeView = RecipeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(recipeView)
        
        recipeView.tableView.dataSource = self
        recipeView.tableView.delegate = self
        
        recipeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 10
       }
   

}
