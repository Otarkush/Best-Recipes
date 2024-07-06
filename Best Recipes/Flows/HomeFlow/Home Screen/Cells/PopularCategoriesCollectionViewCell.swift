//
//  PopularCategoriesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit
import SnapKit
import Kingfisher

final class PopularCategoriesCollectionViewCell: UICollectionViewCell {
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
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
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "Time"
        return label
    }()
    
    private let timeOfRecipeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let timeStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()
    
    private let bookmarkView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmarkIcon")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(recipe: Recipe) {
        if let imageURL = URL(string: recipe.image ?? "") {
            recipeImageView.kf.setImage(with: imageURL)
        }
        titleRecipeLabel.text = recipe.title
        timeOfRecipeLabel.text = "5 mins"
    }
    
}

// MARK: - Private Methods

private extension PopularCategoriesCollectionViewCell {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(backView)
        contentView.addSubview(recipeImageView)
        
        backView.addSubview(timeStackView)
        backView.addSubview(titleRecipeLabel)
        backView.addSubview(bookmarkView)
        bookmarkView.addSubview(bookmarkImageView)
        
        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(timeOfRecipeLabel)
    }
    
    func setConstraints() {
        backView.snp.makeConstraints { make in
            make
                .bottom.leading.trailing
                .equalToSuperview()
            make
                .height
                .equalTo(170)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make
                .height.width
                .equalTo(120)
            make
                .bottom
                .equalTo(backView.snp.top)
                .offset(50)
            make
                .centerX
                .equalToSuperview()
        }
        
        titleRecipeLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .leading.trailing
                .equalToSuperview()
                .inset(16)
        }
        
        timeStackView.snp.makeConstraints { make in
            make
                .bottom
                .equalToSuperview()
        }
        
        bookmarkView.snp.makeConstraints { make in
            make
                .trailing.bottom
                .equalToSuperview()
                .offset(-10)
            make
                .height.width
                .equalTo(24)
        }
        
        bookmarkImageView.snp.makeConstraints { make in
            make
                .height.width
                .equalTo(14)
            make
                .centerX.centerY
                .equalToSuperview()
        }
    }
}
