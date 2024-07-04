//
//  TrendsCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendsCollectionViewCell: UICollectionViewCell {
    
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        
    }()
    
    private let authorImageView: UIImageView = {
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(recipeImageView)
    }
    
    func configureCell(imageName: String) {
        recipeImageView.image = UIImage(named: imageName)
    }
    
    func setConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make
                .edges.equalToSuperview()
        }
    }
}
