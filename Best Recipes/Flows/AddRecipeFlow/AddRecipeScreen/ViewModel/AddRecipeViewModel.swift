//
//  AddRecipeViewModel.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import Foundation

class AddRecipeViewModel {
    
    let servesOptions = ["1", "2", "3", "4", "5"]
    let cookTimeOptions = ["5 min", "10 min", "15 min", "20 min", "25 min", "30 min"]
    
    var ingredients: [ExtendedIngredient] = [
        .init(
            id: UUID().hashValue,
            aisle: "",
            image: "",
            consistency: "",
            name: "",
            nameClean: "",
            original: "",
            originalName: "",
            amount: nil,
            unit: "",
            meta: [],
            measures: nil
        )
    ]
    
    init() {
        
    }
    
    
}
