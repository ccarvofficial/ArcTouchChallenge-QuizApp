//
//  Constants.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
    // MARK: - Message
    
    static let congratulations = "Congratulations"
    static let finishGameText = "Good job! You found all the answers on time. Keep up with the great work."
    static let playAgain = "Play Again"
    
    static let timeFinished = "Time Finished"
    static let tryAgain = "Try Again"
    
    static let start = "Start"
    static let reset = "Reset"
    static let ok = "OK"
    
    // MARK: - Error
    
    static let error = "Error"
    static let errorRequest = "Error on request"
    static let errorData = "No data received"
    static let errorDecodingData = "Error decoding data"
    
    // MARK: - TextField Placeholder
    
    static let insertWord = "Insert Word"
    
    enum colors {
        static let quizOrange = UIColor(red: 255/255, green: 131/255, blue: 0, alpha: 1.0)
        static let quizLightGray = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        static let quizBackdrop = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        static let quizAlertView = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    // MARK: - API
    
    enum api {
        static let baseURL = "https://codechallenge.arctouch.com/quiz/1"
    }
    
    enum AlertType {
        case sucess
        case failure
    }
}
