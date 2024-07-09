//
//  RecipeData.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 05.07.2024.
//

import Foundation

struct RecipeData: Codable {
    let recipes: [Recipes]
}

struct Recipes: Codable {
    let healthScore: Int
    let id: Int
    let title: String
    let image: String
    let cuisines: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstructions]
}

struct AnalyzedInstructions: Codable {
    let steps: [Steps]
}

struct Steps: Codable {
    let number: Int
    let step: String
}
