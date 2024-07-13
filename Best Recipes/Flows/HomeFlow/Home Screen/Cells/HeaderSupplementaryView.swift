//
//  HeaderSupplementaryView.swift
//  Best Recipes
//
//  Created by Иван Семикин on 04/07/2024.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxGesture

final class HeaderSupplementaryView: UICollectionReusableView {
    
    var onSeeAll = PublishRelay<Void>()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let headerSeeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .right
        button.semanticContentAttribute = .forceRightToLeft
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        let image = UIImage(systemName: "arrow.right", withConfiguration: imageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.imagePadding = 10
        button.configuration = buttonConfig
        
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBidings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = .init()
        setupBidings()
    }
    
    func configureHeader(titleSection title: String, isButtonVisible: Bool) {
        headerLabel.text = title
        headerSeeAllButton.isHidden = !isButtonVisible
    }
    
    private func setupBidings() {
        headerSeeAllButton.rx.tap
            .bind(to: onSeeAll)
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

extension HeaderSupplementaryView {
    func setupUI() {
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        addSubview(headerLabel)
        addSubview(headerSeeAllButton)
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make
                .centerY
                .equalToSuperview()
            make
                .leading
                .equalToSuperview()
        }
        
        headerSeeAllButton.snp.makeConstraints { make in
            make
                .centerY
                .equalTo(headerLabel.snp.centerY)
            make
                .trailing
                .equalToSuperview()
                .offset(10)
        }
    }
}
