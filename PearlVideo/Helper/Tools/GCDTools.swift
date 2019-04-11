//
//  GCDTools.swift


import Foundation


//MARK: - dispatch_once_t
///dispatch_once_t
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func ypj_once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
