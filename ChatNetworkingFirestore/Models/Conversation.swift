//
//  Conversation.swift
//  ChatCore
//
//  Created by Jan Schwarz on 05/01/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import ChatCore
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct ConversationFirestore: ConversationRepresenting, Decodable {
    public typealias Seen = [String: (messageId: ObjectIdentifier, seenAt: Date)]

    public let id: ObjectIdentifier
    public let lastMessage: MessageFirestore?
    let memberIds: [ObjectIdentifier]
    public private(set) var members: [UserFirestore] = []
    public private(set) var messages: [MessageFirestore] = []
    public private(set) var seen: Seen

    private enum CodingKeys: CodingKey {
        case id, lastMessage, messages, members, seen
    }

    public init(id: ObjectIdentifier, lastMessage: MessageFirestore?, members: [UserFirestore], messages: [MessageFirestore], seen: Seen, memberIds: [ObjectIdentifier]) {
        self.id = id
        self.lastMessage = lastMessage
        self.members = members
        self.messages = messages
        self.seen = seen
        self.memberIds = memberIds
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try values.decode(DocumentID<String>.self, forKey: .id).wrappedValue else {
            throw ChatError.incompleteDocument
        }
        
        self.id = id
        self.lastMessage = try values.decodeIfPresent(Message.self, forKey: .lastMessage)
        self.memberIds = try values.decode([ObjectIdentifier].self, forKey: .members)
        self.seen = try values.decodeIfPresent([String: SeenItem].self, forKey: .seen)?.reduce(into: Seen(), { (result, item) in
            let (key, value) = item
            result[key] = (messageId: value.messageId, seenAt: value.timestamp)
        }) ?? [:]
    }

// TODO: CJ

//    public mutating func setMembers(_ members: [UserFirestore]) {
//        self.members = members
//    }

    public mutating func setSeenMessages(_ seen: (messageId: ObjectIdentifier, seenAt: Date), currentUserId: ObjectIdentifier) {
        self.seen.updateValue(seen, forKey: currentUserId)
    }
}
