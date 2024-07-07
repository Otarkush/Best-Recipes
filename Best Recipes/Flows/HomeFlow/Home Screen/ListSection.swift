//
//  ListSection.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

enum ListSection {
    case trendingNow([Recipe])
    case popularCategory([String])
    case popularCategoryRecipes([Recipe])
    case recentRecipe([Recipe])
    case popularCuisines([String])
    
    var items: [Any] {
        switch self {
        case .trendingNow(let items),
                .popularCategoryRecipes(let items),
                .recentRecipe(let items):
            return items
        case .popularCategory(let titles),
                .popularCuisines(let titles):
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
        case .popularCuisines(_):
            return "Popular cuisines"
        }
    }
}
