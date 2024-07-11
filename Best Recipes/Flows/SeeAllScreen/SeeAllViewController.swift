//
//  SeeAllViewController.swift
//  Best Recipes
//
//  Created by Alexander on 5.07.24.
//

import UIKit
import SnapKit

final class SeeAllViewController: UIViewController {
    
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Private Methods

private extension SeeAllViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
//MARK: - UITableViewDataSource and UITableViewDelegate

extension SeeAllViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 //260 по дизайну + 24 separatorView
    }

}
