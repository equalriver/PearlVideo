//
//  PVBaseViewController.swift


import Foundation
import UIKit


class PVBaseViewController: UIViewController {
    
    public var isNeedReloadData = false

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        
        //主题更改
        NotificationCenter.default.addObserver(self, selector: #selector(themeColorChange), name: .kNotiName_themeColorChange, object: nil)
        //token过期重新登录刷新页面
        NotificationCenter.default.addObserver(self, selector: #selector(pageRefresh), name: .kNotiName_pageRefreshByToken, object: nil)
    }
    
    
    
    @objc func themeColorChange() {
        view.setNeedsDisplay()
    }
    
    @objc func pageRefresh() {
        isNeedReloadData = true
    }
 
    deinit {
        NotificationCenter.default.removeObserver(self, name: .kNotiName_themeColorChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: .kNotiName_pageRefreshByToken, object: nil)
     }
}


