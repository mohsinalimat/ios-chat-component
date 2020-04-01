//
//  User.swift
//  ChatApp
//
//  Created by Tomas Cejka on 4/1/20.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation

// MARK: - App user model
struct User: Codable {
    let id: String
    let name: String
    let imageUrl: URL?
}
