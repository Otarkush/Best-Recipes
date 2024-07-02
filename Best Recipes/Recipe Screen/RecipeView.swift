//
//  RecipeView.swift
//  Best Recipes
//
//  Created by Alexander on 1.07.24.
//

import UIKit

final class RecipeView: UIView {
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = Resources.Fonts.poppinsBold(of: 40)
        label.textColor = Resources.Colors.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

private extension RecipeView {
    func setupUI() {
        backgroundColor = .systemMint
        
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
