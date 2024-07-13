//
//  HomeViewController.swift
//  Best Recipes
//
//  Created by Иван Семикин on 30.06.2024.
//

import UIKit
import RxSwift
import RxRelay
import RxGesture

final class HomeViewController: UIViewController {
    
    var onDetail = PublishRelay<Int>()
    var onSeeAll = PublishRelay<[Recipe]>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.font = .systemFont(ofSize: 28,weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let searchBar: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search recipes"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray.withAlphaComponent(0.2)
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return button
    }()

    weak var coordinator: HomeCoordinator!
    
    init(coordinator: HomeCoordinator!) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var sections: [ListSection] = []
    private var searchResult = PublishRelay<[ComplexSearchResult]>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rightView = clearButton
        searchBar.rightViewMode = .whileEditing

        addDataToSections()
        setupUI()
        setupBindings()
    }
    
    @objc private func clearTapped() {
        searchBar.text = ""
        searchResult.accept([])
        searchBar.resignFirstResponder()
        tableView.isHidden = true
        collectionView.isHidden = false
    }

    private func setupBindings() {
        view.rx.tapGesture()
            .map { _ in }
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                collectionView.isHidden = true
                self.tableView.isHidden = false
                self.showLoader()
                ApiService.search(query).request(type: ComplexSearchResponse.self) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            print(success)
                            if let result = success.results {
                                self.searchResult.accept(result)
                            }
                        case .failure(let failure):
                            print(failure)
                            self.showErrorAlert(message: failure.localizedDescription)
                        }
                        self.hideLoader()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        searchResult
            .bind(to: tableView.rx.items(cellIdentifier: SearchCell.identifier, cellType: SearchCell.self)) { row, recipe, cell in
                cell.configure(with: recipe)
                cell.onDetail
                    .bind(onNext: { [weak self] _ in
                        self?.onDetail.accept(recipe.id)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)

    }
    
}

// MARK: - Private Methods

private extension HomeViewController {
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        
        setDelegates()
        addSubviews()
        registerCollectionViewCells()
        setConstraints()
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func registerCollectionViewCells() {
        collectionView.register(
            TrendsCollectionViewCell.self,
            forCellWithReuseIdentifier: "TrendsCollectionViewCell")
        collectionView.register(
            PopularCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCategoryViewCell")
        collectionView.register(
            PopularCategoriesRecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCategoryRecipesViewCell")
        collectionView.register(
            RecentRecipeCollectionViewCell.self,
            forCellWithReuseIdentifier: "RecentRecipeCollectionViewCell")
        collectionView.register(
            PopularCuisinesCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCuisineCollectionView")
        collectionView.register(
            PopularCuisinesRecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCuisineRecipesCollectionView"
        )
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderSupplementaryView"
        )
        collectionView.collectionViewLayout = createLayout()
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
                .offset(64)
            make
                .leading
                .trailing
                .equalToSuperview()
                .inset(16)
            make
                .height
                .equalTo(78)
        }
        
        searchBar.snp.makeConstraints { make in
            make
                .top
                .equalTo(titleLabel.snp.bottom)
                .offset(16)
            make
                .leading
                .equalToSuperview()
                .offset(16)
            make
                .trailing
                .equalToSuperview()
                .offset(-16)
            make
                .height
                .equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make
                .top
                .equalTo(searchBar.snp.bottom)
            make
                .leading
                .equalToSuperview()
                .offset(16)
            make
                .trailing
                .equalToSuperview()
                .offset(-16)
            make
                .bottom
                .equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make
                .top
                .equalTo(searchBar.snp.bottom)
                .offset(16)
            make
                .leading
                .equalToSuperview()
                .offset(16)
            make
                .trailing
                .equalToSuperview()
                .offset(-16)
            make
                .bottom
                .equalToSuperview()
        }
    }
}

// MARK: - Create Layout

private extension HomeViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
            let section = sections[sectionIndex]
            switch section {
            case .trendingNow:
                return createTrendsSection()
            case .popularCategory:
                return createPopularCategorySection()
            case .popularCategoryRecipes:
                return createPopularCategoryRecipesSection()
            case .recentRecipe:
                return createRecentRecipeSection()
            case .popularCuisine:
                return createPopularCuisineSection()
            case .popularCuisineRecipes:
                return createPopularCuisineRecipesSection()
            }
        }
    }
    
    func createLayoutSection(group: NSCollectionLayoutGroup,
                             behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                             interGroupSpasing: CGFloat,
                             supplemetaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                             contentInsets: Bool,
                             heightOfHeader: CGFloat) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpasing
        section.boundarySupplementaryItems = supplemetaryItems
        section.supplementariesFollowContentInsets = contentInsets
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(heightOfHeader)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createTrendsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalHeight(0.55)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 80
        )
        
        return section
    }
    
    func createPopularCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.35),
                heightDimension: .fractionalHeight(0.08)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 80
        )
        
        return section
    }
    
    func createPopularCategoryRecipesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.45)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 32
        )
        
        return section
    }
    
    func createRecentRecipeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.35),
                heightDimension: .fractionalHeight(0.40)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 80
        )
        
        return section
    }
    
    func createPopularCuisineSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.35),
                heightDimension: .fractionalHeight(0.08)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 80
        )
        
        return section
    }
    
    func createPopularCuisineRecipesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.45)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false,
            heightOfHeader: 32
        )
        
        return section
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .trendingNow(let trendingNow):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCollectionViewCell", for: indexPath)
                    as? TrendsCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: trendingNow[indexPath.row])
            
            cell.onDetail
                .bind(onNext: { [weak self] recipe in
                    self?.onDetail.accept(recipe.id ?? 0)
                })
                .disposed(by: cell.disposeBag)
            
            cell.onSave
                .bind {
                    StorageRecipe.shared.saveRecipe(trendingNow[indexPath.row])
                }
                .disposed(by: cell.disposeBag)
            
            return cell
        case .popularCategory(let popularCategory):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCategoryViewCell", for: indexPath)
                    as? PopularCategoryCollectionViewCell else { return UICollectionViewCell()}
            cell.configure(titleCategory: popularCategory[indexPath.row].rawValue)
            return cell
        case .popularCategoryRecipes(let popularCategoryRecipes):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCategoryRecipesViewCell", for: indexPath)
                    as? PopularCategoriesRecipesCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: popularCategoryRecipes[indexPath.row])
            return cell
        case .recentRecipe(let recentRecipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentRecipeCollectionViewCell", for: indexPath)
                    as? RecentRecipeCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: recentRecipe[indexPath.row])
            return cell
        case .popularCuisine(let popularCuisines):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCuisineCollectionView", for: indexPath)
                    as? PopularCuisinesCollectionViewCell else { return UICollectionViewCell()}
            cell.configure(titleCuisine: popularCuisines[indexPath.row].rawValue)
            return cell
        case .popularCuisineRecipes(let popularCuisineRecipes):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCuisineRecipesCollectionView", for: indexPath) as? PopularCuisinesRecipesCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(withRecipe: popularCuisineRecipes[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderSupplementaryView",
                for: indexPath) as! HeaderSupplementaryView
            header.configureHeader(
                titleSection: sections[indexPath.section].title,
                isButtonVisible: sections[indexPath.section].isShowButton
            )
            header.onSeeAll
                .bind(onNext: { [unowned self] in
                    onSeeAll.accept(sections[indexPath.section].items as! [Recipe])
                })
                .disposed(by: header.disposeBag)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}


// MARK: - Вызов запросов при нажатии на ячейку
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case let .popularCategory(category):
            let selectedCategory = category[indexPath.item]
            print(selectedCategory)
            self.showLoader()
            fetchMealRecipes(by: selectedCategory)
        case let .popularCuisine(cousine):
            let selectedCousine = cousine[indexPath.item]
            self.showLoader()
            fetchCuisinesRecipes(by: selectedCousine)
        default:
            break
        }
    }
    
}

// MARK: - API CALLS
extension HomeViewController {
    func addDataToSections() {
        self.showLoader()
        ApiService.random(10).request(type: RandomResponse.self)  { [weak self] result in
            switch result {
            case .success(let success):
                if let recipes = success.recipes {
                    let trendingNowRecipes = Array(recipes)
                    let recentRecipeRecipes = Array(recipes)
                    
                    self?.sections = [
                        .trendingNow(trendingNowRecipes),
                        .popularCategory(SpoonacularMealType.allCases.map { $0 }),
                        .popularCategoryRecipes([]),
                        .recentRecipe(recentRecipeRecipes),
                        .popularCuisine(SpoonacularCuisinesType.allCases.map { $0 }),
                        .popularCuisineRecipes([])
                    ]
                    
                    DispatchQueue.main.async {
                        self?.fetchMealRecipes(by: .mainCourse)
                        self?.fetchCuisinesRecipes(by: .african)
                        self?.hideLoader()
                    }
                }
            case .failure(let failure):
                print(failure)
                self?.showErrorAlert(message: failure.localizedDescription)
            }
        }
    }
    
    private func fetchMealRecipes(by type: SpoonacularMealType) {
        ApiService
            .mealType(type)
            .request(type: ComplexSearchResponse.self) { [weak self] result in
                switch result {
                case .success(let success):
                    if let recipes = success.results {
                        print(recipes)
                        DispatchQueue.main.async {
                            self?.sections[2] = .popularCategoryRecipes(recipes)
                            self?.collectionView.reloadData()
                            self?.hideLoader()
                        }
                    }
                case .failure(let failure):
                    print(failure)
                    self?.showErrorAlert(message: failure.localizedDescription)
                }
            }
    }
    
    private func fetchCuisinesRecipes(by type: SpoonacularCuisinesType) {
        ApiService
            .cuisineType(type)
            .request(type: ComplexSearchResponse.self) { [weak self] result in
                switch result {
                case .success(let success):
                    if let recipes = success.results {
                        print(recipes)
                        DispatchQueue.main.async {
                            self?.sections[5] = .popularCategoryRecipes(recipes)
                            self?.collectionView.reloadData()
                            self?.hideLoader()
                        }
                    }
                case .failure(let failure):
                    print(failure)
                    self?.showErrorAlert(message: failure.localizedDescription)
                }
            }
    }
}
