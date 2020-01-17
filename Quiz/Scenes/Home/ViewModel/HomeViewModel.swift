//
//  HomeViewModel.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol QuizGateway {
    func getQuiz(completion: @escaping (Result<KeywordsModel, CustomError>) -> Void)
}

class HomeViewModel: NSObject {
    
    // MARK: - Propreties
    
    weak var viewController: HomeViewController?
    let quizGateway: QuizGateway
    var quiz: KeywordsModel?
    var error: CustomError?
    
    var addedAnswers: [String] {
        didSet {
            viewController?.contentView?.tableView.reloadData()
            updateDetailsCounterLabel()
            if (addedAnswers.count == quiz?.answer.count) {
                viewController?.presentAlert(type: .sucess, count: nil, max: nil)
            }
        }
    }
    
    // MARK: - Lifecycle Methods
    
    init(viewController: HomeViewController? = nil, gateway: QuizGateway = QuizService()) {
        self.viewController = viewController
        self.quizGateway = gateway
        self.addedAnswers = [String]()
    }
    
    // MARK: - Methods
    
    func getQuiz(completion: @escaping (Result<KeywordsModel, CustomError>) -> Void) {
        viewController?.contentView?.loadingView.isHidden = false
        quizGateway.getQuiz { (result) in
            self.viewController?.contentView?.loadingView.isHidden = true
            switch result {
            case .success(let quiz):
                self.quiz = quiz
                self.updateDetailsCounterLabel()
                self.updateQuizQuestion()
                completion(.success(quiz))
            case .failure(let error):
                self.error = error
                completion(.failure(error))
            }
        }
    }
    
    func add(answer: String) {
        addedAnswers.append(answer)
    }
    
    func resetAnswers() {
        addedAnswers = [String]()
    }
    
    func updateDetailsCounterLabel() {
        guard let quiz = quiz else { return }
        viewController?.contentView?.detailsView.counterLabel.text = Util.pointsToText(totalPoints: quiz.answer.count, currentPoints: addedAnswers.count)
    }
    
    func updateQuizQuestion() {
        guard let quiz = quiz else { return }
        viewController?.contentView?.titleLabel.text = quiz.question
    }

}

// MARK: - UITableViewDataSource

extension HomeViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = addedAnswers[indexPath.row]
        return cell
    }
}
