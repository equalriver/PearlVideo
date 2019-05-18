//
//  YPJStringTools.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

import CommonCrypto


public struct YPJStringTools<T>: YPJToolable {
    
    public let ypj: T
    
    public init(target: T) {
        self.ypj = target
    }
}

extension String: YPJToolable {
    
    public var ypj: YPJStringTools<String> {
        return YPJStringTools.init(target: self)
    }
}

extension YPJStringTools where YPJToolType == String {
    
    ///获取string高度
    func getStringHeight(font: UIFont, width: CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: width, height: 900)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize.height
    }
    
    ///获取string宽度
    func getStringWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize.width
    }
    
    ///获取string  size
    func getStringSize(font: UIFont, height: CGFloat) -> CGSize {
        let statusLabelText: NSString = ypj as NSString
        let size = CGSize.init(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
        return strSize
    }
    
    ///汉字转拼音(耗性能，谨慎使用)
    func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: ypj)
        //先转换为带声调的拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //再转换为不带声调的拼音
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        //返回小写拼音
        let string = String(mutableString).lowercased()
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    ///json转字典
    func getDictionaryFromJSONString() -> Dictionary<String, Any> {
        
        let jsonData: Data = ypj.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary
        }
        return Dictionary()
        
    }
    
    //MARK: - MD5
    ///MD5
    var MD5: String {
        let str = ypj.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(ypj.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return hash as String
    }
    
    //url to utf-8
    ///url to utf-8
    var URL_UTF8_string: String! {
        return ypj.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 判断字符串中是否有中文
    var isIncludeChinese: Bool {
        for ch in ypj.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    ///是否全中文
    var isAllChinese: Bool {
        let pattern = "(^[\\u4e00-\\u9fa5]+$)"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///判断字符串中是否为全数字
    var isAllNumber: Bool {
        let pattern = "[0-9]*"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///判断字符中是否包含表情
    var isIncludeEmoji: Bool {
        
        for scalar in ypj.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF:  // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    ///匹配邮箱
    var isEmail: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配手机号
    var isPhoneNumber: Bool {
        let pattern = "^1+[0-9]+\\d{9}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户密码6-18位数字和字母组合
    var isPassword: Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户姓名,20位的中文或英文
    var isUserName: Bool {
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///匹配URL
    var isURLString: Bool {
        let pattern = "^[0-9A-Za-z]{1,50}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: ypj)
    }
    
    ///sha-256
    var sha256: String {
        func digest(input : NSData) -> NSData {
            let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
            var hash = [UInt8](repeating: 0, count: digestLength)
            CC_SHA256(input.bytes, UInt32(input.length), &hash)
            return NSData(bytes: hash, length: digestLength)
        }
        
        func hexStringFromData(input: NSData) -> String {
            var bytes = [UInt8](repeating: 0, count: input.length)
            input.getBytes(&bytes, length: input.length)
            
            var hexString = ""
            for byte in bytes {
                hexString += String(format:"%02x", UInt8(byte))
            }
            
            return hexString
        }
        
        if let stringData = ypj.data(using: .utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    
}
