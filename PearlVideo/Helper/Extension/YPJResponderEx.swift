//
//  YPJResponderEx.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/17.
//  Copyright © 2019 equalriver. All rights reserved.
//

private weak var ypj_currentFirstResponder: AnyObject?

extension UIResponder {
    
    ///获取当前第一响应者
    static func ypj_firstResponder() -> AnyObject? {
        ypj_currentFirstResponder = nil
        // 通过将target设置为nil，让系统自动遍历响应链
        // 从而响应链当前第一响应者响应我们自定义的方法
        UIApplication.shared.sendAction(#selector(ypj_findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return ypj_currentFirstResponder
    }
    
    ///让当前第一响应者取消响应
    static func ypj_resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func ypj_findFirstResponder(_ sender: AnyObject) {
        // 第一响应者会响应这个方法，并且将静态变量设置为自己
        ypj_currentFirstResponder = self
    }
    
    
}
