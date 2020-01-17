//
//  CustomError.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import UIKit

class CustomError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

