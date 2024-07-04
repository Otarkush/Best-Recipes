//
//  PopularCategoriesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit
import Kingfisher

final class PopularCategoriesCollectionViewCell: UICollectionViewCell {
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(recipeImageView)
    }
    
    func configureCell(imageName: String) {
        if let imageUrl = URL(string: imageName) {
            recipeImageView.kf.setImage(with: imageUrl)
        }
    }
    
    func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make
                .edges.equalToSuperview()
        }
    }
}
