//
//  IngredientTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit
import SnapKit

final class IngredientTableViewCell: UITableViewCell {
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
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
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        //        stackView.backgroundColor = Resources.Colors.lightGray
        //        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(with ingredient: Ingredient) {
        ingredientImageView.image = ingredient.image
        ingredientLabel.text = ingredient.name
        quantityLabel.text = "\(ingredient.quantity)g"
    }
}

private extension IngredientTableViewCell {
    func setupUI() {
        
        backgroundColor = Resources.Colors.backgroundGray
        layer.cornerRadius = 10

        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(hStack)
        
        hStack.addArrangedSubview(ingredientImageView)
        hStack.addArrangedSubview(ingredientLabel)
        hStack.addArrangedSubview(quantityLabel)
        
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        ingredientImageView.snp.makeConstraints { make in
            make.width.height.equalTo(52)
        }
    }
    
    
}
