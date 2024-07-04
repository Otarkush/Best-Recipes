//
//  TrendsCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendsCollectionViewCell: UICollectionViewCell {
    
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private let authorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .leading
        return stack
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
            authorImageView.kf.setImage(with: imageUrl)
        }
        
        titleLabel.text = recipe.title?.capitalized
        authorNameLabel.text = recipe.sourceName ?? ""
    }
}

private extension TrendsCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        authorStackView.addArrangedSubview(authorImageView)
        authorStackView.addArrangedSubview(authorNameLabel)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorStackView)
    }
    
    func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make
                .top.leading.trailing
                .equalToSuperview()
            make
                .height
                .equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(recipeImageView.snp.bottom)
                .offset(12)
            make
                .leading.trailing
                .equalToSuperview()
        }
        
        authorImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
        
        authorStackView.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
            make
                .top
                .equalTo(titleLabel.snp.bottom)
                .offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
