//
//  FavoritesTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit
import SnapKit

final class ProfileRecipeCell: UITableViewCell {
    
    static let identifier = ProfileRecipeCell.description()
    
    // MARK: - Property Cell
    
    private lazy var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addBookmark), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 14)
        label.textColor = Resources.Colors.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
//    кухня
    private lazy var conteinerView: UIView = {
        let viewConteiner = UIView()
        viewConteiner.translatesAutoresizingMaskIntoConstraints = false
        return viewConteiner
    }()
    
    private lazy var cuisineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cuisineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Resources.Fonts.poppinsRegular(of: 14)
        label.textColor = Resources.Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        [
            recipesImageView,
            descriptionLabel,
            bookmarkButton,
            conteinerView
        ]
            .forEach { contentView.addSubview($0) }
        //        картинка кухни и подпись под изображением
        conteinerView.addSubview(cuisineImageView)
        conteinerView.addSubview(cuisineLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        
        if let imageUrlString = recipe.image, let url = URL(string: imageUrlString) {
            recipesImageView.kf.setImage(with: url)
        } else {
            recipesImageView.image = UIImage(named: "placeholder_image")
        }
        
        descriptionLabel.text = recipe.title
        
        cuisineImageView.image = UIImage(named: "cuisine")
        
        if !recipe.cuisines.isEmpty {
            cuisineLabel.text = recipe.cuisines[0]
        } else {
            cuisineLabel.text = "World cuisine"
        }
    }
    
    @objc private func addBookmark() {
        print("Add or Remove from bookmarsks")
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        //            image
        recipesImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(10)
            make.height.equalTo(180)
        }
        //            название рецепта
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(recipesImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        //            bookmark
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalTo(recipesImageView).offset(8)
            make.trailing.equalTo(recipesImageView).offset(-8)
        }
        //            контейнер кухня + текста
        conteinerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        cuisineImageView.snp.makeConstraints { make in
            make.top.equalTo(conteinerView).offset(10)
            make.leading.equalTo(conteinerView)
            make.bottom.equalTo(conteinerView).offset(-10)
            make.size.equalTo(32)
        }
        
        cuisineLabel.snp.makeConstraints { make in
            make.leading.equalTo(cuisineImageView.snp.trailing).offset(4)
            make.trailing.equalTo(conteinerView.snp.trailing).offset(-10)
            make.centerY.equalTo(conteinerView)
        }
    }
}
