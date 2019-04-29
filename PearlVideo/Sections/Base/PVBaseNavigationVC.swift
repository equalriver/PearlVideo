//
//  PVBaseNavigationVC.swift


import UIKit

class PVBaseNavigationVC: PVBaseViewController {
    
    public let naviBar = PVNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
    
    ///默认显示返回
    public var isNeedBackButton = true
    
    override var title: String? {
        willSet{
            if newValue != nil { naviBar.naviTitle = newValue! }
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(naviBar)
        naviBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        naviBar.naviTitle = title ?? ""
        if isNeedBackButton == true {
            
            for v in naviBar.subviews {
                guard v is UIStackView else { continue }
                
                let sv = v as! UIStackView
                for sub in sv.arrangedSubviews {
                    if sub.tag == naviBackButtonTag {
                        sub.isHidden = false
                        return
                    }
                }
                
            }
            
            //添加默认返回按钮
            let b = UIButton.init()
            b.tag = naviBackButtonTag
            b.setImage(UIImage.init(named: "back_black"), for: .normal)
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


extension PVBaseNavigationVC: PVNavigationButtonDelegate {
    
    @objc func leftButtonsAction(sender: UIButton) {
        if sender.tag == naviBackButtonTag {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightButtonsAction(sender: UIButton) {
        
    }
    
    
}
