//
//  PVMeModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper


class PVMeModel: PVBaseModel {
    
    var nickName = ""
    
    var birthday = ""
    
    var avatar_url = ""
    
    ///签名
    var autograph = ""
    
    var gender = ""
    
    ///关注数量
    var followCount = 0
    
    ///粉丝数量
    var fansCount = 0
    
    var Level = ""
    
    ///卷轴活跃度
    var reelLivenessCount = 0.0
    
    ///总活跃度
    var LivenessCount = 0.0
    
    ///平安果
    var pearlToal = 0.0
    
    ///喜欢数量
    var likeTotal = 0
    
    ///视频数量
    var videoTotal = 0
    
    ///关注状态
    var followStatus = ""
    
    ///作品视频
    var videoList = Array<PVMeVideoList>()
    
    ///点赞视频
    var thumbupList = Array<PVMeVideoList>()
    
    ///私密视频
    var privacyList = Array<PVMeVideoList>()
    

    override func mapping(map: Map) {
        nickName <- map["nickName"]
        birthday <- map["birthday"]
        avatar_url <- map["avatar_url"]
        autograph <- map["autograph"]
        gender <- map["gender"]
        followCount <- map["followCount"]
        Level <- map["Level"]
        reelLivenessCount <- map["reelLivenessCount"]
        LivenessCount <- map["LivenessCount"]
        pearlToal <- map["pearlToal"]
        likeTotal <- map["likeTotal"]
        videoTotal <- map["videoTotal"]
        followStatus <- map["followStatus"]
        videoList <- map["videoList"]
        thumbupList <- map["thumbupList"]
        privacyList <- map["privacyList"]
    }
    
}

class PVMeVideoList: PVBaseModel {
    
    var videoId = ""
    
    var title = ""
    
    var status = 0
    
    ///时间
    var createAt = ""
    
    ///播放次数
    var playCount = ""
    
    ///点赞次数
    var thumbCount = ""
    
    ///是否删除
    var isDeleted = 0
  
    override func mapping(map: Map) {
        videoId <- map["videoId"]
        title <- map["title"]
        status <- map["status"]
        createAt <- map["createAt"]
        playCount <- map["playCount"]
        thumbCount <- map["thumbCount"]
        isDeleted <- map["isDeleted"]
    }
    
}
