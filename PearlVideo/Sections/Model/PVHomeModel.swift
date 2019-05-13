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
//    {
//        "id": 3,
//        "imageUrl": "http://content.zyunx.net/image/default/1DC9946BDA9B413D8DDA6C59AD324C47-6-2.png",
//        "sequence": 3,
//        "status": 1,
//        "url": "http://content.zyunx.net/image/default/1DC9946BDA9B413D8DDA6C59AD324C47-6-2.png"
//    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        imageUrl <- map["imageUrl"]
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
