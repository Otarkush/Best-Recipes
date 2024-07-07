//
//  AddRecipeBottomSheet.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import UIKit
import RxSwift
import SnapKit

class AddRecipeBottomSheet: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let disposeBag = DisposeBag()
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupSubviews()
        setupConstraints()
        setupGesture()
        imageView.image = image
    }

    private func setupSubviews() {
        view.addSubviews(imageView, closeButton)
    }

    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func setupGesture() {
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
