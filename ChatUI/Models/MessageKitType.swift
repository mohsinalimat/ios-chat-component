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

public struct MessageKitType: MessageType, MessageRepresenting, MessageConvertible {
    public var userId: ObjectIdentifier

    public var sentAt: Date

    public var id: ObjectIdentifier
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    public var state: MessageState

    public init(id: ObjectIdentifier, userId: ObjectIdentifier, messageSpecification: MessageSpecification, state: MessageState = .sending) {
        self.sentAt = Date()
        self.sentDate = Date()
        self.messageId = id
        self.id = id
        self.sender = Sender(id: userId, displayName: "")
        self.userId = userId

        switch messageSpecification {
        case .text(let message):
            self.kind = .text("\(message) a \(state)")
        case .image(let image):
            let imageItem = ImageItem(
                url: nil,
                image: image,
                placeholderImage: UIImage(),
                size: CGSize(width: Constants.imageMessageSize.width,
                             height: Constants.imageMessageSize.height)
            )
            self.kind = .photo(imageItem)
        }

        self.state = state
    }

    public init(id: ObjectIdentifier, userId: ObjectIdentifier, sentAt: Date, content: MessageContent) {
        self.sender = Sender(id: userId, displayName: "")
        self.messageId = id
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
        
        self.sentAt = sentAt
        self.userId = userId
        self.id = id
        self.state = .sent
    }
}
