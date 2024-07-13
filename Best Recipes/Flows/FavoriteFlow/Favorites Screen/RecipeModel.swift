//
//  Recipe.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 05.07.2024.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let score: Double
    let title: String
    let image: String
    let cuisines: [String] 
}
