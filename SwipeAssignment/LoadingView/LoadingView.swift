//
//  LoadingView.swift
//  SwipeAssignment
//
//  Created by IBArtsTechnologies on 12/11/24.
//

import UIKit

class LoadingView: UIView {

    private let activityIndicator: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView(style: .large)
           indicator.color = .systemOrange
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupView()
       }
       
       private func setupView() {
           backgroundColor = UIColor(white: 0, alpha: 0.5) // Semi-transparent background
           addSubview(activityIndicator)
           
           // Center the activity indicator
           NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
           
           activityIndicator.startAnimating()
       }
       
       func show(on view: UIView) {
           frame = view.bounds
           view.addSubview(self)
       }
       
       func hide() {
           removeFromSuperview()
       }

}
