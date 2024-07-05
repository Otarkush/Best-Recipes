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
    
    
    func configureCell(imageName: String) {
        if let imageUrl = URL(string: imageName) {
            recipeImageView.kf.setImage(with: imageUrl)
        }
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
