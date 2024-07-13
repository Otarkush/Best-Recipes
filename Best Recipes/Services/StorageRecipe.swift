//
//  StorageRecipe.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 13.07.2024.
//

import Foundation

class StorageRecipe {
    static let shared = StorageRecipe()

    private let defaults = UserDefaults.standard
    private(set) var recipes: [Recipe] = []

    init() {
        recipes = getRecipes()
    }

    func getRecipes() -> [Recipe] {
        guard let savedData = defaults.object(forKey: "savedRecipes") as? Data else { return [] }
        guard let loadedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) else { return [] }
        return loadedRecipes
    }

    func saveRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveRecipes()
        print(recipes.count)
    }

    func saveRecipes() {
        guard let recipesEncoded = try? JSONEncoder().encode(recipes) else { return }
        defaults.set(recipesEncoded, forKey: "savedRecipes")
        print("Save RECIPES")
    }
}
