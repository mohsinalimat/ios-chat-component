//
//  ChatUICoreServicing.swift
//  ChatUI
//
//  Created by Mireya Orta on 1/14/20.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation
import ChatCore

public protocol ChatUICoreServicing: ChatCoreServicing where Converter: ChatUIModelConverting { }

extension ChatCore: ChatUICoreServicing where Converter: ChatUIModelConverting { }
