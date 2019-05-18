//
//  PVHomeOtherModels.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

//MARK: - 会员等级
class PVHomeUserLevelModel: PVBaseModel {
    
    ///等级
    var level = ""
    
    ///经验值
    var expToal = 0
    
    ///还差多少经验值
    var differExpNum = 0
    
    var levelList = Array<PVHomeUserLevelList>()
    
    override func mapping(map: Map) {
        level <- map["level"]
        expToal <- map["expToal"]
        differExpNum <- map["differExpNum"]
        levelList <- map["levelList"]
    }
    
}

class PVHomeUserLevelList: PVBaseModel {
    
    ///等级ID
    var id = 0
    
    var name = ""
    
    ///等级
    var level = 0
    
    ///是否完成实名认证用户
    var expDes = ""
    
    ///手续费
    var fee = 0
    
    ///手续费详情
    var feeDes = ""
    
    ///创建时间
    var creatAt = ""
    
    ///经验值
    var expValue = 0
  
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        level <- map["level"]
        expDes <- map["expDes"]
        fee <- map["fee"]
        feeDes <- map["feeDes"]
        creatAt <- map["creatAt"]
        expValue <- map["expValue"]
    }
}

//MARK: - 活跃度
class PVHomeActivenessModel: PVBaseModel {
    
    ///卷轴活跃度
    var volumeLivenessCount = 0.0
    
    ///其他活跃度
    var otherLivenessCount = 0.0
    
    var livenessDetailList = Array<PVHomeActivenessList>()
    
    
    override func mapping(map: Map) {
        volumeLivenessCount <- map["volumeLivenessCount"]
        otherLivenessCount <- map["otherLivenessCount"]
        livenessDetailList <- map["livenessDetailList"]
    }
}

class PVHomeActivenessList: PVBaseModel {
    
    var userId = ""
    
    var title = ""
    
    ///活跃度
    var liveness = 0
    
    ///创建时间
    var createAt = ""
    
    override func mapping(map: Map) {
        userId <- map["userId"]
        title <- map["title"]
        liveness <- map["liveness"]
        createAt <- map["createAt"]
    }
}


//MARK: - 平安果
class PVHomeFruitModel: PVBaseModel {
    
    ///平安果总数
    var pearlCount = 0.0

    var pearlDetail = Array<PVHomeFruitList>()
    
    
    override func mapping(map: Map) {
        pearlCount <- map["pearlCount"]
        pearlDetail <- map["pearlDetail"]
    }
}

class PVHomeFruitList: PVBaseModel {
    
    var userId = ""
    
    var title = ""
    
    ///平安果数量
    var pearlCost = 0.0
    
    ///创建时间
    var createAt = ""
    
    override func mapping(map: Map) {
        userId <- map["userId"]
        title <- map["title"]
        pearlCost <- map["pearlCost"]
        createAt <- map["createAt"]
    }
}

//MARK: - 商学院
//视频区
class PVHomeSchoolVideoList: PVBaseModel {
    
    var videoId = ""
    
    ///封面图片
    var coverUrl = ""
    
    var title = ""
    
    ///发布时间
    var createAt = ""
    
    override func mapping(map: Map) {
        videoId <- map["videoId"]
        coverUrl <- map["coverUrl"]
        title <- map["title"]
        createAt <- map["createAt"]
    }
}

//新手指南
class PVHomeSchoolGuideList: PVBaseModel {
    
    var title = ""
    
    ///发布时间
    var createAt = ""
    
    var url = ""
    
    var status = 0
    
    ///作者
    var author = ""
    
    override func mapping(map: Map) {
        title <- map["title"]
        createAt <- map["createAt"]
        url <- map["url"]
        status <- map["status"]
        author <- map["author"]
    }
}

//MARK: - 任务书卷
class PVHomeTaskList: PVBaseModel {
    
    var id = 0
    
    var name = ""
    
    var content = ""
    
    ///类别
    var category = 0
    
    ///总收益
    var total = 0
    
    ///活跃度
    var liveness = ""
    
    ///交换数量
    var exchangeCount = 0
    
    ///创建时间戳
    var createAt = ""
    
    ///结束时间戳
    var endAt = ""
    
    ///开始时间
    var startTime = ""
    
    ///结束时间
    var endTime = ""
    
    var userId = ""
    
    ///等级
    var grade = 0
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        content <- map["content"]
        category <- map["category"]
        total <- map["total"]
        liveness <- map["liveness"]
        exchangeCount <- map["exchangeCount"]
        createAt <- map["createAt"]
        endAt <- map["endAt"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        userId <- map["userId"]
        grade <- map["grade"]
        
    }
}

//MARK: - 团队
class PVHomeTeamModel: PVBaseModel {
    
    ///团队人数
    var userTeamCount = 0
    
    ///小区活跃度
    var smallLivenessCount = 0.0
    
    ///大区活跃度
    var bigLivenessCount = 0.0
    
    ///团队总活跃度
    var userTeamLivenessCount = 0.0
    
    ///推荐人名字
    var name = ""
    
    var avatarImageUrl = ""
    
    override func mapping(map: Map) {
        userTeamCount <- map["userTeamCount"]
        smallLivenessCount <- map["smallLivenessCount"]
        bigLivenessCount <- map["bigLivenessCount"]
        userTeamLivenessCount <- map["userTeamLivenessCount"]
        name <- map["name"]
        avatarImageUrl <- map["avatarImageUrl"]
    }
}

//MARK: - 全部队员
class PVHomeTeamList: PVBaseModel {
    
    ///团队人数
    var total = 0
    
    ///活跃度
    var livenessCount = 0.0
    
    ///团队活跃度
    var teamLienessCount = 0.0
    
    ///1表示实名认证 2未实名认证
    var type = 0
    
    var avatarImageUrl = ""
  
    
    override func mapping(map: Map) {
        total <- map["total"]
        livenessCount <- map["livenessCount"]
        teamLienessCount <- map["teamLienessCount"]
        type <- map["type"]
        avatarImageUrl <- map["avatarImageUrl"]
    }
}

//MARK: - 消息
class PVHomeMessageList: PVBaseModel {
    
    var id = 0
    
    var content = ""
    
    var url = ""
    
    ///创建时间
    var createAt = ""
    
    var title = ""
    
    ///用户id
    var user_id = ""
    
    ///类别
    var category = ""
    
    ///点赞/评论/关注用户Id
    var senderId = ""
    
    ///点赞/评论/关注用户头像
    var senderAvatarUrl = ""
    
    ///点赞/评论/关注用户昵称
    var senderNickname = ""
    
    ///点赞/评论/关注视频略图
    var videoThumbnailUrl = ""
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        url <- map["url"]
        createAt <- map["createAt"]
        title <- map["title"]
        user_id <- map["user_id"]
        category <- map["category"]
        senderId <- map["senderId"]
        senderAvatarUrl <- map["senderAvatarUrl"]
        senderNickname <- map["senderNickname"]
        videoThumbnailUrl <- map["videoThumbnailUrl"]
    }
}

//通知
class PVHomeNoticeMessageList: PVBaseModel {
    
    var id = 0
    
    var content = ""
    
    var url = ""
    
    ///创建时间
    var createAt = ""
    
    var title = ""
    
    ///头像
    var senderAvatarUrl = ""
    
    override func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        url <- map["url"]
        createAt <- map["createAt"]
        senderAvatarUrl <- map["senderAvatarUrl"]
    }
}
