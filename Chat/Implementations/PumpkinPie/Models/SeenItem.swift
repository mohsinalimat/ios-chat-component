//
//  SeenItem.swift
//  ChatApp
//
//  Created by Daniel Pecher on 19/01/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import ChatCore
import FirebaseFirestore

// TODO: Try to figure out how to infer this
public struct SeenItem: Decodable {
    public let messageId: EntityIdentifier
    public let timestamp: Date
    
    private enum CodingKeys: CodingKey {
        case messageId, timestamp
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.messageId = try values.decode(EntityIdentifier.self, forKey: .messageId)
        self.timestamp = try values.decode(Timestamp.self, forKey: .timestamp).dateValue()
    }

    public init(messageId: EntityIdentifier, timestamp: Date) {
        self.messageId = messageId
        self.timestamp = timestamp
    }
}