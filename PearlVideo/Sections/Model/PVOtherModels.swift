//
//  PVOtherModels.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/31.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper


class PVUploadImageModel: PVBaseModel {
    
    var imageId = ""
    
    var imageUrl = ""
    
    var uploadAddress = ""
    
    var uploadAuth = ""
    
    
    override func mapping(map: Map) {
        imageId <- map["imageId"]
        imageUrl <- map["imageUrl"]
        uploadAddress <- map["uploadAddress"]
        uploadAuth <- map["uploadAuth"]
    }
    
}
