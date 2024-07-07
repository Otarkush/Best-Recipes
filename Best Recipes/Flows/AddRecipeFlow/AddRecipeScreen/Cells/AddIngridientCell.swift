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
        textField.placeholder = "Ingredient"
        textField.layer.borderColor = Resources.Colors.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Quantity"
        textField.layer.borderColor = Resources.Colors.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
        
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(Resources.Colors.lightGray, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Resources.Colors.lightGray.cgColor
        return button
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
        
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = .init()
    }
    
    func configure(with isLast: Bool) {
        button.setTitle(isLast ? "+" : "-", for: .normal)
    }
}

private extension AddIngredientCell {
    private func setupUI() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentStack.addArrangedSubviews(
            ingredientNameTextField,
            quantityTextField
        )
        contentView.addSubviews(
            contentStack,
            button
        )
    }
    
    private func setupConstraints() {
        contentStack.snp.makeConstraints { make in
            make
                .top
                .leading
                .equalToSuperview()
            make
                .trailing.equalTo(button.snp.leading)
                .offset(-10)
            make
                .bottom
                .equalToSuperview()
                .inset(20)
            make
                .height
                .equalTo(44)
        }
        
        button.snp.makeConstraints { make in
            make
                .trailing
                .equalToSuperview()
            make
                .centerY
                .equalTo(ingredientNameTextField)
            make
                .size
                .equalTo(30)
        }
    }
}
