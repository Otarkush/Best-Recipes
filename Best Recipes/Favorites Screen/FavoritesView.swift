//
//  FavoritesView.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit

class FavoritesView: UIView {
    
    // MARK: -  Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setView()
    }
    // MARK: - Settings View
    
    private func setView() {
        backgroundColor = .red
    }
}
