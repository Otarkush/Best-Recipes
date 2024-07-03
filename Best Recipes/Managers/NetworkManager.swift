//
//  NetworkManager.swift
//  Best Recipes
//
//  Created by dsm 5e on 03.07.2024.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]?
    let recipes: [Recipe]?
    let offset: Int?
    let number: Int?
    let totalResults: Int?
}

struct Recipe: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
    let nutrition: Nutrition?
}

struct Nutrition: Codable {
    let nutrients: [Nutrient]?
}

struct Nutrient: Codable {
    let name: String?
    let amount: Double?
    let unit: String?
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let apiKey = "98a008d46b8a42bd811cfc7b0680c3f5"
    private let baseUrl = "https://api.spoonacular.com/"
    private let decoder = JSONDecoder()
    
    private func request<T: Decodable>(urlString: String, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents(string: baseUrl + urlString)!
        components.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        components.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        let url = components.url!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try self.decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func complexSearch(query: String, maxFat: Int? = nil, number: Int? = nil, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        var parameters: [String: Any] = [:]
        parameters["query"] = query
        if let maxFat = maxFat {
            parameters["maxFat"] = maxFat
        }
        if let number = number {
            parameters["number"] = number
        }
        request(urlString: "recipes/complexSearch", parameters: parameters, completion: completion)
    }
    
    func getRandomRecipes(includeNutrition: Bool? = nil, includeTags: String? = nil, excludeTags: String? = nil, number: Int, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        var parameters: [String: Any] = [:]
        parameters["number"] = number
        if let includeNutrition = includeNutrition {
            parameters["includeNutrition"] = includeNutrition
        }
        if let includeTags = includeTags {
            parameters["include-tags"] = includeTags
        }
        if let excludeTags = excludeTags {
            parameters["exclude-tags"] = excludeTags
        }
        
        request(urlString: "recipes/random", parameters: parameters, completion: completion)
    }
}

// MARK: - Моковые данные
private extension NetworkManager {
    func getMockComplexSearch() -> [Recipe] {
        return  [
            Recipe(
                id: 1095799,
                title: "Juicy pear and apple cake",
                image: "https://img.spoonacular.com/recipes/1095799-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 648627,
                title: "Juicy & Tender ~ Pork Loin Roast",
                image: "https://img.spoonacular.com/recipes/648627-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 637344,
                title: "Celery & Ginger Juice",
                image: "https://img.spoonacular.com/recipes/637344-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 641443,
                title: "Detox Orange Carrot Juice",
                image: "https://img.spoonacular.com/recipes/641443-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 642613,
                title: "Fast-Acting Cold Remedy Juice Drink",
                image: "https://img.spoonacular.com/recipes/642613-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 640349,
                title: "Cranberry and Orange Juice Spareribs",
                image: "https://img.spoonacular.com/recipes/640349-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 650471,
                title: "Luscious Avocado Ice Cream With Lemon Juice",
                image: "https://img.spoonacular.com/recipes/650471-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 1095729,
                title: "Immunity Booster Beet, Carrot & Orange Juice",
                image: "https://img.spoonacular.com/recipes/1095729-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 645514,
                title: "Green Salad With Fresh Orange Juice Dressing",
                image: "https://img.spoonacular.com/recipes/645514-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 1697639,
                title: "Foolproof Cooking Method to Make the Juiciest Chicken Breast",
                image: "https://img.spoonacular.com/recipes/1697639-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            )
        ]
    }
    
    func getMockRandomRecipe() -> [Recipe] {
        return [
            Recipe(
                id: 1095799,
                title: "Juicy pear and apple cake",
                image: "https://img.spoonacular.com/recipes/1095799-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 648627,
                title: "Juicy & Tender ~ Pork Loin Roast",
                image: "https://img.spoonacular.com/recipes/648627-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 637344,
                title: "Celery & Ginger Juice",
                image: "https://img.spoonacular.com/recipes/637344-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 641443,
                title: "Detox Orange Carrot Juice",
                image: "https://img.spoonacular.com/recipes/641443-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 642613,
                title: "Fast-Acting Cold Remedy Juice Drink",
                image: "https://img.spoonacular.com/recipes/642613-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 640349,
                title: "Cranberry and Orange Juice Spareribs",
                image: "https://img.spoonacular.com/recipes/640349-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 650471,
                title: "Luscious Avocado Ice Cream With Lemon Juice",
                image: "https://img.spoonacular.com/recipes/650471-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 1095729,
                title: "Immunity Booster Beet, Carrot & Orange Juice",
                image: "https://img.spoonacular.com/recipes/1095729-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 645514,
                title: "Green Salad With Fresh Orange Juice Dressing",
                image: "https://img.spoonacular.com/recipes/645514-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            ),
            Recipe(
                id: 1697639,
                title: "Foolproof Cooking Method to Make the Juiciest Chicken Breast",
                image: "https://img.spoonacular.com/recipes/1697639-312x231.jpg",
                imageType: "jpg",
                nutrition: nil
            )
        ]
    }
    
}
