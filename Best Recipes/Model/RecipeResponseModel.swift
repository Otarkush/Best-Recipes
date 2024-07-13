//
//  ResipeResponseModel.swift
//  Best Recipes
//
//  Created by dsm 5e on 04.07.2024.
//

import Foundation

// MARK: - RandomResponse
struct RandomResponse: Codable {
    let recipes: [Recipe]?
}

// MARK: - Recipe
struct Recipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let aggregateLikes, healthScore: Int?
    let creditsText, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let imageType, summary: String?
    let dishTypes: [String]? // <---
    let diets: [String]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    let spoonacularScore: Double?
    let spoonacularSourceURL: String?
    let license: String?
    let cuisines: [String]
    
    init(id: Int, score: Double, title: String, image: String, cuisines: [String]) {
        self.id = id
        self.spoonacularScore = score
        self.title = title
        self.image = image
        self.cuisines = cuisines
        self.vegetarian = nil
        self.vegan = nil
        self.glutenFree = nil
        self.dairyFree = nil
        self.veryHealthy = nil
        self.cheap = nil
        self.veryPopular = nil
        self.sustainable = nil
        self.lowFodmap = nil
        self.weightWatcherSmartPoints = nil
        self.gaps = nil
        self.aggregateLikes = nil
        self.healthScore = nil
        self.creditsText = nil
        self.sourceName = nil
        self.pricePerServing = nil
        self.extendedIngredients = nil
        self.readyInMinutes = nil
        self.servings = nil
        self.sourceURL = nil
        self.imageType = nil
        self.summary = nil
        self.dishTypes = nil
        self.diets = nil
        self.instructions = nil
        self.analyzedInstructions = nil
        self.spoonacularSourceURL = nil
        self.license = nil
    }
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Codable {
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int?
    let name, localizedName: String?
    let image: String?
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int?
    let unit: String?
    let image: URL?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Hashable {
    let id: Int?
    let aisle, image: String?
    let consistency: String?
    var name, nameClean, original, originalName: String?
    var amount: Double?
    var unit: String?
    let meta: [String]?
    let measures: Measures?
    
    static func == (lhs: ExtendedIngredient, rhs: ExtendedIngredient) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Measures
struct Measures: Codable, Hashable {
    let us, metric: Metric?
}

// MARK: - Metric
struct Metric: Codable, Hashable {
    let amount: Double?
    let unitShort, unitLong: String?
}


