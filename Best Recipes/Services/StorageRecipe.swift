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
    
    func removeRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        saveRecipes()
    }
    
    func saveRecipes() {
        guard let recipesEncoded = try? JSONEncoder().encode(recipes) else { return }
        defaults.set(recipesEncoded, forKey: "savedRecipes")
        print("Save RECIPES")
    }
}

extension Recipe {
    func toRecipeModel() -> RecipeModel {
        return RecipeModel(id: self.id ?? 0, score: self.spoonacularScore ?? 0.0, title: self.title ?? "", image: self.image ?? "", cuisines: self.cuisines)
    }
}

extension RecipeModel {
    func toRecipe() -> Recipe {
        return Recipe(id: self.id, score: self.score, title: self.title, image: self.image, cuisines: self.cuisines)
    }
}
