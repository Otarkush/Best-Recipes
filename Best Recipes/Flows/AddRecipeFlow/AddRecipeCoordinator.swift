//
//  AddRecipeCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 05.07.2024.
//

import Foundation

class AddRecipeCoordinator: Coordinator {
    
    override func start() {
        print("Init Add Recipe screen")
        let viewModel = AddRecipeViewModel()
        let vc = AddRecipeViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AddRecipeCoordinator finish")
    }
}
