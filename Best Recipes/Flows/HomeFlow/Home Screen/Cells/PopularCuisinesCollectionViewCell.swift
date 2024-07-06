//
//  PopularCuisinesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit

final class PopularCuisinesCollectionViewCell: UICollectionViewCell {
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String) {
        if let imageUrl = URL(string: imageName) {
            recipeImageView.kf.setImage(with: imageUrl)
        }
    }
}

// MARK: - Private Methods

private extension PopularCuisinesCollectionViewCell {
    func setupUI() {
        contentView.addSubview(recipeImageView)
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make
                .edges.equalToSuperview()
        }
    }
}
