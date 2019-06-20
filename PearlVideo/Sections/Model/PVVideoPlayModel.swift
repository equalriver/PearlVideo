//
//  PVVideoPlayModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

enum PVVideoType: Int {
    ///推荐
    case recommend = 1
    
    ///关注
    case attention = 2
    
    ///我的作品
    case production = 3
    
    ///我的喜欢视频
    case like = 4
    
    ///私密视频
    case security = 5
}

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
    var isFollowed = false
    
    ///是否点赞
    var isThumbuped = false
    
    ///是否是私密
    var isPrivacy = false
    
    ///视频url
    var videoURL = ""
    

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
        isFollowed <- map["isFollowed"]
        isThumbuped <- map["isThumbuped"]
        isPrivacy <- map["isPrivacy"]
        videoURL <- map["videoUrl"]
    }
    
}
