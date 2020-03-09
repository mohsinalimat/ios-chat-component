//
//  UserConvertible.swift
//  ChatApp
//
//  Created by Mireya Orta on 2/5/20.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import ChatCore
import ChatNetworkingFirestore
import ChatUI
import Foundation

extension User: ChatNetworkingConvertible {
    public typealias NetworkingModel = UserFirestore
}

extension UserFirestore: ChatUIConvertible {

    public var uiModel: User {
        return User(id: self.id, name: self.name, imageUrl: self.imageUrl)
    }

    public init(uiModel: User) {
        self.init(id: uiModel.id, name: uiModel.name, imageUrl: uiModel.imageUrl)
    }
}
