//
//  ImagePickerVIew.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import RxGesture

import RxSwift
import RxCocoa

class ImagePickerView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Resources.Colors.lightGray.cgColor
        return imageView
    }()

    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "edit")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()

    let imageRelay = BehaviorRelay<UIImage?>(value: nil)

    var image: UIImage? {
        get {
            return imageRelay.value
        }
        set {
            imageRelay.accept(newValue)
            imageView.image = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(imageView)
        imageView.addSubview(editImageView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        editImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(60)
        }
    }
}
