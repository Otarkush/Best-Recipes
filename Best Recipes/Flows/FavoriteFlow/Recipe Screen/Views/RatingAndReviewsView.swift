//
//  RatingAndReviewsView.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit

final class RatingAndReviewsView: UIView {
    
    // MARK: - Properties
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 14)
        label.textColor = Resources.Colors.black
        label.text = "★ 4,5"
        return label
    }()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 14)
        label.textColor = Resources.Colors.darkGray
        label.text = "(300 Reviews)"
        return label
    }()
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
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
    
    func configure(with recipe: Recipe) {
        let rating = 5 * (recipe.spoonacularScore ?? 0) / 100
        ratingLabel.text = "★ \(String(format: "%.1f", rating))"
        
        reviewsLabel.text = "(\(recipe.aggregateLikes ?? 0) Reviews)"
    }
}

// MARK: - Private Methods

private extension RatingAndReviewsView {
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        hStack.addArrangedSubview(ratingLabel)
        hStack.addArrangedSubview(reviewsLabel)
        
        addSubview(hStack)
    }
    
    func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    
}
