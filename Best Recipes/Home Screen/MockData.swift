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
        .trendingNow([.init(title: "Trending 1", image: "homeIcon"),
                      .init(title: "Trending 2", image: "homeIcon"),
                      .init(title: "Trending 3", image: "homeIcon")])
    }()
    
    private let popularCategory: ListSection = {
        .popularCategory([.init(title: "Popular 1", image: "homeIcon"),
                          .init(title: "Popular 2", image: "homeIcon"),
                          .init(title: "Popular 3", image: "homeIcon")])
    }()
    
    private let recentRecipe: ListSection = {
        .recentRecipe([.init(title: "Recent 1", image: "homeIcon"),
                       .init(title: "Recent 2", image: "homeIcon"),
                       .init(title: "Recent 3", image: "homeIcon")])
    }()
    
    private let popularCuisines: ListSection = {
        .popularCuisines([.init(title: "Cuisines 1", image: "homeIcon"),
                          .init(title: "Cuisines 2", image: "homeIcon"),
                          .init(title: "Cuisines 3", image: "homeIcon")])
    }()
    
    var pageData: [ListSection] {
        [trendingNow, popularCategory, recentRecipe, popularCuisines]
    }
}
