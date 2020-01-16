//
//  QuizService.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation

class QuizService: QuizGateway {
    
    // MARK: - URL
    
    var urlString = "https://codechallenge.arctouch.com/quiz/1"
    
    // MARK: - Fetch Keywords
    
    func getQuiz(completion: @escaping (Result<KeywordsModel, CustomError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                completion(.failure(CustomError(message: "Error on request")))
            }
            guard let data = data else {
                completion(.failure(CustomError(message: "No data received")))
                return
            }
            do {
                let quiz = try JSONDecoder().decode(KeywordsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(quiz))
                }
            } catch _ {
                DispatchQueue.main.async {
                    completion(.failure(CustomError(message: "Error decoding data")))
                }
            }
        }
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
}
