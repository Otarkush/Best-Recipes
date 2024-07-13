//
//  UIViewController + Ext.swift
//  Best Recipes
//
//  Created by dsm 5e on 06.07.2024.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    private var activityIndicatorTag: Int {
        return 999
    }

    private var overlayTag: Int {
        return 1000
    }

    var activityIndicator: UIActivityIndicatorView? {
        return view.viewWithTag(activityIndicatorTag) as? UIActivityIndicatorView
    }

    var overlay: UIView? {
        return UIApplication.shared.windows.first?.viewWithTag(overlayTag)
    }

    func showLoader() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        overlay.tag = overlayTag
        window.addSubview(overlay)

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = activityIndicatorTag
        overlay.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    func hideLoader() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        overlay?.removeFromSuperview()
    }
}
