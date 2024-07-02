//
//  FavoritesTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = FavoritesTableViewCell.debugDescription()
    
    private lazy var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        
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
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conteinerView: UIView = {
        let viewConteiner = UIView()
        
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
        
        conteinerView.addSubview(cuisineImageView)
        conteinerView.addSubview(cuisineLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        recipesImageView.image = UIImage(named: recipe.image)
        descriptionLabel.text = recipe.title
    }
}
