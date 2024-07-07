//
//  CreateRequestModel.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import UIKit

struct CreateRequestDTO {
    let title: String
    let ingredients: String
    let instructions: String
    let readyInMinutes: Int
    let servings: Int
    let mask: String
    let backgroundImage: String
    let author: String
    let backgroundColor: String
    let fontColor: String
    let source: String
    let image: UIImage?
}

struct CreateResponse: Codable {
    let url: String
}
