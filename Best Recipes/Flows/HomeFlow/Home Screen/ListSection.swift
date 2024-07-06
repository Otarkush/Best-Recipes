//
//  ListSection.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

enum ListSection {
    case trendingNow([Recipe])
    case popularCategoryRecipes([Recipe])
    case recentRecipe([Recipe])
    case popularCuisines([Recipe])
    
    var items: [Recipe] {
        switch self {
        case .trendingNow(let items),
                .popularCategoryRecipes(let items),
                .recentRecipe(let items),
                .popularCuisines(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .trendingNow(_):
            return "Trending now 🔥"
        case .popularCategoryRecipes(_):
            return "Popular category"
        case .recentRecipe(_):
            return "Recent recipe"
        case .popularCuisines(_):
            return "Popular cuisines"
        }
    }
}
