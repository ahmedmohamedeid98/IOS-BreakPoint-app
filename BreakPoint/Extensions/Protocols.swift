//
//  Protocols.swift
//  BreakPoint
//
//  Created by ahmed on 1/5/20.
//  Copyright © 2020 ahmed. All rights reserved.
//

import Foundation

protocol GetUserMessagesInFeed {
    func getAllMessagesInFeed(userId uid: String) -> [String]
}

