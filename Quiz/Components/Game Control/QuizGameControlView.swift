//
//  DetailsView.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import UIKit

class QuizGameControlView: UIView {
    
    // MARK: - Propreties
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .quizLargeFont
        label.text = "00/50"
        return label
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .quizLargeFont
        label.text = "05:00"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.colors.quizOrange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("Start", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .quizButtonFont
        return button
    }()
    
    // MARK: - Lifecyle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension QuizGameControlView: ViewCode {
    
    // MARK: - Functions
    
    func buildViewHierarchy() {
        addSubview(counterLabel)
        addSubview(timerLabel)
        addSubview(button)
    }
    
    // MARK: - Constraints
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            counterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            counterLabel.heightAnchor.constraint(equalToConstant: counterLabel.intrinsicContentSize.height),
            counterLabel.widthAnchor.constraint(equalToConstant: counterLabel.intrinsicContentSize.width),
            
            timerLabel.topAnchor.constraint(equalTo: counterLabel.topAnchor),
            timerLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            timerLabel.heightAnchor.constraint(equalToConstant: timerLabel.intrinsicContentSize.height),
            timerLabel.widthAnchor.constraint(equalToConstant: timerLabel.intrinsicContentSize.width + 4),
            
            button.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 16),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            button.leftAnchor.constraint(equalTo: counterLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: timerLabel.rightAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = Constants.colors.quizLightGray
    }
}
