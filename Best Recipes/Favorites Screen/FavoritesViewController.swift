//
//  FavoritesViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

