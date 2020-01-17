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
    
    var urlString: URL {
        get {
            guard let url = URL(string: Constants.api.baseURL) else {
                fatalError("Error creating baseURL with: \(Constants.api.baseURL)")
            }
            return url
        }
    }
    
    // MARK: - Fetch Keywords
    
    func getQuiz(completion: @escaping (Result<KeywordsModel, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if (error != nil) {
                completion(.failure(CustomError(message: Constants.errorRequest)))
            }
            guard let data = data else {
                completion(.failure(CustomError(message: Constants.errorData)))
                return
            }
            do {
                let quiz = try JSONDecoder().decode(KeywordsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(quiz))
                }
            } catch _ {
                DispatchQueue.main.async {
                    completion(.failure(CustomError(message: Constants.errorDecodingData)))
                }
            }
        }
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
}
