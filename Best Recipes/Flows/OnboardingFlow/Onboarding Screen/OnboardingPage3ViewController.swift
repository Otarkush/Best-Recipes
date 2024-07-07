//
//  OnboardingPage3ViewController.swift
//  Best Recipes
//
//  Created by Maksim on 03.07.2024.
//

import UIKit
import SnapKit

protocol OnboardingPage3ViewOutput {
    func onboardingFinish()
}

final class OnboardingPage3ViewController: UIViewController {
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .obFourth
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private var gradientLayer: CAGradientLayer {
        let element = CAGradientLayer()
        element.frame = view.bounds
        element.colors = [UIColor.black.withAlphaComponent(0.9).cgColor, UIColor.clear.cgColor]
        element.startPoint = CGPoint(x: 0.5, y: 1.0)
        element.endPoint = CGPoint(x: 0.5, y: 0.0)
        return element
    }
    
    private lazy var startCookingButton: UIButton = {
        let element = UIButton()
        element.setTitle("Start Cooking", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        element.backgroundColor = UIColor(named: "buttonColor")
        element.layer.cornerRadius = 25
        element.addTarget(self, action: #selector(startCookingTapped), for: .touchUpInside)
        return element
    }()
    
    private lazy var progressStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.distribution = .fillProportionally
        return element
    }()
    
    private lazy var firstProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = .lightGray
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var secondProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = .lightGray
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var thirdProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.98, green: 0.61, blue: 0.69, alpha: 1.00)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 55, weight: .bold)
        element.textColor = .white
        element.numberOfLines = 0
        let fullString = "Cook it now or \nsave it for later"
        let coloredString = "save it for later"
        let rangeOfColoredString = (fullString as NSString).range(of: coloredString)
        let attributedString = NSMutableAttributedString(string:fullString)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.fontColorOnboarding],range: rangeOfColoredString)
        element.attributedText = attributedString
        return element
    }()
    
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.layer.addSublayer(gradientLayer)
        view.addSubview(startCookingButton)
        view.addSubview(progressStackView)
        view.addSubview(mainLabel)
        
        progressStackView.addArrangedSubview(firstProgressView)
        progressStackView.addArrangedSubview(secondProgressView)
        progressStackView.addArrangedSubview(thirdProgressView)
    }
    // MARK: - Selector methods
    @objc private func startCookingTapped() {
        onboardingFinish()
        print("startCookingTapped")
    }
}

extension OnboardingPage3ViewController: OnboardingPage3ViewOutput {
    func onboardingFinish() {
        // MARK: - Раскоментировать если нужно сохранять стейт онбординга
        UserDefaultsService.shared.isOnboarding = true
        coordinator.finish()
    }
}


// MARK: - Setup Constraints
extension OnboardingPage3ViewController {
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startCookingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 1.7)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(startCookingButton).inset(90)
        }
        
        firstProgressView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(50)
        }
        
        secondProgressView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(50)
        }
        
        thirdProgressView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(50)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(progressStackView).inset(40)
        }
    }
}

