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
        
    private let recipeView = RecipeView()
    private var recipe: Recipe?
    private let id: Int!
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationController?.navigationBar.isHidden = false
        view.addSubview(recipeView)
        
        recipeView.tableView.dataSource = self
        recipeView.tableView.delegate = self
        
        recipeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Запрос на получение рецепта
    func fetchRecipe() {
        self.showLoader()
        ApiService.detail(id.description).request(type: Recipe.self) { result in
            switch result {
            case .success(let success):
                print(success)
                self.recipe = success
                DispatchQueue.main.async {
                    self.updateRecipeView()
                    self.hideLoader()
                    self.recipeView.tableView.reloadData()
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
        return recipe?.extendedIngredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else { return  UITableViewCell() }
        
        guard let ingredients = recipe?.extendedIngredients else {
            print("Нет рецепта")
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        cell.configure(with: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
