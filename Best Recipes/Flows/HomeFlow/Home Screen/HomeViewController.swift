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
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupViews() {
        view.backgroundColor = .clear
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
}
