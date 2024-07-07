//
//  PopularCuisinesRecipesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 07/07/2024.
//

import UIKit
import Kingfisher

class PopularCuisinesRecipesCollectionViewCell: UICollectionViewCell {
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    private let titleRecipeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let authorLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let recipeStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withRecipe recipe: Recipe) {
        if let imageURL = URL(string: recipe.image ?? "") {
            recipeImageView.kf.setImage(with: imageURL)
        }
        titleRecipeLabel.text = recipe.title
        authorLabel.text = recipe.sourceName
    }
}

// MARK: - Private Methods

private extension PopularCuisinesRecipesCollectionViewCell {
    func setupUI() {
        addSubvieews()
        setConstarints()
    }
    
    func addSubvieews() {
        contentView.addSubview(recipeStackView)
        
        recipeStackView.addArrangedSubview(recipeImageView)
        recipeStackView.addArrangedSubview(titleRecipeLabel)
        recipeStackView.addArrangedSubview(authorLabel)
    }
    
    func setConstarints() {
        recipeStackView.snp.makeConstraints { make in
            make
                .top.leading.trailing
                .equalToSuperview()
        }
        
        recipeImageView.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
            make
                .height
                .equalTo(recipeImageView.snp.width)
        }
    }
}
