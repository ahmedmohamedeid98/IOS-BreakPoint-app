//
//  Group.swift
//  BreakPoint
//
//  Created by ahmed on 12/7/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation

class Group{
    
    private var _title: String
    private var _description: String
    private var _key: String
    private var _membersCount: Int
    private var _members: [String]

    
    //computed properties
    var title: String {
        return _title
    }
    var description: String{
        return _description
    }
    var memberCount: Int{
        return _membersCount
    }
    var key: String{
        return _key
    }
    var members: [String]{
        return _members
    }
    
    init(title:String, description:String, key:String, members: [String]){
        self._title = title
        self._description = description
        self._members = members
        self._membersCount = members.count
        self._key = key
    }
    
    
}
