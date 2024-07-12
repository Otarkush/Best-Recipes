//
//  ProfileCellView.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 11.07.2024.
//

import UIKit
import SnapKit

final class ProfileCellView: UIView {
    // MARK: - Properties
    
     lazy var recipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsBold(of: 14)
        label.textColor = Resources.Colors.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var cookingLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.poppinsRegular(of: 10)
        label.textColor = Resources.Colors.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var raitingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.7)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     lazy var raitingLabel: UILabel = {
       let label = UILabel()
        label.textColor = Resources.Colors.white
        label.font = Resources.Fonts.poppinsRegular(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setView()
        setConstraints()
    }
    
    // MARK: - Setting UI
    
    private func setView() {
        backgroundColor = .clear
        
        [
        recipesImageView,
        descriptionLabel,
        cookingLabel,
        raitingContainer
        ].forEach { addSubviews($0) }
        
        raitingContainer.addSubview(cookingLabel)
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        recipesImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(180)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recipesImageView).offset(-50)
            make.leading.trailing.equalTo(recipesImageView).inset(10)
        }
        
//        описание время и ингридиенты
        
        raitingContainer.snp.makeConstraints { make in
            make.top.equalTo(recipesImageView).offset(8)
            make.leading.equalTo(recipesImageView).offset(8)
            make.width.equalTo(58)
            make.height.equalTo(28)
        }
        
        raitingLabel.snp.makeConstraints { make in
            make.center.equalTo(raitingContainer)
        }
    }
    
}
