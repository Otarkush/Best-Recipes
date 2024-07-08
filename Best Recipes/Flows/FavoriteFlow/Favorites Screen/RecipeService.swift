//
//  RecipeService.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 05.07.2024.
//

import Foundation

protocol RequestRecipeDelegate {
    func didReceiveRecipe(recipeData: [RecipeModel])
    func didFailWithError(error: Error)
}

class RecipeService {
    
    var delegate: RequestRecipeDelegate?
    
    func performRequest(_ urlString: String, key: String) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            guard let data = data else {
                self.delegate?.didFailWithError(error: NSError(domain: "DataError", code: -1))
                return
            }
            
            if let recipeData = self.parseJSON(data) {
                self.delegate?.didReceiveRecipe(recipeData: recipeData)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ recipeData: Data) -> [RecipeModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            return decodedData.recipes.map {
                RecipeModel(id: $0.id, score: $0.healthScore, title: $0.title, image: $0.image, cuisines: $0.cuisines)
            }
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

