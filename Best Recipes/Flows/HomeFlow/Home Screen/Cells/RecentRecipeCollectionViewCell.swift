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
        imageView.layer.cornerRadius = 10
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
    
    private let recipeInfoStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
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
        contentView.addSubview(recipeInfoStackView)
        
        recipeInfoStackView.addArrangedSubview(recipeImageView)
        recipeInfoStackView.addArrangedSubview(titleRecipeLabel)
        recipeInfoStackView.addArrangedSubview(authorNameLabel)
    }
    
    func setConstraints() {
        recipeInfoStackView.snp.makeConstraints { make in
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
