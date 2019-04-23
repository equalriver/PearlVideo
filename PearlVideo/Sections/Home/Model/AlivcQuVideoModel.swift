//
//  AlivcQuVideoModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/18.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

/**
 视频的抽象状态
 
 - AlivcQuVideoAbstractionStatus_On: 进行中
 - AlivcQuVideoAbstractionStatus_Success: 成功
 - AlivcQuVideoAbstractionStatus_Fail: 失败
 */
enum AlivcQuVideoAbstractionStatus: Int {
    case on = 0
    case success
    case fail
}

class AlivcQuVideoModel: PVBaseModel {
    
    ///数据库自动递增的标识
    public private(set) var id = ""
    
    ///视频标题
    public private(set) var title = ""
    
    ///视频id
    public private(set) var videoId = ""
    
    ///视频描述
    public private(set) var videoDescription = ""
    
    ///视频时长（秒）
    public private(set) var durationString: String?
    
    ///视频封面URL
    public private(set) var coverUrl = ""
    
    ///首帧地址
    public private(set) var firstFrameUrl: String?
    
    ///视频源文件大小（字节）
    public private(set) var sizeString = ""
    
    ///视频标签,多个用逗号分隔
    public private(set) var tags = ""
    
    ///视频分类
    public private(set) var cateId = ""
    
    ///视频分类名称
    public private(set) var cateName = ""
    
    ///创建时间-字符串的原始数据
    public private(set) var creationTimeString = ""
    
    ///转码状态 - onTranscode（转码中），success（转码成功），fail（转码失败）
    public private(set) var transcodeStatusString = ""
    
    ///截图状态 - onSnapshot（截图中），success（截图成功），fail（截图失败）
    public private(set) var snapshotStatusString = ""
    
    ///审核状态 - onCensor（审核中），success（审核成功），fail（审核不通过）
    public private(set) var censorStatusString = ""
    
    ///窄带高清转码状态 - onTranscode（转码中），success（转码成功），fail（转码失败） ps:窄带高清也是一种特殊的转码
    public private(set) var narrowTranscodeStatusString = ""
    
    ///所属的用户
    public private(set) var user = AlivcQuVideoUserInfoModel()
    
    
    //二次包装 - 基于原始数据
    ///视频时长（秒）
    public private(set) var duration = 0
    
    ///封面图 - 内部不会请求，由使用者自己管理
    public var coverImage: UIImage?
    
    ///首帧图 - 内部不会请求，由使用者自己管理
    public var firstFrameImage: UIImage?
    
    ///创建时间
    public private(set) var creationDate = Date()
    
    ///所属的用户的头像
    public var belongUserAvatarImage: UIImage?
    
    ///转码状态 - onTranscode（转码中），success（转码成功），fail（转码失败）
    public private(set) var transcodeStatus = AlivcQuVideoAbstractionStatus.on
    
    ///截图状态 - onSnapshot（截图中），success（截图成功），fail（截图失败）
    public private(set) var snapshotStatus = AlivcQuVideoAbstractionStatus.on
    
    ///审核状态 - assign（审核中），success（审核成功），fail（审核不通过）
    public private(set) var censorStatus = AlivcQuVideoAbstractionStatus.on
    
    ///窄带高清转码状态 - onTranscode（转码中），success（转码成功），fail（转码失败） ps:窄带高清也是一种特殊的转码
    public private(set) var narrowTranscodeStatus = AlivcQuVideoAbstractionStatus.on
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        videoId <- map["videoId"]
        videoDescription <- map["description"]
        durationString <- map["duration"]
        coverUrl <- map["coverUrl"]
        firstFrameUrl <- map["firstFrameUrl"]
        sizeString <- map["size"]
        tags <- map["tags"]
        cateId <- map["cateId"]
        cateName <- map["cateName"]
        creationTimeString <- map["creationTime"]
        transcodeStatusString <- map["transcodeStatus"]
        snapshotStatusString <- map["snapshotStatus"]
        censorStatusString <- map["censorStatus"]
        narrowTranscodeStatusString <- map["narrowTranscodeStatus"]
        user <- map["user"]
        
        handleOriginalData()
    }
    
    private func handleOriginalData() {
        if durationString != nil {
            duration = Int(durationString!) ?? 0
        }
        transcodeStatus = statusWithString(statusString: transcodeStatusString)
        snapshotStatus = statusWithString(statusString: snapshotStatusString)
        censorStatus = statusWithString(statusString: censorStatusString)
        narrowTranscodeStatus = statusWithString(statusString: narrowTranscodeStatusString)
    }
    
    private func statusWithString(statusString: String) -> AlivcQuVideoAbstractionStatus {
        if statusString == "success" { return .success }
        if statusString == "fail" { return .fail }
        if statusString == "check" { return .on }//如果是待审核的状态，客户端也是审核中的状态
        return .on
    }
  
}

class AlivcQuVideoUserInfoModel: PVBaseModel {
    
    ///所属的用户id
    public private(set) var belongUserId: String?
    
    ///所属的用户名
    public private(set) var belongUserName: String?
    
    ///所属的用户的头像URL
    public private(set) var belongUserAvatarUrl: String?
    
  
    override func mapping(map: Map) {
        belongUserId <- map["userId"]
        belongUserName <- map["userName"]
        belongUserAvatarUrl <- map["avatarUrl"]
    }
    
}



