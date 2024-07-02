//
//  FavoritesViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

struct Recipe {
let title: String
let image: String
}

final class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    
//    данные c API с картинкой и текстом
    var recipe: [Recipe] = []
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesView.setDelegate(self)
    }
    
}

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
        cell.configure(with: recipe[indexPath.row])
        return cell
    }
    
    
}
