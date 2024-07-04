//
//  HomeViewController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
        return searchBar
    }()
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    func setDelegates() {
//        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        title = "Get amazing recipes for cooking"
        
        collectionView.register(
            TrendsCollectionViewCell.self,
            forCellWithReuseIdentifier: "TrendsCollectionViewCell")
        collectionView.register(
            PopularCategoriesCollectionViewCell.self,
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
        collectionView.snp.makeConstraints { make in
            make
                .top
                .equalToSuperview()
            make
                .bottom
                .equalToSuperview()
            make
                .leading.trailing
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
            case .trendingNow(_):
                return createTrendsSection()
            case .popularCategory(_):
                return createPopularCategoriesSection()
            case .recentRecipe(_):
                return createRecentRecipeSection()
            case .popularCuisines(_):
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
        section.supplementariesFollowContentInsets = contentInsets // заголовок секции
        
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
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 5,
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
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 5,
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
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 5,
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
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpasing: 5,
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
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .trendingNow(let trendingNow):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCollectionViewCell", for: indexPath)
                    as? TrendsCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: trendingNow[indexPath.row].image)
            return cell
        case .popularCategory(let popularCategory):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopiularCategoriesViewCell", for: indexPath)
                    as? PopularCategoriesCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: popularCategory[indexPath.row].image)
            return cell
        case .recentRecipe(let recentRecipe):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentRecipeCollectionViewCell", for: indexPath)
                    as? RecentRecipeCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: recentRecipe[indexPath.row].image)
            return cell
        case .popularCuisines(let popularCuisines):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCuisinesCollectionView", for: indexPath)
                    as? PopularCuisinesCollectionViewCell else { return UICollectionViewCell()}
            cell.configureCell(imageName: popularCuisines[indexPath.row].image)
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
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
