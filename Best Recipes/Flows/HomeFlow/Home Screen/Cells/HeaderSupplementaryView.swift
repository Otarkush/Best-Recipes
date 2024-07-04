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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
    private func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .leading
                .equalToSuperview()
                .offset(16)
        }
    }
}
