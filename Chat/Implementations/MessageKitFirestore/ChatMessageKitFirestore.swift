//
//  ChatMessageKitFirestore.swift
//  Chat
//
//  Created by Jan on 31/03/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import UIKit
import ChatCore
import ChatNetworkingFirestore
import ChatUI

/// Chat implementation that uses Firestore networking and MessageKit UI
public class ChatMessageKitFirestore<Models: ChatMessageKitFirestoreModeling>: DefaultChatSpecifying {
    public typealias UIModels = Models
    public typealias Networking = ChatFirestore<Models>
    public typealias Core = ChatCore<Networking, UIModels>
    public typealias Interface = ChatInterfaceMessageKit<Models>

    let core: Core
    let networking: Networking
    let uiConfig: UIConfiguration
    private(set) var interfaces: [ObjectIdentifier: Interface] = [:]
    
    // Logger
    public var logLevel: ChatLogLevel = .critical {
        didSet {
            core.logLevel = logLevel
            networking.logLevel = logLevel
            
            for (_, interface) in interfaces {
                interface.uiService.logLevel = logLevel
            }
        }
    }

    public required init(networkConfig: NetworkConfiguration, uiConfig: UIConfiguration, userManager: Networking.UserManager? = nil) {
        self.uiConfig = uiConfig

        let networking: Networking
        // if not provided by app use default firestore
        if let userManager = userManager {
            networking = Networking(config: networkConfig, userManager: userManager)
        } else {
            networking = Networking(config: networkConfig)
        }
        
        self.networking = networking
        self.core = ChatCore<Networking, UIModels>(networking: networking)
    }
}

// MARK: - UI
public extension ChatMessageKitFirestore {
    func interface(with identifier: ObjectIdentifier) -> Interface {
        if let interface = interfaces[identifier] {
            return interface
        } else {
            let interface: Interface = Interface(identifier: identifier, core: core, config: uiConfig)
            interfaces[identifier] = interface
            return interface
        }
    }
}

// MARK: - Messages
public extension ChatMessageKitFirestore {
    func runBackgroundTasks(completion: @escaping (UIBackgroundFetchResult) -> Void) {
        core.runBackgroundTasks(completion: completion)
    }

    func resendUnsentMessages() {
        core.resendUnsentMessages()
    }
}

// MARK: - Users
public extension ChatMessageKitFirestore {
    func setCurrentUser(user: Core.UserUI) {
        core.setCurrentUser(user: user)
    }
}
