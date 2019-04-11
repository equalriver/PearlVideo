//
//  PVContactModel.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/3/7.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation
import ObjectMapper

class PVContactModel: PVBaseModel {
    
    var name = ""
    var phone = ""
    var address = ""
    var icon = ""
    var email = ""
    
    
    
    override func mapping(map: Map) {
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        icon <- map["icon"]
        email <- map["email"]
       
    }
    
}

class PVContactOrgModel: PVBaseModel {
    
    ///展开状态
    var isOpen = false
    
    var name = ""
    var parentId = ""
    var groupId = ""
    var deps = Array<PVContactOrgModel>()
    
    
    override func mapping(map: Map) {
        name <- map["name"]
        parentId <- map["parentId"]
        groupId <- map["groupId"]
        deps <- map["deps"]
    }
    
}
