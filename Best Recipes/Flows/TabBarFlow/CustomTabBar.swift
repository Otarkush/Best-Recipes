//
//  CustomTabBar.swift
//  Best Recipes
//
//  Created by dsm 5e on 03.07.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

final class CustomTabBar: UITabBar {
    
    let plusButton = PlusButton(type: .system)
    
    override func draw(_ rect: CGRect) {
        configureShape()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
        setupConstraints()
    }
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tintColor = .red
        unselectedItemTintColor = .gray

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -4)
        layer.shadowRadius = 5
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        plusButton.frame.contains(point) ? plusButton : super.hitTest(point, with: event)
    }
}

private extension CustomTabBar {
    func setupConstraints() {
        addSubview(plusButton)
        
        plusButton.snp.makeConstraints { make in
            make
                .centerX
                .equalToSuperview()
            make
                .centerY
                .equalTo(self.snp.top)
                .offset(-10)
            make
                .height
                .equalTo(self.snp.height)
                .multipliedBy(0.65)
            make
                .width
                .equalTo(self.snp.height)
                .multipliedBy(0.65)
        }
    }
}

// MARK: - draw shape
extension CustomTabBar {
    private func configureShape() {
        let path = getTabBarPath()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        layer.insertSublayer(shape, at: 0)
        itemWidth = 30
        itemPositioning = .centered
        itemSpacing = 40
    }
    
    private func getTabBarPath() -> UIBezierPath {
        let path = UIBezierPath()
        let width = frame.width
        let height = frame.height
        
        path.move(to: CGPoint(x: 0, y: 0.07826*height - 10))
        path.addLine(to: CGPoint(x: 0.355*width, y: 0.07826*height - 10))
        path.addCurve(to: CGPoint(x: 0.41372*width, y: 0.21761*height - 10),
                      controlPoint1: CGPoint(x: 0.38099*width, y: 0.07826*height - 10),
                      controlPoint2: CGPoint(x: 0.40301*width, y: 0.14038*height - 10))
        path.addCurve(to: CGPoint(x: 0.50133*width, y: 0.43478*height - 10),
                      controlPoint1: CGPoint(x: 0.42758*width, y: 0.31761*height - 10),
                      controlPoint2: CGPoint(x: 0.45394*width, y: 0.43478*height - 10))
        path.addCurve(to: CGPoint(x: 0.58895*width, y: 0.21761*height - 10),
                      controlPoint1: CGPoint(x: 0.54873*width, y: 0.43478*height - 10),
                      controlPoint2: CGPoint(x: 0.57508*width, y: 0.31761*height - 10))
        path.addCurve(to: CGPoint(x: 0.64767*width, y: 0.07826*height - 10),
                      controlPoint1: CGPoint(x: 0.59966*width, y: 0.14038*height - 10),
                      controlPoint2: CGPoint(x: 0.62167*width, y: 0.07826*height - 10))
        path.addLine(to: CGPoint(x: width, y: 0.07826*height - 10))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        
        return path
    }
}
