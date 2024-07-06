//
//  HomeViewController.swift
//  Best Recipes
//
//  Created by Иван Семикин on 30.06.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search recipes"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 15
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.systemGray4.cgColor
        return searchBar
    }()
    
    private var sections: [ListSection] = []
            
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataToSections()
        setupUI()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    func addDataToSections() {
        ApiService.random(10).request(type: RecipeResponse.self)  { [weak self] result in
            switch result {
            case .success(let success):
                if let recipes = success.recipes {
                    let trendingNowRecipes = Array(recipes)
                    let popularCategoryRecipes = Array(recipes)
                    let recentRecipeRecipes = Array(recipes)
                    let popularCuisinesRecipes = Array(recipes)
                    
                    self?.sections = [
                        .trendingNow(trendingNowRecipes),
                        .popularCategoryRecipes(popularCategoryRecipes),
                        .recentRecipe(recentRecipeRecipes),
                        .popularCuisines(popularCuisinesRecipes)
                    ]
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

        func setDelegates() {
//        searchBar.delegate = self
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
    }
    
    func registerCollectionViewCells() {
        collectionView.register(
            TrendsCollectionViewCell.self,
            forCellWithReuseIdentifier: "TrendsCollectionViewCell")
        collectionView.register(
            PopularCategoriesRecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopiularCategoriesViewCell")
        collectionView.register(
            RecentRecipeCollectionViewCell.self,
            forCellWithReuseIdentifier: "RecentRecipeCollectionViewCell")
        collectionView.register(
            PopularCuisinesCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCuisinesCollectionView")
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
                .equalTo(view.safeAreaLayoutGuide)
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
            case .popularCategoryRecipes:
                return createPopularCategoriesSection()
            case .recentRecipe:
                return createRecentRecipeSection()
            case .popularCuisines:
                return createPopularCuisinesSection()
            }
        }
    }
    
    func createLayoutSection(group: NSCollectionLayoutGroup,
                             behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                             interGroupSpasing: CGFloat,
                             supplemetaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                             contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpasing
        section.boundarySupplementaryItems = supplemetaryItems
        section.supplementariesFollowContentInsets = false
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(80)),
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
                heightDimension: .fractionalHeight(0.45)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false
        )
        
        return section
    }
    
    func createPopularCategoriesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.4)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false
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
                heightDimension: .fractionalHeight(0.38)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false
        )
        
        return section
    }
    
    func createPopularCuisinesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(0.4)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 16,
            supplemetaryItems: [],
            contentInsets: false
        )
        
        return section
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
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
            return cell
        case .popularCategoryRecipes(let popularCategory):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopiularCategoriesViewCell", for: indexPath)
                    as? PopularCategoriesRecipesCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: popularCategory[indexPath.row])
            return cell
        case .recentRecipe(let recentRecipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentRecipeCollectionViewCell", for: indexPath)
                    as? RecentRecipeCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(recipe: recentRecipe[indexPath.row])
            return cell
        case .popularCuisines(let popularCuisines):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCuisinesCollectionView", for: indexPath)
                    as? PopularCuisinesCollectionViewCell else { return UICollectionViewCell()}
            cell.configure(imageName: popularCuisines[indexPath.row].image ?? "")
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
                isButtonVisible: sections[indexPath.section].title == "Popular category" ? false : true
            )
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
