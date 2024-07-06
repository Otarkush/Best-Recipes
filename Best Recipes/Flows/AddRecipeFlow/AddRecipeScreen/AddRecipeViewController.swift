//
//  AddRecipeViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 05.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class AddRecipeViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create recipe"
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
        label.textAlignment = .center
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "hand.tap.fill")
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return imageView
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter recipe name"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Resources.Colors.redBorderTabBar.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private let servesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Serves", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Resources.Colors.backgroundGray
        button.setImage(UIImage(resource: .clock), for: .normal)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()

    private let cookTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cook time", for: .normal)
        button.setImage(UIImage(resource: .twoPerson), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Resources.Colors.backgroundGray
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()

    private let createRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create recipe", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Resources.Colors.red
        button.layer.cornerRadius = 10
        return button
    }()

    private let servesPicker = UIPickerView()
    private let cookTimePicker = UIPickerView()
    private let servesOptions = ["1", "2", "3", "4", "5"]
    private let cookTimeOptions = ["5 min", "10 min", "15 min", "20 min", "25 min", "30 min"]
    private var selectedButton: UIButton?

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()
        setupConstraints()
        setupGesture()
        configurePickers()
    }

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            titleLabel,
            imageView,
            nameTextField,
            servesButton,
            cookTimeButton,
            createRecipeButton
        )
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        servesButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        cookTimeButton.snp.makeConstraints { make in
            make.top.equalTo(servesButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        createRecipeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(cookTimeButton.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func setupGesture() {
        imageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.presentImagePicker()
            })
            .disposed(by: disposeBag)

        servesButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showPicker(for: self?.servesButton)
            })
            .disposed(by: disposeBag)

        cookTimeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showPicker(for: self?.cookTimeButton)
            })
            .disposed(by: disposeBag)
        
        createRecipeButton.rx.tap
            .bind { [weak self] in
                ApiService.create.request(type: RecipeResponse.self) { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            .disposed(by: disposeBag)
    }

    private func configurePickers() {
        servesPicker.delegate = self
        servesPicker.dataSource = self
        cookTimePicker.delegate = self
        cookTimePicker.dataSource = self

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneButton], animated: false)

        nameTextField.inputAccessoryView = toolBar
    }

    @objc private func doneTapped() {
        nameTextField.resignFirstResponder()
    }

    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    private func showPicker(for button: UIButton?) {
        selectedButton = button
        if button == servesButton {
            nameTextField.inputView = servesPicker
        } else if button == cookTimeButton {
            nameTextField.inputView = cookTimePicker
        }
        nameTextField.becomeFirstResponder()
    }
}

// MARK: - Image Picker Delegate
extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Picker View Delegate and Data Source
extension AddRecipeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == servesPicker {
            return servesOptions.count
        } else {
            return cookTimeOptions.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == servesPicker {
            return servesOptions[row]
        } else {
            return cookTimeOptions[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == servesPicker {
            selectedButton?.setTitle("Serves: \(servesOptions[row])", for: .normal)
        } else if pickerView == cookTimePicker {
            selectedButton?.setTitle("Cook time: \(cookTimeOptions[row])", for: .normal)
        }
    }
}
