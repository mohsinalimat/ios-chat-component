//
//  MessageKitType.swift
//  ChatUI
//
//  Created by Mireya Orta on 1/14/20.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import ChatCore
import Foundation
import MessageKit

public enum MessageContent {
    case text(message: String)
    case image(imageUrl: String)
}

public struct MessageKitType: MessageType, MessageRepresenting {
   public var userId: ObjectIdentifier

   public var sentAt: Date

   public var id: ObjectIdentifier
   public var sender: SenderType
   public var messageId: String
   public var sentDate: Date
   public var kind: MessageKind

    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.sentAt = Date()
        self.userId = ""
        self.id = messageId
    }

    public init(id: ObjectIdentifier, userId: ObjectIdentifier, sentAt: Date, content: MessageContent) {
        sender = User(id: userId, name: "", imageUrl: nil, compatibility: 0)
        messageId = id
        self.sentDate = sentAt
        
        switch content {
        case .text(let message):
            self.kind = .text(message)
        case .image(let imageUrl):
            let imageItem = ImageItem(
                url: URL(string: imageUrl),
                image: nil,
                placeholderImage: UIImage(),
                size: CGSize(width: Constants.imageMessageSize.width,
                             height: Constants.imageMessageSize.height)
            )
            self.kind = .photo(imageItem)
        }
        
        self.sentAt = Date()
        self.userId = userId
        self.id = id
    }
}
