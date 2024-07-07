//
//  PickerView.swift
//  Best Recipes
//
//  Created by dsm 5e on 07.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    var selectedValue = BehaviorRelay<Int?>(value: nil)
    
    enum PickerType: String {
        case serves
        case cookTime
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let selectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Resources.Colors.lightGray
        return label
    }()
    
    private let arrowButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .arrowRight)
        return imageView
    }()
    
    let picker = UIPickerView()
    private var data: [String] = []
    private var type: PickerType

    init(type: PickerType) {
        self.type = type
        super.init(frame: .zero)
        picker.delegate = self
        setupView()
        switch type {
        case .serves:
            imageView.image = UIImage(resource: .twoPerson)
            titleLabel.text = type.rawValue.capitalized
        case .cookTime:
            imageView.image = UIImage(resource: .clock)
            titleLabel.text = type.rawValue.capitalized
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = Resources.Colors.lightGray.withAlphaComponent(0.2)
        layer.cornerRadius = 20
        addSubviews(
            imageView,
            titleLabel,
            selectLabel,
            arrowButton
        )

        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        selectLabel.snp.makeConstraints { make in
            make.trailing.equalTo(arrowButton.snp.leading).inset(-10)
            make.centerY.equalTo(arrowButton)
        }

        arrowButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(20)
        }
        // Setup tap gesture to show picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPicker))
        addGestureRecognizer(tapGesture)
    }

    @objc private func showPicker() {
        switch type {
        case .serves:
            data = ["1", "2", "3", "4", "5"]
        case .cookTime:
            data = ["10", "20", "30", "40", "50"]
        }

        let alert = UIAlertController(title: "Select", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.view.addSubview(picker)
        picker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        if let parentVC = self.parentViewController {
            parentVC.present(alert, animated: true, completion: nil)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch type {
        case .serves:
            selectLabel.text = data[row]
        case .cookTime:
            selectLabel.text = data[row] + " min"
        }
        selectedValue.accept(Int(data[row]))
    }
}
