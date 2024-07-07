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

class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    private let imageView = ImagePickerView()
    
    private let recipeNameTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter recipe name"
        return textField
    }()
    
    private let servesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Serves: 3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private let cookTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cook time: 20 min", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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
    
    private let ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddIngredientCell.self, forCellReuseIdentifier: AddIngredientCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let disposeBag = DisposeBag()
    private var selectedButton: UIButton?
    
    
    private let viewModel: AddRecipeViewModel!

    init(viewModel: AddRecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        setupSubviews()
        setupConstraints()
        setupGesture()
        configurePickers()
    }
    
    private func setupSubviews() {
        view.addSubviews(titleLabel, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            imageView,
            recipeNameTF,
            servesButton,
            cookTimeButton,
            createRecipeButton,
            ingredientsTableView
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }

        recipeNameTF.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        servesButton.snp.makeConstraints { make in
            make.top.equalTo(recipeNameTF.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        cookTimeButton.snp.makeConstraints { make in
            make.top.equalTo(servesButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        createRecipeButton.snp.makeConstraints { make in
            make.top.equalTo(cookTimeButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(createRecipeButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
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

            })
            .disposed(by: disposeBag)
        
        cookTimeButton.rx.tap
            .subscribe(onNext: { [weak self] in

            })
            .disposed(by: disposeBag)
        
        createRecipeButton.rx.tap
            .bind { [weak self] in
                self?.showLoader()
                
                // Create the CreateRequest object
                let createRequest = CreateRequestDTO(
                    title: self?.recipeNameTF.text ?? "",
                    ingredients: "2 cups of green beans\n1 cup of olive oil",
                    instructions: "Cook the beans\nMix with oil",
                    readyInMinutes: 30,
                    servings: 4,
                    mask: "ellipseMask",
                    backgroundImage: "background1",
                    author: "John Doe",
                    backgroundColor: "#ffffff",
                    fontColor: "#333333",
                    source: "mywebsite.com",
                    image: self?.imageView.image
                )
                
                ApiService.create(createRequest).request(type: CreateResponse.self) { result in
                    DispatchQueue.main.async {
                        self?.hideLoader()
                        switch result {
                        case .success(let response):
                            if let url = URL(string: response.url) {
                                URLSession.shared.dataTask(with: url) { data, response, error in
                                    if let data = data, let image = UIImage(data: data) {
                                        DispatchQueue.main.async {
                                            let bottomSheetVC = AddRecipeBottomSheet()
                                            bottomSheetVC.image = image
                                            bottomSheetVC.modalPresentationStyle = .overFullScreen
                                            self?.present(bottomSheetVC, animated: true, completion: nil)
                                        }
                                    }
                                }.resume()
                            }
                        case .failure(let error):
                            self?.showErrorAlert(message: error.localizedDescription)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func configurePickers() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneButton], animated: false)
        
        recipeNameTF.inputAccessoryView = toolBar
    }
    
    @objc private func doneTapped() {
        recipeNameTF.resignFirstResponder()
    }
    
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Table View Data Source and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddIngredientCell.identifier, for: indexPath) as? AddIngredientCell else {
            return UITableViewCell()
        }
        
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.configure(with: ingredient)
        cell.minusButton.isHidden = (indexPath.row == viewModel.ingredients.count - 1)
        cell.plusButton.isHidden = (indexPath.row != viewModel.ingredients.count - 1)
        
        cell.minusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.removeIngredient(at: indexPath.row)
            })
            .disposed(by: cell.disposeBag)
        
        cell.plusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.addIngredient()
            })
            .disposed(by: cell.disposeBag)
        
        return cell
    }
    
    private func addIngredient() {
        viewModel.ingredients.append(("", ""))
        ingredientsTableView.reloadData()
    }
    
    private func removeIngredient(at index: Int) {
        viewModel.ingredients.remove(at: index)
        ingredientsTableView.reloadData()
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
