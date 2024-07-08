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
                UIView.animate(withDuration: 0.2) {
                    self?.selectedIndex = 2
                    self?.customTabBar.plusButton.isHidden = true
                    self?.customTabBar.plusButton.alpha = 0
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            if index == 2 {
                UIView.animate(withDuration: 0.2) {
                    self.customTabBar.plusButton.isHidden = true
                    self.customTabBar.plusButton.alpha = 0
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.customTabBar.plusButton.isHidden = false
                    self.customTabBar.plusButton.alpha = 1
                }
            }
        }
    }
}
