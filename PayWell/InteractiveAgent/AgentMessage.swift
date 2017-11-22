//
//  AgentMessage.swift
//  PayWell
//
//  Created by paulo on 11/21/17.
//  Copyright © 2017 Pay Well. All rights reserved.
//

import Foundation

class AgentMessage {
    
    var id:String
    var text:String
    var type:AgentMessageType
    
    init(id:String,
         text:String,
         type:AgentMessageType) {
        
        self.id = id
        self.text = text
        self.type = type
    }
}

enum AgentMessageType: String {
    case BOT, USER
}

