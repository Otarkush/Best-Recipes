//
//  PopularCategoryTitleCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 06/07/2024.
//

import UIKit

final class PopularCategoryTitleCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(titleCtegory title: String) {
        titleLabel.text = title.capitalized
    }
}

// MARK: - Private Methods

private extension PopularCategoryTitleCollectionViewCell {
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
                .centerY
                .equalToSuperview()
            make
                .leading
                .equalToSuperview()
                .inset(12)
            make
                .trailing
                .equalToSuperview()
                .inset(-16)
        }
    }
}
