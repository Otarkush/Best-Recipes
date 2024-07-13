//
//  StorageRecipe.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 13.07.2024.
//

import Foundation

class StorageRecipe {
    
    static let shared = StorageRecipe()
    
    private var saveRecipe = RecipeModel(id: 0, score: 0.0, title: "", image: "", cuisines: [""])
    private let defaults = UserDefaults.standard
    
    func getRecipe() -> RecipeModel {
        guard let savedData = defaults.object(forKey: "savedRecipe") as? Data else { return saveRecipe }
        guard let loadRecipe = try? JSONDecoder().decode(RecipeModel.self, from: savedData) else { return saveRecipe }
        saveRecipe = loadRecipe
        return saveRecipe
    }
    
    func saveRecipe(_ recipe: Recipe) {
        guard let recipeEncoded = try? JSONEncoder().encode(recipe) else { return }
        defaults.set(recipeEncoded, forKey: "savedRecipe")
        print("Save RECIPE ")
    }
}
