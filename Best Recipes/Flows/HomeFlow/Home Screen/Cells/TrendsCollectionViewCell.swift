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
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let recipeRateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .black
        stackView.alpha = 0.4
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let rateImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let bookmarkView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    private let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmarkIcon")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
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
        stack.alignment = .center
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
        authorNameLabel.text = "By \(recipe.sourceName ?? "")"
        rateLabel.text = "4,8"
    }
}

// MARK: - Private Methods

private extension TrendsCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(recipeImageView)
        
        recipeImageView.addSubview(recipeRateStackView)
        recipeRateStackView.addArrangedSubview(rateImageView)
        recipeRateStackView.addArrangedSubview(rateLabel)
        
        recipeImageView.addSubview(bookmarkView)
        bookmarkView.addSubview(bookmarkImageView)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(authorStackView)
        authorStackView.addArrangedSubview(authorImageView)
        authorStackView.addArrangedSubview(authorNameLabel)
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
        
        recipeRateStackView.snp.makeConstraints { make in
            make
                .top.leading
                .equalToSuperview()
                .offset(10)
            make
                .height
                .equalTo(28)
            make
                .width
                .equalTo(64)
        }
        
        rateImageView.snp.makeConstraints { make in
            make
                .height.width
                .equalTo(15)
        }
        
        bookmarkView.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(10)
            make
                .trailing
                .equalToSuperview()
                .offset(-10)
            make
                .height.width
                .equalTo(36)
        }
        
        bookmarkImageView.snp.makeConstraints { make in
            make
                .height.width
                .equalTo(20)
            make
                .centerX.centerY
                .equalToSuperview()
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
