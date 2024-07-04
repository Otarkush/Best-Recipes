//
//  PageViewController.swift
//  Best Recipes
//
//  Created by Maksim on 03.07.2024.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageControllers: [UIViewController] = []
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        super.init()
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSource = self
        delegate  = self
        
        let firstController = OnboardingMainViewController()
        let secondController = OnboardingPage1ViewController()
        let thirdController = OnboardingPage2ViewController()
        let forthController = OnboardingPage3ViewController()
        
        pageControllers = [firstController, secondController, thirdController, forthController]
        
        if let firstVC = pageControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                guard let currentIndex = pageControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let previousIndex = currentIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                return pageControllers[previousIndex]
            }

            func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                guard let currentIndex = pageControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let nextIndex = currentIndex + 1
                
                guard nextIndex < pageControllers.count else {
                    return nil
                }
                
                return pageControllers[nextIndex]
            }
        }




