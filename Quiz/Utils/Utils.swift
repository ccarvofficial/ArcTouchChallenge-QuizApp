//
//  Utils.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation

class Util {
    
    // MARK: - Configuration Points
    
    class func pointsToText(totalPoints: Int, currentPoints: Int) -> String {
        let sPointsTextToReturn = String.init(format: "%0.2d/%0.2d", currentPoints, totalPoints)
        return sPointsTextToReturn
    }
}
