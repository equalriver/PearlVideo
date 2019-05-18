//
//  PVVideoPlayModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

class PVVideoPlayModel: PVBaseModel {
    
    ///评论数量
    var commentCount = 0
    
    ///封面图
    var coverUrl = ""
    
    ///创建时间
    var creationTime = ""
    
    ///用户昵称
    var nickname = ""
    
    ///点赞数量
    var thumbCount = 0
    
    var title = ""
    
    var avatarUrl = ""
    
    var userId = ""
    
    var videoId = ""
    
    ///是否是我的
    var isMine = false
    
    ///是否删除
    var isDeleted = false
    
    ///是否关注
    var IsFollowed = false
    
    ///是否点赞
    var IsThumbuped = false
    
    ///是否是私密
    var isPrivacy = false
    

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
        isMine <- map["isMine"]
        isDeleted <- map["isDeleted"]
        IsFollowed <- map["IsFollowed"]
        IsThumbuped <- map["IsThumbuped"]
        isPrivacy <- map["isPrivacy"]
    }
    
}
