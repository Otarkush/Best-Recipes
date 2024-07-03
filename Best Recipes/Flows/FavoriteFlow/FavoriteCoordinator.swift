//
//  FavoriteCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation

class FavoriteCoordinator: Coordinator {
    
    override func start() {
        print("Init favorite screen")
        let vc = RecipeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
