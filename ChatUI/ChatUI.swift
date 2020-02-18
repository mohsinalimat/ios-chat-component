//
//  ChatUI.swift
//  ChatUI
//
//  Created by Jan Schwarz on 05/01/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import UIKit
import ChatCore

// swiftlint:disable type_name
public class ChatUI<Core: ChatUICoreServicing>: ChatUIServicing {
    let core: Core
    
    public required init(core: Core) {
        self.core = core
    }
    
    public func conversationsList() -> UIViewController {
        let list = ConversationsListViewController(core: core)
        let navigation = UINavigationController(rootViewController: list)
        return navigation
    }
}
