//
//  ChatSpecifying+iOS12.swift
//  Chat
//
//  Created by Jan on 17/04/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation

@available(iOS, deprecated: 13.0)
public extension ChatSpecifying where Self: AnyObject {
    /// Get default unidentified UI instance
    /// - Returns: Chat UI interface
    func interface() -> Interface {
        return interface(with: ObjectIdentifier(self))
    }
}
