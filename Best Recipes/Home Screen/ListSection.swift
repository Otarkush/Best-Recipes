//
//  ListSection.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

enum ListSection {
    case trendingNow([ListItem])
    case popularCategory([ListItem])
    case recentRecipe([ListItem])
    case popularCuisines([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .trendingNow(let items),
                .popularCategory(let items),
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
            return "Tranding now 🔥"
        case .popularCategory(_):
            return "Popular category"
        case .recentRecipe(_):
            return "Recent recipe"
        case .popularCuisines(_):
            return "Popular cuisines"
        }
    }
}
