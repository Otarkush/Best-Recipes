//
//  RecentRecipeCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit

final class RecentRecipeCollectionViewCell: UICollectionViewCell {
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleRecipeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let authorNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(recipe: Recipe) {
        if let imageUrl = URL(string: recipe.image ?? "") {
            recipeImageView.kf.setImage(with: imageUrl)
        }
        titleRecipeLabel.text = recipe.title
        authorNameLabel.text = "By \(recipe.sourceName ?? "")"
    }

}

// MARK: - Private Methods
private extension RecentRecipeCollectionViewCell {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}
