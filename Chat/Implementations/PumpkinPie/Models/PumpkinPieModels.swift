//
//  PumpkinPieModels.swift
//  Chat
//
//  Created by Jan on 29/04/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import ChatUI
import ChatNetworkingFirestore

/// This class specifies all necessary networking and UI models of Pumpkin Pie chat
public class PumpkinPieModels: ChatUIModels, ChatFirestoreModeling {
    public typealias NetworkConversation = Conversation
    public typealias NetworkMessage = Message
    public typealias NetworkMessageSpecification = MessageSpecification
    public typealias NetworkUser = User
    
    // Convenient typealiases without any prefixes
    public typealias User = UIUser
    public typealias Conversation = UIConversation
    public typealias Message = UIMessage
    public typealias MessageSpecification = UIMessageSpecification
}