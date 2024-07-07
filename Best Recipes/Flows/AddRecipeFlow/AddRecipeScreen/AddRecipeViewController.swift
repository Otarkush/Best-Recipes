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
    
    enum Section {
        case main
    }
    
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
        textField.placeholder = "Enter recipe name"
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = Resources.Colors.red.cgColor
        textField.layer.borderWidth = 1
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let servesPicker = PickerView(type: .serves)
    private let timePicker = PickerView(type: .cookTime)
    
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
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    private var dataSource: UITableViewDiffableDataSource<Section, ExtendedIngredient>!
    
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
        
        dataSource = UITableViewDiffableDataSource<Section, ExtendedIngredient>(tableView: ingredientsTableView) { tableView, indexPath, ingredient in
            let cell = tableView.dequeueReusableCell(withIdentifier: AddIngredientCell.identifier, for: indexPath) as! AddIngredientCell
            let isLast = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
            cell.configure(with: isLast)
            
            cell.button.rx.tap
                .bind(onNext: { [weak self] in
                    isLast ? self?.addIngredient() : self?.removeIngredient()
                })
                .disposed(by: cell.disposeBag)
            
            return cell
        }

        updateData()
        
        setupSubviews()
        setupConstraints()
        setupBindings()
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ExtendedIngredient>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.ingredients)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func addIngredient() {
        let newIngredient = ExtendedIngredient(id: UUID().hashValue, aisle: "", image: "", consistency: "", name: "", nameClean: "", original: "", originalName: "", amount: nil, unit: "", meta: [], measures: .init(us: .init(amount: nil, unitShort: "", unitLong: ""), metric: nil))
        viewModel.ingredients.append(newIngredient)
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([newIngredient])
        dataSource.apply(snapshot, animatingDifferences: true)
        ingredientsTableView.reloadData()
    }

    private func removeIngredient() {
        if let lastIngredient = viewModel.ingredients.last {
            viewModel.ingredients.removeLast()
            var snapshot = dataSource.snapshot()
            snapshot.deleteItems([lastIngredient])
            dataSource.apply(snapshot, animatingDifferences: true)
        }
        ingredientsTableView.reloadData()
    }
    
    private func setupSubviews() {
        view.addSubviews(titleLabel, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            imageView,
            recipeNameTF,
            servesPicker,
            timePicker,
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
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView).inset(50)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        recipeNameTF.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        servesPicker.snp.makeConstraints { make in
            make.top.equalTo(recipeNameTF.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(servesPicker.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(createRecipeButton.snp.top).inset(-10)
        }
        
        createRecipeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
    }
    
    private func setupBindings() {
        
        
        imageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.presentImagePicker()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(recipeNameTF.rx.text.orEmpty, imageView.imageRelay.asObservable())
            .map { recipeName, image in
                return !recipeName.isEmpty && image != nil
            }
            .bind(onNext: { [weak self] isEnabled in
                self?.createRecipeButton.isEnabled = isEnabled
                self?.createRecipeButton.backgroundColor = isEnabled ? Resources.Colors.red : Resources.Colors.lightGray
            })
            .disposed(by: disposeBag)
        
        createRecipeButton.rx.tap
            .bind { [weak self] in
                self?.showLoader()
                let createRequest = CreateRequestDTO(
                    title: self?.recipeNameTF.text ?? "asdad",
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
                                }
                                .resume()
                            }
                        case .failure(let error):
                            self?.showErrorAlert(message: error.localizedDescription)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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
