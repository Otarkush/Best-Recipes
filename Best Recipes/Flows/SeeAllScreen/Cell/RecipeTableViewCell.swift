//
//  RecipeTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander on 5.07.24.
//

import UIKit
import SnapKit

final class RecipeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let containerView = UIView()
    private let separatorView = UIView()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "image")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 16)
        label.textColor = Resources.Colors.black
        label.text = "How to make sharwama at home"
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "image")
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 12)
        label.textColor = Resources.Colors.darkGray
        label.text = "By Zeelicious Foods"
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
    }
}

//MARK: - Private Methods

private extension RecipeTableViewCell {
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(separatorView)
        
        containerView.addSubview(recipeImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorImageView)
        containerView.addSubview(authorNameLabel)

    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-78)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(recipeImageView)
        }
        
        authorImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(recipeImageView)
            make.width.height.equalTo(32)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(authorImageView)
            make.leading.equalTo(authorImageView.snp.trailing).offset(7)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom)
            make.height.equalTo(24)
        }
    }
}
