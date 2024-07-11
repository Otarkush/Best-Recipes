//
//  ListSection.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

enum ListSection: Equatable {
    static func == (lhs: ListSection, rhs: ListSection) -> Bool {
        lhs.title == rhs.title
    }
    
    case trendingNow([Recipe])
    case popularCategory([String])
    case popularCategoryRecipes([Recipe])
    case recentRecipe([Recipe])
    case popularCuisine([String])
    case popularCuisineRecipes([Recipe])
    
    var items: [Any] {
        switch self {
        case .trendingNow(let items),
                .popularCategoryRecipes(let items),
                .recentRecipe(let items),
                .popularCuisineRecipes(let items):
            return items
        case .popularCategory(let titles),
                .popularCuisine(let titles):
            return titles
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .trendingNow(_):
            return "Trending now 🔥"
        case .popularCategory(_):
            return "Popular category"
        case .popularCategoryRecipes(_):
            return ""
        case .recentRecipe(_):
            return "Recent recipe"
        case .popularCuisine(_):
            return "Popular cuisines"
        case .popularCuisineRecipes(_):
            return ""
        }
    }
}
