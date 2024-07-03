//
//  PlusButton.swift
//  Best Recipes
//
//  Created by dsm 5e on 03.07.2024.
//

import UIKit

final class PlusButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tintColor = .white
        backgroundColor = .red
        setImage(UIImage(systemName: "plus"), for: .normal)
    }
}
