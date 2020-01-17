//
//  LoadingView.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    // MARK: - Propreties
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.colors.quizBackdrop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.colors.quizAlertView
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .white
        return activityIndicatorView
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "Loading..."
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecyle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicatorView.startAnimating()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension LoadingView: ViewCode {
    
    // MARK: - Functions
    
    func buildViewHierarchy() {
        addSubview(backdropView)
        addSubview(alertView)
        addSubview(activityIndicatorView)
        addSubview(loadingLabel)
    }
    
    // MARK: - Constraints
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: self.topAnchor),
            backdropView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backdropView.rightAnchor.constraint(equalTo: self.rightAnchor),
            backdropView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 150),
            alertView.heightAnchor.constraint(equalToConstant: 150),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 64),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 64),
            
            loadingLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 16),
            loadingLabel.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 8),
            loadingLabel.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
}
