//
//  PVVideoCommentModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/21.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

//MARK: - 评论
class PVVideoCommentModel: PVBaseModel {
    ///评论id
    var id = 0
    
    ///评论内容
    var content = ""
    
    var videoId = ""
    
    var userId = ""
    
    ///父Id
    var parentId = 0
    
    var createAt = ""
    
    ///评论点赞总数
    var commentThumbupCount = 0
    
    ///回复点赞总数
    var replyThumbCount = 0
    
    ///回复数量
    var replyCount = 0
    
    var avatarUrl = ""
    
    var nickname = ""
    
    ///当前用户在评论上是否点赞 1 点赞 2没点赞
    var status = 0
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        videoId <- map["videoId"]
        userId <- map["userId"]
        parentId <- map["parentId"]
        createAt <- map["createAt"]
        commentThumbupCount <- map["commentThumbupCount"]
        replyThumbCount <- map["replyThumbCount"]
        replyCount <- map["replyCount"]
        avatarUrl <- map["avatarUrl"]
        nickname <- map["nickname"]
        status <- map["status"]
    }
    
}

//MARK: - 分享
class PVVideoShareModel: PVBaseModel {
    ///评论id
    var userId = ""
    
    var avatarImageUrl = ""
   
    var nickname = ""
    
    ///状态
    var certificationStatus = 0
    
    var createAt = ""
    
    
    override func mapping(map: Map) {
        userId <- map["userId"]
        avatarImageUrl <- map["avatarImageUrl"]
        nickname <- map["nickname"]
        certificationStatus <- map["certificationStatus"]
        createAt <- map["createAt"]
    }
    
}


