//
//  ProfileTableViewCell.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 11.07.20

import UIKit
import Kingfisher
import SnapKit


class ProfileTableViewCell: UITableViewCell {
    
    private let profileCellView = ProfileCellView()
    static let identifier = ProfileTableViewCell.description()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileCellView)
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        contentView.addSubview(profileCellView)
        
    }
    
    // MARK: - Configure Cell
    
    func configure(with recipe: RecipeModel) {
//        получаем изображение и преобразуем из url в image
        if let url = URL(string: recipe.image) {
            profileCellView.recipesImageView.kf.setImage(with: url)
        }
        
        profileCellView.descriptionLabel.text = recipe.title
        
        //        звезда из системного символа
        var raitingScore: String {
            let value = 5 * recipe.score / 100
            return String(format: "%0.1f", value)
        }
        profileCellView.raitingLabel.attributedText = charactersToString(character: "star.fill", text: " \(raitingScore)", size: 12)
    
        profileCellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
