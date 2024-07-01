//
//  RecipeView.swift
//  Best Recipes
//
//  Created by Alexander on 1.07.24.
//

import UIKit

final class RecipeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        layoutViews()
        configure()
    }
}

extension RecipeView {
    func addViews() {
        
    }
    
    func layoutViews() {
        
    }
    
    func configure() {
        backgroundColor = .red
    }
}
