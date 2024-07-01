//
//  OnboardingViewController.swift
//  Best Recipes
//
//  Created by dsm 5e on 01.07.2024.
//

import UIKit

protocol OnboardingViewOutput {
    func onboardingFinish()
}

class OnboardingViewController: UIViewController {
    
    private let userDefaultService = UserDefaultsService.shared

    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(startButton)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func startButtonTapped() {
        onboardingFinish()
    }
}

extension OnboardingViewController: OnboardingViewOutput {
    func onboardingFinish() {
        // MARK: - Раскоментировать если нужно сохранять стейт онбординга
//        userDefaultService.isOnboarding = true
        coordinator.finish()
    }
}
