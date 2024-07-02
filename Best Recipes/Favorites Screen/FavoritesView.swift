//
//  FavoritesView.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit

class FavoritesView: UIView {
    
    // MARK: -  Property UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved recipes"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
//        tableView.separatorStyle = .none
        tableView.backgroundColor = .blue
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: -  Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setView()
        setupConstraints()
    }
    // MARK: - Settings UI
    
    private func setView() {
        backgroundColor = .white
        [
        titleLabel,
        favoriteTableView
        ].forEach{ addSubview($0) }
        
        favoriteTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
    func setDelegate(_ value: FavoritesViewController) {
        favoriteTableView.delegate = value
        favoriteTableView.dataSource = value
    }
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            favoriteTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            favoriteTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            favoriteTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            favoriteTableView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
}
