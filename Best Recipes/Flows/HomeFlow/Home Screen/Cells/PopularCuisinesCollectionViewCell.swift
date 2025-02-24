//
//  PopularCuisinesCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit

final class PopularCuisinesCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .white : .red
            contentView.backgroundColor = isSelected ? .red : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(titleCuisine title: String) {
        titleLabel.text = title.capitalized
    }
}

// MARK: - Private Methods

private extension PopularCuisinesCollectionViewCell {
    func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make
                .centerX.centerY
                .equalToSuperview()
        }
    }
}
