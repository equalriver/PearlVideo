//
//  PVExchangeModels.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/6.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

//MARK: - 市场信息
class PVExchangeInfoModel: PVBaseModel {
    ///最低价
    var minPrice = 0.0
    
    ///最高价
    var maxPrice = 0.0
    
    ///涨跌幅度
    var rateOfChange = 0.0
    
    ///累计成交量
    var totalVolume = 0.0
    
    ///当前买单
    var bidOrderCount = 0
    
    ///当前卖单
    var askOrderCount = 0

    
    override func mapping(map: Map) {
        minPrice <- map["minPrice"]
        maxPrice <- map["maxPrice"]
        rateOfChange <- map["rateOfChange"]
        totalVolume <- map["totalVolume"]
        bidOrderCount <- map["bidOrderCount"]
        askOrderCount <- map["askOrderCount"]
    }
    
}

//MARK: - 市场信息列表
class PVExchangeOrderList: PVBaseModel {
    ///订单号
    var orderId = ""
    
    ///订单类型
    var type = ""
    
    ///订单状态,1等待交易 2交易中 3完成 4取消
    var status = 0
    
    ///数量
    var count = 0
    
    ///单价
    var price = 0.0
    
    ///订单总金额
    var totalPrice = 0.0
    
    var createAt = ""
    
    ///更新时间
    var updateAt = ""
    
    var userId = ""
    
    var nickname = ""
    
    var avatarURL = ""
//    acctId    String    Y    偏移量
    
    override func mapping(map: Map) {
        orderId <- map["orderId"]
        type <- map["type"]
        status <- map["status"]
        count <- map["quantity"]
        price <- map["priceInCny"]
        totalPrice <- map["orderPriceInCny"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        userId <- map["userId"]
        nickname <- map["userNickName"]
        avatarURL <- map["userAvatar"]
        
    }
    
}

//MARK: - 准备接单
class PVExchangeReadyAcceptOrderModel: PVBaseModel {
    ///订单类型
    var orderType = 0
    
    ///账户可用数量
    var amountAvailable = 0.0
    
    var price = 0.0
    
    ///订单数量
    var count = 0
    
    ///订单总价
    var totalPrice = 0.0
    
    ///支付方式
    var paymentMethod = ""
    
    
    override func mapping(map: Map) {
        orderType <- map["orderType"]
        amountAvailable <- map["amountAvailable"]
        price <- map["price"]
        count <- map["amount"]
        totalPrice <- map["totalPrice"]
        paymentMethod <- map["paymentMethod"]
    }
    
}


//MARK: - 交易记录列表
enum PVExchangeRecordOrderType: String {
    case none = ""
    ///买单
    case buy = "BID"
    ///卖单
    case sell = "ASK"
}

enum PVExchangeRecordListType: String {
    case none = ""
    ///买单
    case buy = "BID"
    ///卖单
    case sell = "ASK"
    ///交换中
    case exchanging = "TRADING"
    ///已完成
    case finish = "COMPLETED"
}

enum PVExchangeRecordListState: String {
    
    case none = ""
    
    ///等待匹配
    case waitForBuyerPay = "WAIT_MATCHING"
    ///等待支付
    case waitForPay = "WAIT_PAYING"
    ///等待发放平安果
    case waitForFruit = "WAIT_DELIVERING"
    
    case success = "SUCCESS"
    
    case fail = "FAIL"
    
    case cancel = "CANCEL"
}

class PVExchangeRecordList: PVBaseModel {
    
    var orderId = ""
    
    var userId = ""
    
    var nickname = ""
    
    var avatarURL = ""
    
    var count = 0
    
    var totalPrice = 0.0
    
    var price = 0.0
    
    ///订单时间
    var date = ""

    ///订单状态
    var state = PVExchangeRecordListState.none

    var orderType = PVExchangeRecordOrderType.none
    
    
    override func mapping(map: Map) {
        orderId <- map["orderId"]
        userId <- map["userId"]
        nickname <- map["userNickName"]
        avatarURL <- map["userAvatar"]
        count <- map["quantity"]
        totalPrice <- map["totalPrice"]
        price <- map["unitPrice"]
        date <- map["date"]
        state <- map["orderStatus"]
        orderType <- map["orderType"]
    }
    
}

//MARK: - 交易记录详情
class PVExchangeRecordDetailModel: PVBaseModel {
    
    var orderId = ""
    
    var userId = ""
    
    var nickname = ""
    
    var name = ""
    
    var phone = ""
    
    var alipayAccount = ""
    
    var avatarURL = ""
    
    var count = 0
    
    var totalPrice = 0.0
    
    var price = 0.0
    
    ///订单创建时间
    var createAt = 0
    
    ///订单状态
    var state = PVExchangeRecordListState.none
    
    ///订单过期剩余时间（秒）
    var leftTime = 0
    
    ///支付图片地址
    var payImageUrl = ""
    
//    orderType    String    Y    订单类型 BID, ASK
   
    
    
    override func mapping(map: Map) {
        orderId <- map["orderId"]
        userId <- map["userId"]
        nickname <- map["oppNickName"]
        name <- map["oppRealName"]
        phone <- map["oppMobile"]
        alipayAccount <- map["oppAliyunAccount"]
        avatarURL <- map["userAvatar"]
        count <- map["quantity"]
        totalPrice <- map["totalPrice"]
        price <- map["unitPrice"]
        createAt <- map["createAt"]
        state <- map["orderStatus"]
        leftTime <- map["expireSeconds"]
        payImageUrl <- map["paymentImageUrl"]
    }
    
}


//MARK: - 发单
class PVExchangeSendOrderModel: PVBaseModel {
    
    var minPrice = 0.0
    
    var maxPrice = 0.0
    
    var alipayAccount = ""
    ///手续费
    var feeRatio = 0
    
    override func mapping(map: Map) {
        minPrice <- map["minPrice"]
        maxPrice <- map["maxPrice"]
        alipayAccount <- map["alipayAccount"]
        feeRatio <- map["feeRatio"]
    }
    
}
