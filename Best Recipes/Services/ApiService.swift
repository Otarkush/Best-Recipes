//
//  SpooncolarService.swift
//  Best Recipes
//
//  Created by dsm 5e on 04.07.2024.
//

import Foundation

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
    case create(CreateRequestDTO)
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
            return "recipes/visualizeRecipe"
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
        switch self {
        case let .create(request):
            return [
                "title": request.title,
                "ingredients": request.ingredients,
                "instructions": request.instructions,
                "readyInMinutes": String(request.readyInMinutes),
                "servings": String(request.servings),
                "mask": request.mask,
                "backgroundImage": request.backgroundImage,
                "author": request.author,
                "backgroundColor": request.backgroundColor,
                "fontColor": request.fontColor,
                "source": request.source
            ]
        default:
            return nil
        }
    }
    
    var data: Data? {
        switch self {
        case .create(let request):
            return request.image?.jpegData(compressionQuality: 1.0)
        default:
            return nil

        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create:
            [
                "Content-Type": "multipart/form-data",
                "x-api-key": apiKey.rawValue
            ]
        default:
            [
                "Content-type": "application/json",
                "x-api-key": apiKey.rawValue
            ]
        }
    }
}
