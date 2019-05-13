//
//  PVNetworkValidate.swift


import Alamofire
import SwiftyJSON

//验证
extension DataRequest {
    var acceptableStatusCodes: [Int] { return Array(200..<300) }
    
    func validateInternal(data: Data?) -> ValidationResult {
        
        guard let data = data, data.count > 0 else { return .success }
        
        do {
            let json = try JSON(data: data)
            
            if json["code"].stringValue == "S" {
                return .success
            }
            else {
                return .failure(PVError.networkError(message: json["msg"].stringValue))
            }
            
        }catch{
            
            print(error.localizedDescription)
            return .failure(PVError.networkError(message: "咦～竟然失败了"))
        }
        
    }
    
    @discardableResult
    public func validateInternal() -> Self {
        return validate { [unowned self] _, response, data in
            return self.validateInternal(data: data)
        }
    }
    
    @discardableResult
    public func validate() -> Self {
        
        return validate(statusCode: self.acceptableStatusCodes).validateInternal()
        
    }
    
}

//error
enum PVError: Error {
    case networkError(message: String?)
}

extension PVError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return message ?? "网络出错了，请稍后再试"
        }
    }
}

