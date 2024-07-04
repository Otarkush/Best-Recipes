//
//  IngredientTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit
import SnapKit

final class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.backgroundGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = Resources.Colors.backgroundWhite
        return imageView
    }()
    
    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 14)
        label.textColor = Resources.Colors.black
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 16)
        label.textColor = Resources.Colors.darkGray
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Configuration
    
    func configure(with ingredient: Ingredient) {
        ingredientImageView.image = ingredient.image
        ingredientLabel.text = ingredient.name
        quantityLabel.text = "\(ingredient.quantity)g"
    }
}

// MARK: - Private Methods

private extension IngredientTableViewCell {
    func setupUI() {
        
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(ingredientImageView)
        containerView.addSubview(ingredientLabel)
        containerView.addSubview(quantityLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        ingredientImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.width.height.equalTo(52)
        }
        
        ingredientLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(ingredientImageView.snp.trailing).offset(16)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
