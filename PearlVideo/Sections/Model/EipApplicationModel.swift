//
//  PVApplicationModel.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/3/21.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation
import ObjectMapper

class PVApplicationModel: PVBaseModel {
    
    var id = ""
    ///应用组名
    var name = ""
    var appApplicationList = Array<PVApplicationItemModel>()
    
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        appApplicationList <- map["appApplicationList"]
    }
    
}

class PVApplicationItemModel: PVBaseModel {
    
    var id = ""
    ///应用名
    var name = ""
    ///应用地址
    var url = ""
    ///图片地址
    var icon = ""
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        url <- map["url"]
        icon <- map["icon"]
    }
    
}

