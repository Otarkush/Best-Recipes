//
//  FavoritesView.swift
//  Best Recipes
//
//  Created by Alexander Bokhulenkov on 01.07.2024.
//

import UIKit
import SnapKit

final class FavoritesView: UIView {
    
    // MARK: -  Property UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.black
        label.font = Resources.Fonts.poppinsBold(of: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Saved recipes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var favoriteTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
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
        
//        регистрация ячейки
        favoriteTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
//    Делегаты
    func setDelegate(_ value: FavoritesViewController) {
        favoriteTableView.delegate = value
        favoriteTableView.dataSource = value
    }
    // MARK: - Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        favoriteTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
}
