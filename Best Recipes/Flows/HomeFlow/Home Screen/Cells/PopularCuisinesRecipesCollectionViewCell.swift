//
//  PopularCuisinesRecipesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 07/07/2024.
//

import UIKit
import Kingfisher

final class PopularCuisinesRecipesCollectionViewCell: UICollectionViewCell {
    private let backView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleRecipeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let authorLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = contentView.frame.width / 2
        recipeImageView.layer.cornerRadius = (contentView.frame.width - 32) / 2
    }
    
    func configure(withRecipe recipe: Recipe) {
        if let imageURL = URL(string: recipe.image ?? "") {
            recipeImageView.kf.setImage(with: imageURL)
        }
        titleRecipeLabel.text = recipe.title
        authorLabel.text = "By \(recipe.sourceName ?? "")"
    }
}

// MARK: - Private Methods

private extension PopularCuisinesRecipesCollectionViewCell {
    func setupUI() {
        addSubvieews()
        setConstarints()
    }
    
    func addSubvieews() {
        contentView.addSubview(backView)
        contentView.addSubview(circleView)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleRecipeLabel)
        contentView.addSubview(authorLabel)
    }
    
    func setConstarints() {
        backView.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(50)
            make
                .leading.trailing.bottom
                .equalToSuperview()
        }
        
        circleView.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
            make
                .top
                .equalToSuperview()
            make
                .height
                .equalTo(circleView.snp.width)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make
                .top.leading
                .equalToSuperview()
                .inset(16)
            make
                .trailing
                .equalToSuperview()
                .offset(-16)
            make
                .height
                .equalTo(recipeImageView.snp.width)
        }
        
        authorLabel.snp.makeConstraints { make in
            make
                .leading
                .equalToSuperview()
                .inset(16)
            make
                .trailing.bottom
                .equalToSuperview()
                .offset(-16)
        }
        
        titleRecipeLabel.snp.makeConstraints { make in
            make
                .leading
                .equalToSuperview()
                .inset(16)
            make
                .trailing
                .equalToSuperview()
                .offset(-16)
            make
                .bottom
                .equalTo(authorLabel.snp.top)
                .offset(-16)
        }
    }
}
