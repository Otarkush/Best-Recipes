//
//  FavoritesTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = FavoritesTableViewCell.description()
    
    // MARK: - Property Cell
    
    private lazy var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    райтинг
    private lazy var raitingContainer: UIView = {
        let viewConteiner = UIView()
        viewConteiner.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.7)
        viewConteiner.layer.cornerRadius = 8
        viewConteiner.translatesAutoresizingMaskIntoConstraints = false
        return viewConteiner
    }()
    
    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
            raitingContainer,
            conteinerView
        ].forEach{ contentView.addSubview($0)}
        
//        рейтинг рецепта
        raitingContainer.addSubview(raitingLabel)
        
        //        картинка кухни и подпись под изображением
        conteinerView.addSubview(cuisineImageView)
        conteinerView.addSubview(cuisineLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        
        recipesImageView.image = UIImage(named: recipe.image)
        descriptionLabel.text = recipe.title
        
        cuisineImageView.image = UIImage(named: recipe.imageCuisine)
        cuisineLabel.text = recipe.cuisine
        
//        звезда из системного символа
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")
        attachment.bounds = CGRect(x: 0, y: 0, width: 14, height: 14)
        let attachmentString = NSAttributedString(attachment: attachment)
        let complexText = NSMutableAttributedString(string: "")
        complexText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " \(recipe.raiting)")
        complexText.append(textAfterIcon)
        raitingLabel.attributedText = complexText
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            image
            recipesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            recipesImageView.heightAnchor.constraint(equalToConstant: 180),

//            название рецепта
            descriptionLabel.topAnchor.constraint(equalTo: recipesImageView.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
//            bookmark
            bookmarkButton.topAnchor.constraint(equalTo: recipesImageView.topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: recipesImageView.trailingAnchor, constant: -8),
            
//            райтинг рецепта
            raitingContainer.topAnchor.constraint(equalTo: recipesImageView.topAnchor, constant: 8),
            raitingContainer.leadingAnchor.constraint(equalTo: recipesImageView.leadingAnchor, constant: 8),
            raitingContainer.widthAnchor.constraint(equalToConstant: 58),
            raitingContainer.heightAnchor.constraint(equalToConstant: 28),
            
            raitingLabel.centerYAnchor.constraint(equalTo: raitingContainer.centerYAnchor),
            raitingLabel.centerXAnchor.constraint(equalTo: raitingContainer.centerXAnchor),
            
            
//            контейнер кухня + текста
            conteinerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            cuisineImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            cuisineImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            cuisineImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -10),
            cuisineImageView.heightAnchor.constraint(equalToConstant: 32),
            
            cuisineLabel.leadingAnchor.constraint(equalTo: cuisineImageView.trailingAnchor, constant: 10),
            cuisineLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -10),
            cuisineLabel.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor)
        ])
    }
}
