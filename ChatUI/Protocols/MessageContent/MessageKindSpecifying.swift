//
//  MessageKindSpecifying.swift
//  ChatUI
//
//  Created by Jan on 11/10/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation

public protocol MessageKindSpecifying {
    var kind: ChatMessageKind { get }
}
