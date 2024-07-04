//
//  ResipeResponseModel.swift
//  Best Recipes
//
//  Created by dsm 5e on 04.07.2024.
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
    let sourceName: String?
}

struct Nutrition: Codable {
    let nutrients: [Nutrient]?
}

struct Nutrient: Codable {
    let name: String?
    let amount: Double?
    let unit: String?
}
