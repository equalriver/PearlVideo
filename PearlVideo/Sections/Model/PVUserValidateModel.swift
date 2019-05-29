//
//  PVUserValidateModel.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/29.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

enum UserValidateStageType: String {
    case success = "STAGE_SUCCESS"
    ///需要支付
    case payment = "STAGE_PAYMENT"
    ///认证中
    case processing = "STAGE_PROCESSING"
}

class PVUserValidateModel: PVBaseModel {
    /// STAGE_SUCCESS = 认证成功  STAGE_PAYMENT = 需要支付  STAGE_PROCESSING = 认证中
    var verifyStage = ""
    
    ///身份证号码
    var idCard = ""
    
    var name = ""

    ///支付信息
    var payOrder = ""
    
    ///认证TOKEN
    var verifyToken = PVUserValidateToken()
    
    
    override func mapping(map: Map) {
        verifyStage <- map["verifyStage"]
        idCard <- map["idNo"]
        name <- map["name"]
        payOrder <- map["payOrder"]
        verifyToken <- map["verifyToken"]
    }
    
}

class PVUserValidateToken: PVBaseModel {
    
    var token = ""
    
    ///过期时间
    var durationSeconds = 0
    
    override func mapping(map: Map) {
        token <- map["token"]
        durationSeconds <- map["durationSeconds"]
    }
    
}

