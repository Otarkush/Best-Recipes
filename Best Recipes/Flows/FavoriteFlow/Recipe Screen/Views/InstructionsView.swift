//
//  InstructionsView.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit
import SnapKit

final class InstructionsView: UIView {
    
    // MARK: - Properties
    
    private var instructionLabels: [UILabel] = []
    //    private let firstInstructionLabel: UILabel = {
    //        let label = UILabel()
    //        label.font = Resources.Fonts.poppinsRegular(of: 16)
    //        label.textColor = Resources.Colors.black
    //        label.text = "1. Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop."
    //        label.numberOfLines = 0
    //        return label
    //    }()
    //
    //    private let secondInstructionLabel: UILabel = {
    //        let label = UILabel()
    //        label.font = Resources.Fonts.poppinsRegular(of: 16)
    //        label.textColor = Resources.Colors.black
    //        label.text = "2. Place chopped eggs in a bowl."
    //        label.numberOfLines = 0
    //        return label
    //    }()
    //
    //    private let thirdInstructionLabel: UILabel = {
    //        let label = UILabel()
    //        label.font = Resources.Fonts.poppinsRegular(of: 16)
    //        label.textColor = Resources.Colors.black
    //        label.text = "3. Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice."
    //        label.numberOfLines = 0
    //        return label
    //    }()
    //
    //    private let fourthInstructionLabel: UILabel = {
    //        let label = UILabel()
    //        label.font = Resources.Fonts.poppinsRegular(of: 16)
    //        label.textColor = Resources.Colors.black
    //        label.text = "4. Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper"
    //        label.numberOfLines = 0
    //        return label
    //    }()
    //
    //    private let warningLabel: UILabel = {
    //        let label = UILabel()
    //        label.font = Resources.Fonts.poppinsRegular(of: 16)
    //        label.textColor = Resources.Colors.red
    //        label.text = "Stir and serve on your favorite bread or crackers."
    //        label.numberOfLines = 0
    //        return label
    //    }()
    
    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func configure(with recipe: Recipe) {
        for label in instructionLabels {
            vStack.removeArrangedSubview(label)
            label.removeFromSuperview()
        }
        instructionLabels.removeAll()
        
        guard let analyzedInstructions = recipe.analyzedInstructions, !analyzedInstructions.isEmpty else {
            return
        }
        
        let steps = analyzedInstructions[0].steps!
        for (index, step) in steps.enumerated() {
            let label = UILabel()
            label.font = Resources.Fonts.poppinsRegular(of: 16)
            label.textColor = Resources.Colors.black
            label.text = "\(index + 1). \(step.step ?? "No recipe from API")"
            label.numberOfLines = 0
            instructionLabels.append(label)
            vStack.addArrangedSubview(label)
        }
    }
}

// MARK: - Private Methods

private extension InstructionsView {
    
    func setupUI() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        addSubview(vStack)
    }
    
    func setupConstraints() {
        vStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
