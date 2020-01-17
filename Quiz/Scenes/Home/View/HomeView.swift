//
//  HomeView.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIView {
    
    // MARK: - Views Proprieties
    
    weak var viewController: HomeViewController?
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "Question"
        label.font = .quizLargeFont
        return label
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(8)
        textField.setRightPaddingPoints(8)
        textField.placeholder = Constants.insertWord
        textField.isEnabled = false
        textField.addTarget(viewController, action: #selector(viewController?.textFieldDidChange(_:)), for: .allEditingEvents)
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        guard let viewModel = viewController?.viewModel else { return tableView }
        tableView.dataSource = viewModel
        return tableView
    }()
    
    lazy var detailsView: QuizGameControlView = {
        let detailsView = QuizGameControlView(frame: .zero)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.button.addGestureRecognizer(UITapGestureRecognizer(target: viewController, action: #selector(viewController?.startTimer(_:))))
        return detailsView
    }()
    
    // MARK: Lifecyle Methods
    
    init(frame: CGRect, viewController: HomeViewController) {
        super.init(frame: frame)
        self.viewController = viewController
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func moveTextfieldUp(height: CGFloat) {
        self.detailsView.frame.origin.y =  self.frame.height - self.detailsView.frame.height - height
    }
    
    func moveTextfieldDown() {
        self.detailsView.frame.origin.y = (self.frame.height - self.detailsView.frame.height)
    }
}

// MARK: - ViewCode Extension

extension HomeView: ViewCode {
    
    // MARK: - Functions
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(inputTextField)
        addSubview(tableView)
        addSubview(detailsView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: self.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height * 2),
            
            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            inputTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            inputTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: detailsView.topAnchor),
            
            detailsView.leftAnchor.constraint(equalTo: self.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: self.rightAnchor),
            detailsView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            detailsView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
    }
}
