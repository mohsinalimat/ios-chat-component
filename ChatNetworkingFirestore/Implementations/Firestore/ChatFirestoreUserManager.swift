//
//  ChatFirestoreUserManager.swift
//  ChatNetworkingFirestore
//
//  Created by Jan on 29/04/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import ChatCore

open class ChatFirestoreUserManager<User: UserRepresenting>: UserManaging where User: Decodable {
    // swiftlint:disable:next unavailable_function
    open func users(userIds: [EntityIdentifier], completion: @escaping (Result<[User], ChatError>) -> Void) {
        fatalError("\(#function) has not been implemented")
    }
}
