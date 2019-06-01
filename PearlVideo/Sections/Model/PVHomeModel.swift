//
//  PVHomeModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper


class PVHomeModel: PVBaseModel {
    
    var bannerList = Array<PVHomeBannerModel>()
    ///当前收益
    var currentIncome = 0
    ///会员等级
    var level = ""
    
    var noticeList = Array<PVHomeNoticeModel>()
    ///果子总数
    var total = 0
    ///活跃度1
    var activeness_1 = 0
    ///活跃度2
    var activeness_2 = 0
    
    override func mapping(map: Map) {
        bannerList <- map["carouselList"]
        currentIncome <- map["dayPearlCount"]
        level <- map["grade"]
        noticeList <- map["noticeList"]
        total <- map["pearlCount"]
        activeness_1 <- map["volumeLivenessCount"]
        activeness_2 <- map["otherLivenessCount"]
    }
    
}

class PVHomeBannerModel: PVBaseModel {
    
    var id = 0
    var imageUrl = ""
    var url = ""
    var title = ""

    
    override func mapping(map: Map) {
        id <- map["id"]
        imageUrl <- map["imageUrl"]
        url <- map["url"]
        title <- map["title"]
    }
    
}

class PVHomeNoticeModel: PVBaseModel {
    
    var id = 0
    var title = ""
    
    override func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
    
}

class PVVersionModel: PVBaseModel {
    
    var id = 0
    
    ///版本号
    var versionCode = ""
    
    ///更新内容
    var content = ""
    
    var downloadURL = ""
    
    
    
    override func mapping(map: Map) {
        id <- map["id"]
        versionCode <- map["versionCode"]
        content <- map["content"]
        downloadURL <- map["apk_url"]
    }
    
}
