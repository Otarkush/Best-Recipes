//
//  SeeAllViewController.swift
//  Best Recipes
//
//  Created by Alexander on 10.07.24.
//

import UIKit
import RxSwift
import RxGesture
import RxRelay

final class SeeAllViewController: UIViewController {
    
    //MARK: - Private properties
    
    let onDetail = PublishRelay<Int>()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.description())
        return tableView
    }()
    
    private var recipes: [Recipe] = []
    
    private let disposeBag = DisposeBag()
    //MARK: - Initializers
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - SetupUI

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
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.description(), for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        
        cell.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(onNext: { [weak self] _ in
                self?.onDetail.accept(recipe.id ?? 0)
            })
            .disposed(by: disposeBag)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 224
    }
}
