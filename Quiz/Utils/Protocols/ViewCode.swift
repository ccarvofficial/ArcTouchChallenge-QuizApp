//
//  ViewCode.swift
//  Quiz
//
//  Created by claudiocarvalho on 16/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

// MARK: - Extension

extension ViewCode {
    func setupView() {
        self.buildViewHierarchy()
        self.setupConstraints()
        self.setupAdditionalConfiguration()
    }
}
