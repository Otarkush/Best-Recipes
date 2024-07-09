//
//  RecipeView.swift
//  Best Recipes
//
//  Created by Alexander on 1.07.24.
//

import UIKit
import SnapKit

final class RecipeView: UIScrollView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 24)
        label.textColor = Resources.Colors.black
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        return imageView
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 20)
        label.textColor = Resources.Colors.black
        label.text = "Instructions"
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "IngredientCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let ratingAndReviews = RatingAndReviewsView()
    private let instructionsView = InstructionsView()
    private let titleForTable = TitleForIngredientsTableView()
    private let contentView = UIView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.title
        
//        if let image = recipe.image {
//            imageView
//        }
    }
}

// MARK: - Private Methods

private extension RecipeView {
    
    func setupUI() {
        backgroundColor = .white
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = true
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        
        addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(ratingAndReviews)
        contentView.addSubview(instructionLabel)
        contentView.addSubview(instructionsView)
        contentView.addSubview(titleForTable)
        contentView.addSubview(tableView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(57)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(223)
        }
        
        ratingAndReviews.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingAndReviews.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            
        }
        
        instructionsView.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        titleForTable.snp.makeConstraints { make in
            make.top.equalTo(instructionsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleForTable.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100 * 5)
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(tableView.snp.bottom).offset(20)
        }
    }
}
