//
//  TrendsCollectionViewCell.swift
//  Best Recipes
//
//  Created by Иван Семикин on 03/07/2024.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxGesture
import RxRelay

final class TrendsCollectionViewCell: UICollectionViewCell {
    
    let onSave = PublishRelay<Void>()
    
    private let recipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    private let blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 10
        visualEffectView.clipsToBounds = true
        return visualEffectView
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "★"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let rateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let bookmarkView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        return view
    }()
    
    private let bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmarkIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private let authorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
     var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = .init()
        bookmarkView.tintColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(recipe: Recipe) {
        if let imageUrl = URL(string: recipe.image ?? "") {
            recipeImageView.kf.setImage(with: imageUrl)
            authorImageView.kf.setImage(with: imageUrl)
        }
        
        titleLabel.text = recipe.title?.capitalized
        authorNameLabel.text = "By \(recipe.sourceName ?? "")"
        rateLabel.text = "4,8"
    }
    
    private func setupBindings() {
        bookmarkView.rx
            .tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(onNext: { [unowned self] _ in
               onSave.accept(())
                bookmarkImageView.tintColor = bookmarkImageView.tintColor
                == .red
                ? .gray
                : .red
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Private Methods

private extension TrendsCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(recipeImageView)
        
        recipeImageView.addSubview(blurredBackgroundView)
        blurredBackgroundView.contentView.addSubview(starLabel)
        blurredBackgroundView.contentView.addSubview(rateLabel)
        
        contentView.addSubview(bookmarkView)
        bookmarkView.addSubview(bookmarkImageView)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(authorStackView)
        authorStackView.addArrangedSubview(authorImageView)
        authorStackView.addArrangedSubview(authorNameLabel)
    }
    
    func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make
                .top.leading.trailing
                .equalToSuperview()
            make
                .height
                .equalTo(200)
        }
        
        blurredBackgroundView.snp.makeConstraints { make in
            make
                .top.leading
                .equalToSuperview()
                .offset(10)
            make
                .height
                .equalTo(30)
            make
                .width
                .equalTo(60)
        }
        
        starLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .leading
                .equalTo(8)
        }
        
        rateLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .trailing
                .equalTo(-8)
        }
        
        bookmarkView.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(10)
            make
                .trailing
                .equalToSuperview()
                .offset(-10)
            make
                .height.width
                .equalTo(36)
        }
        
        bookmarkImageView.snp.makeConstraints { make in
            make
                .height.width
                .equalTo(20)
            make
                .centerX.centerY
                .equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make
                .top
                .equalTo(recipeImageView.snp.bottom)
                .offset(12)
            make
                .leading.trailing
                .equalToSuperview()
        }
        
        authorImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
        
        authorStackView.snp.makeConstraints { make in
            make
                .leading.trailing
                .equalToSuperview()
            make
                .top
                .equalTo(titleLabel.snp.bottom)
                .offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
