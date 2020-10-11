//
//  ContentfulMessageRepresenting.swift
//  ChatUI
//
//  Created by Jan on 11/10/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import MessageKit
import ChatCore

public protocol ContentfulMessageRepresenting: MessageRepresenting, MessageConvertible, MessageStateReflecting, MessageType {
    associatedtype Content: MessageKindSpecifying
    
    var content: Content { get }
}
