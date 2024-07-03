//
//  TitleForIngredientsTableView.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit
import SnapKit

final class TitleForIngredientsTableView: UIView {

    // MARK: - Properties
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 20)
        label.textColor = Resources.Colors.black
        label.text = "Ingredients"
        return label
    }()
    
    private let spacer: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private let numberOfItemsLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 14)
        label.textColor = Resources.Colors.darkGray
        label.text = "5 items"
        return label
    }()
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

// MARK: - Private Methods

private extension TitleForIngredientsTableView {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        addSubview(hStack)
        
        hStack.addArrangedSubview(ingredientsLabel)
        hStack.addArrangedSubview(spacer)
        hStack.addArrangedSubview(numberOfItemsLabel)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
