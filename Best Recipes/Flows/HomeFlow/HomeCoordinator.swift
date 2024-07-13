//
//  HomeCoordinator.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import Foundation
import RxSwift

class HomeCoordinator: Coordinator {
    
    private let disposeBag = DisposeBag()
    
    override func start() {
        print("Init home screen")
        let vc = HomeViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: true)

        vc.onDetail
            .bind(onNext: { [weak self] id in
                self?.showDetail(with: id)
            })
            .disposed(by: disposeBag)
        
        vc.onSeeAll
            .bind(onNext: { [weak self] recipes in
                self?.pushSeeAll(with: recipes)
            })
            .disposed(by: disposeBag)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension HomeCoordinator {
    func pushSeeAll(with recipes: [Recipe]) {
        let vc = SeeAllViewController(recipes: recipes)
        
        vc.onDetail
            .bind(onNext: { [weak self] id in
                self?.showDetail(with: id)
            })
            .disposed(by: disposeBag)
            
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDetail(with id: Int) {
        let vc = RecipeViewController(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
