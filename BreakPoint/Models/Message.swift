//
//  Message.swift
//  BreakPoint
//
//  Created by ahmed on 12/6/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation

class Message{
    private var _content: String
    private var _senderId: String
    
    var content: String{
        return _content
    }
    var senterId: String{
        return _senderId
    }
    
    init(content: String, senderId: String){
        self._content = content
        self._senderId = senderId
    }
}
