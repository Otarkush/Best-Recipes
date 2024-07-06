//
//  TabBarController.swift
//  Best Recipes
//
//  Created by Андрей Линьков on 30.06.2024.
//

import UIKit
import RxSwift
import RxGesture

final class TabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    private let disposeBag = DisposeBag()
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        tabBarControllers.forEach { item in
            self.addChild(item)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        customTabBar.plusButton.rx.tap
            .bind { [weak self] in
                self?.selectedIndex = 2
            }
            .disposed(by: disposeBag)
    }
}
