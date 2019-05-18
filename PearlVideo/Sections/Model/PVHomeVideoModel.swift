//
//  PVHomeVideoModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper


class PVHomeVideoModel: PVBaseModel {
    
    ///点赞数量
    var commentCount = 0
    
    ///封面图
    var coverUrl = ""
    
    ///创建时间
    var creationTime = ""
    
    ///用户昵称
    var nickname = ""
    
    ///点赞数量
    var thumbCount = 0
    
    ///标题
    var title = ""
    
    ///用户头像
    var avatarUrl = ""
    
    ///用户ID
    var userId = ""
    
    ///视频ID
    var videoId = ""
    
    
    override func mapping(map: Map) {
        commentCount <- map["commentCount"]
        coverUrl <- map["coverUrl"]
        creationTime <- map["creationTime"]
        nickname <- map["nickname"]
        thumbCount <- map["thumbCount"]
        title <- map["title"]
        avatarUrl <- map["avatarUrl"]
        userId <- map["userId"]
        videoId <- map["videoId"]
    }
    
}

