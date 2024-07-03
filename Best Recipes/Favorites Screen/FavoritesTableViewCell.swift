//
//  FavoritesTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = FavoritesTableViewCell.description()
    
    private lazy var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conteinerView: UIView = {
        let viewConteiner = UIView()
        
        viewConteiner.backgroundColor = .red
        
        viewConteiner.translatesAutoresizingMaskIntoConstraints = false
        return viewConteiner
    }()
    
    private lazy var cuisineImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cuisineLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        [
            recipesImageView,
            descriptionLabel,
            conteinerView
        ].forEach{ contentView.addSubview($0)}
        
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipesImageView.image = nil
        descriptionLabel.text = nil
        cuisineImageView.image = nil
        cuisineLabel.text = nil
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recipesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            recipesImageView.heightAnchor.constraint(equalToConstant: 180),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: recipesImageView.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            conteinerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
