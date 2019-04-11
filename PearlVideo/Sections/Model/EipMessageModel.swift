//
//  PVMessageModel.swift
//  yjkj-PV-ios
//
//  Created by equalriver on 2019/3/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation
import ObjectMapper

class PVMessageModel: PVBaseModel {
    
    ///待办数
    var toDoCount = 0
    ///邮件未读数
    var mailCount = 0
    ///待办事项
    var toDo = PVMessageItemModel()
    ///邮件
    var mail = PVMessageItemModel()
    ///公司公告
    var noticeList = Array<PVMessageItemModel>()
   

    
    
    override func mapping(map: Map) {
        toDoCount <- map["toDoCount"]
        mailCount <- map["mailCount"]
        toDo <- map["toDo"]
        mail <- map["mail"]
        noticeList <- map["noticeList"]
        
    }
    
}


class PVMessageItemModel: PVBaseModel {
    
    var id = ""
    ///发送者id
    var sendID = ""
    ///创建时间(时间戳)
    var createTime = 0
    ///内容
    var content = ""
    var type = ""
    ///发送者
    var sender = ""
    
    ///标题
    var name = ""
    
    override func mapping(map: Map) {
        id <- map["ID_"]
        sendID <- map["SENDER_ID_"]
        createTime <- map["CREATE_TIME_"]
        content <- map["CONTENT_"]
        type <- map["TYPE_"]
        sender <- map["SENDER_"]
        name <- map["NAME_"]
    }
    
}

