//
//  PopularCategoryTitleCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 06/07/2024.
//

import UIKit

final class PopularCategoryCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .red : .clear
            titleLabel.textColor = isSelected ? .white : .red
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(titleCategory title: String) {
        titleLabel.text = title.capitalized
    }
}

// MARK: - Private Methods

private extension PopularCategoryCollectionViewCell {
    func setupUI() {
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
