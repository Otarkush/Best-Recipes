//
//  ComplexSearchResponse.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import Foundation

// MARK: - ComplexSearchResponse
struct ComplexSearchResponse: Codable {
    let results: [ComplexSearchResult]?
    let offset, number, totalResults: Int?
}

// MARK: - Result
struct ComplexSearchResult: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
    let nutrition: Nutrition?
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients: [Nutrient]?
}

// MARK: - Nutrient
struct Nutrient: Codable {
    let name: String?
    let amount: Double?
    let unit: String?
}
