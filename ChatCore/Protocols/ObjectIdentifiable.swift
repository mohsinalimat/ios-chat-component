//
//  ChatIdentifiable.swift
//  ChatCore
//
//  Created by Jan Schwarz on 05/01/2020.
//  Copyright © 2020 Jan Schwarz. All rights reserved.
//

import Foundation

/// Used to identify any object
public protocol ObjectIdentifiable: Identifiable {
    var id: ObjectIdentifier { get }
}
