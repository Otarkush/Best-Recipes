//
//  RecipeTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander on 10.07.24.
//

import UIKit
import Kingfisher

final class RecipeTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let gradientContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let ratingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.7)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.white
        label.font = Resources.Fonts.poppinsBold(of: 14)
        return label
    }()
    
    private let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 16)
        label.textColor = Resources.Colors.white
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientsAndTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 12)
        label.textColor = Resources.Colors.white
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
    
    //MARK: - Public methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupGradientLayer()
    }
    
    func configure() {
        recipeImageView.image = UIImage(named: "image 15")
        ratingLabel.attributedText = charactersToString(character: "star.fill", text: " 5,0", size: 14)
        recipeNameLabel.text = "How to make yam & vegetable sauce at home"
        ingredientsAndTimeLabel.text = "9 Ingredients | 25 min"
    }
}

//MARK: - Setup UI

private extension RecipeTableViewCell {
    func setupUI() {
        selectionStyle = .none
        
        addViews()
        setupConstraints()
        configure()
        setupGradientLayer()
    }
    
    func addViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(separatorView)
        
        recipeImageView.addSubview(gradientContainer)
        recipeImageView.addSubview(ratingContainer)
        ratingContainer.addSubview(ratingLabel)
        recipeImageView.addSubview(recipeNameLabel)
        recipeImageView.addSubview(ingredientsAndTimeLabel)
        
    }
    
    func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(recipeImageView.snp.bottom)
            make.height.equalTo(24)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        gradientContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(recipeImageView)
            make.height.equalTo(recipeImageView.snp.height).multipliedBy(0.5)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        ratingContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        recipeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(114)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        ingredientsAndTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(recipeNameLabel)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradientContainer.bounds
        gradientContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        gradientContainer.layer.insertSublayer(gradientLayer, at: 0)
    }
}
