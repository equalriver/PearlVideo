//
//  PVBaseWMPageVC.swift


import UIKit
import WMPageController

class PVBaseWMPageVC: WMPageController {
    
    public let naviBar = PVNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
    
    
    public var isNeedBackButton = false 
    
    override var title: String? {
        willSet{
            if newValue != nil { naviBar.naviTitle = newValue! }
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(naviBar)
        naviBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        naviBar.naviTitle = title ?? ""
        if isNeedBackButton == true {
            
            for v in naviBar.subviews {
                if v.tag == naviBackButtonTag {
                    v.isHidden = false
                    return
                }
            }
            
            //添加默认返回按钮
            let b = UIButton.init()
            b.tag = naviBackButtonTag
            //            b.setImage(#imageLiteral(resourceName: "bxb_返回_黑"), for: .normal)
            naviBar.leftBarButtons = [b]
            
        }
        else{
            for v in naviBar.subviews {
                if v.tag == naviBackButtonTag { v.isHidden = true }
            }
        }
        view.bringSubviewToFront(naviBar)
    }
    
}


extension PVBaseWMPageVC: PVNavigationButtonDelegate {
    
    @objc func leftButtonsAction(sender: UIButton) {
        if sender.tag == naviBackButtonTag {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightButtonsAction(sender: UIButton) {
        
    }
    
    
}

