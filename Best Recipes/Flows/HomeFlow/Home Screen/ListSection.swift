//
//  ListSection.swift
//  Best Recipes
//
//  Created by Иван Семикин on 02/07/2024.
//

import Foundation

enum ListSection: Equatable {
    static func == (lhs: ListSection, rhs: ListSection) -> Bool {
        lhs.count == rhs.count
    }
    
    case trendingNow([Recipe])
    case popularCategory([SpoonacularMealType])
    case popularCategoryRecipes([ComplexSearchResult])
    case recentRecipe([Recipe])
    case popularCuisine([SpoonacularCuisinesType])
    case popularCuisineRecipes([Recipe])
    
    var items: [Any] {
        switch self {
        case let .trendingNow(items),
             let .recentRecipe(items),
             let .popularCuisineRecipes(items):
            return items
        case let .popularCategoryRecipes(items):
            return items
        case let .popularCategory(titles):
            return titles
        case let .popularCuisine(title):
            return title
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
