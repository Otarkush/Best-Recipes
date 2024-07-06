//
//  HeaderSupplementaryView.swift
//  Best Recipes
//
//  Created by Иван Семикин on 04/07/2024.
//

import Foundation
import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let headerSeeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .right
        button.semanticContentAttribute = .forceRightToLeft
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        let image = UIImage(systemName: "arrow.right", withConfiguration: imageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.imagePadding = 10
        button.configuration = buttonConfig
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(titleSection title: String, isButtonVisible: Bool) {
        headerLabel.text = title
        if !isButtonVisible {
            headerSeeAllButton.isHidden = true
        }
    }
    
}

// MARK: - Private Methods

extension HeaderSupplementaryView {
    func setupUI() {
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        addSubview(headerLabel)
        addSubview(headerSeeAllButton)
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .leading
                .equalToSuperview()
        }
        
        headerSeeAllButton.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .trailing
                .equalToSuperview()
                .offset(10)
        }
    }
}
