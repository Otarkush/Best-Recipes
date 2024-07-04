//
//  MockData.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

struct MockData {
    static let shared = MockData()
    
    private let trendingNow: ListSection = {
        .trendingNow(
            [.init(
                id: 1234,
                title: "2adssad",
                image: "dsasad",
                imageType: "dasda",
                nutrition: nil, sourceName: ""
            )]
        )
    }()
    
    private let popularCategory: ListSection = {
        .popularCategory(
            [.init(
                id: 1234,
                title: "2adssad",
                image: "dsasad",
                imageType: "dasda",
                nutrition: nil, sourceName: ""
            )]
        )
    }()
    
    private let recentRecipe: ListSection = {
        .recentRecipe(
            [.init(
                id: 1234,
                title: "2adssad",
                image: "dsasad",
                imageType: "dasda",
                nutrition: nil,
                sourceName: ""
            )]
        )
    }()
    
    private let popularCuisines: ListSection = {
        .popularCuisines(
            [.init(
                id: 1234,
                title: "2adssad",
                image: "dsasad",
                imageType: "dasda",
                nutrition: nil,
                sourceName: ""
            )]
        )
    }()
    
    var pageData: [ListSection] {
        [trendingNow, popularCategory, recentRecipe, popularCuisines]
    }
}
