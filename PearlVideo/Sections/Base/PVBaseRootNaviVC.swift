//
//  PVBaseRootNaviVC.swift


import UIKit

class PVBaseRootNaviVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    
    
    
}
