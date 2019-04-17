//
//  PVUserInfoModel.swift


import Foundation
import ObjectMapper


class PVUserInfoModel: PVBaseModel {
    
    var userId = ""
    var name = ""
    var phone = ""
    var address = ""
    var icon = ""
    var email = ""
    ///Female  Male
    var sex = ""
    var birthday = ""
    
    ///部门
    var dep = ""
    var company = ""
    ///职位
    var positions = Array<UserInfoPositionsModel>()
    
    
    override func mapping(map: Map) {
        userId <- map["userId"]
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        icon <- map["icon"]
        email <- map["email"]
        sex <- map["sex"]
        birthday <- map["birthday"]
        dep <- map["dep"]
        company <- map["company"]
        positions <- map["positions"]
        
    }
    
}


class UserInfoPositionsModel: PVBaseModel {
    
    var name = ""
    ///职位id
    var groupId = ""
    
    
    override func mapping(map: Map) {
        name <- map["name"]
        groupId <- map["groupId"]
    }
    
}
