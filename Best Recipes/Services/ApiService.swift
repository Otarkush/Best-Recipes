//
//  SpooncolarService.swift
//  Best Recipes
//
//  Created by dsm 5e on 04.07.2024.
//

import Foundation

// MARK: - Пример использования
//ApiService
//    .search("juice")
//    .request(type: RecipeResponse.self) { result in
//    switch result {
//    case .success(let success):
//        print(success)
//        success.results?.forEach({ Recipe in
//            print(Recipe.title)
//        })
//    case .failure(let failure):
//        print(failure)
//    }
//}

// MARK: - Spoonacular Meal Type
enum SpoonacularMealType: String {
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
}

// MARK: - Spoonacular Cuisines Type
enum SpoonacularCuisinesType: String, CaseIterable {
    case african = "African"
    case asian = "Asian"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
}

// MARK: - Spoonacular Service
enum ApiService {
    case search(String)
    case random(Int)
    case detail(String)
    case mealType(SpoonacularMealType)
    case cuisineType(SpoonacularCuisinesType)
    case create
}

extension ApiService: HTTPClient {
    
    var apiKey: ApiKeys {
        return .allCases.randomElement()!
    }
    
    var baseURL: String {
        return "https://api.spoonacular.com/"
    }
    
    var path: String {
        switch self {
        case .search:
            return "recipes/complexSearch?query="
        case .random:
            return "recipes/random?"
        case .detail:
            return "recipes/"
        case .mealType:
            return "recipes/complexSearch?query="
        case .create:
            return ""
        case .cuisineType:
            return ""
        }
    }
    
    var endpoint: String {
        switch self {
        case let .search(query):
            return query
        case let .random(count):
            return "number=\(count)"
        case let .detail(id):
            return "\(id)/information"
        case let .mealType(type):
            return type.rawValue
        case .create:
            return ""
        case .cuisineType:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .POST
        default:
            return .GET
        }
    }
    
    var parameters: [String : String]? {
        nil
    }
    
    var headers: [String : String]? {
        [
            "Content-type": "application/json",
            "x-api-key": apiKey.rawValue
        ]
    }
}
