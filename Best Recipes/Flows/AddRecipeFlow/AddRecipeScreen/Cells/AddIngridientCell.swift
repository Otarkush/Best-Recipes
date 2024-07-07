//
//  AddIngridientCell.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import UIKit
import RxSwift

class AddIngredientCell: UITableViewCell {
    
    static let identifier = "IngredientCell"
    
    let ingredientNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ingredient"
        return textField
    }()
    
    let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Quantity"
        return textField
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
        
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with ingredient: (name: String, quantity: String)) {
        ingredientNameTextField.text = ingredient.name
        quantityTextField.text = ingredient.quantity
    }
}

private extension AddIngredientCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubviews(
            ingredientNameTextField,
            quantityTextField,
            minusButton,
            plusButton
        )
    }

    private func setupConstraints() {
        ingredientNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        
        quantityTextField.snp.makeConstraints { make in
            make.leading.equalTo(ingredientNameTextField.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        
        minusButton.snp.makeConstraints { make in
            make.leading.equalTo(quantityTextField.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalTo(minusButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
