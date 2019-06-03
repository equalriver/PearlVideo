//
//  PVMeModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper


class PVMeModel: PVBaseModel {
    ///背景图片
    var backgroundImageUrl = ""
    
    ///是否实名认证
    var isCertification = false
    
    ///星级达人
    var grade = 0
    
    ///昵称
    var nickName = ""
    
    var birthday = ""
    
    var avatarUrl = ""
    
    ///签名
    var autograph = ""
    
    var gender = ""
    
    ///关注数量
    var followCount = 0
    
    ///粉丝数量
    var fansCount = 0
    
    ///用户等级
    var Level = ""
    
    ///卷轴活跃度
    var reelLivenessCount = ""
    
    ///总活跃度
    var LivenessCount = ""
    
    ///平安果
    var pearlToal = ""
    
    ///喜欢视频总数量
    var likeTotal = 0
    
    ///作品总数量
    var videoTotal = 0
    
    ///私密视频数量
    var privacyCount = 0
    
    ///是否关注
    var isFollow = false
    
    ///是否是自己的
    var isMine = false

    override func mapping(map: Map) {
        backgroundImageUrl <- map["backgroundImageUrl"]
        isCertification <- map["isCertification"]
        grade <- map["grade"]
        nickName <- map["nickName"]
        birthday <- map["birthday"]
        avatarUrl <- map["avatarUrl"]
        autograph <- map["autograph"]
        gender <- map["gender"]
        followCount <- map["followCount"]
        fansCount <- map["fansCount"]
        Level <- map["Level"]
        reelLivenessCount <- map["reelLivenessCount"]
        LivenessCount <- map["LivenessCount"]
        pearlToal <- map["pearlToal"]
        likeTotal <- map["likeTotal"]
        videoTotal <- map["videoTotal"]
        privacyCount <- map["privacyCount"]
        isFollow <- map["isFollow"]
        isMine <- map["isMine"]
    }
    
}

//MARK: - video
class PVMeVideoList: PVBaseModel {
    
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
    
    ///标题
    var title = ""
    
    ///用户头像
    var avatarUrl = ""
    
    ///用户ID
    var userId = ""
    
    ///视频ID
    var videoId = ""
    
    ///是否是自己的
    var isMine = false
    
    ///是否删除
    var isDeleted = false
    
    ///是否关注
    var isFollowed = false
    
    ///是否点赞
    var isThumbuped = false
    
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
        isFollowed <- map["isFollowed"]
        isThumbuped <- map["isThumbuped"]
        isPrivacy <- map["isPrivacy"]
    }
    
}

//MARK: - 意见反馈
class PVMeFeedbackList: PVBaseModel {
    
    var id = ""
    
    ///反馈内容
    var content = ""
    
    var status = ""
    
    var type = ""
    
    var createAt = ""
    
    override func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        status <- map["status"]
        type <- map["type"]
        createAt <- map["createAt"]
    }
    
}


//MARK: - 认证状态
class PVMeUserValidateModel: PVBaseModel {
    ///是否认证成功
    var isVerfiedSuccess = false
    
    var idCard = ""
    
    var name = ""
    
    override func mapping(map: Map) {
        isVerfiedSuccess <- map["isVerfiedSuccess"]
        idCard <- map["idNo"]
        name <- map["name"]
    }
    
}
