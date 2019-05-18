//
//  PVBaseNavigationVC.swift


import UIKit

class PVBaseNavigationVC: PVBaseViewController {
    
    public let naviBar = PVNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
    
    override var title: String? {
        willSet{
            if newValue != nil { naviBar.naviTitle = newValue! }
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        view.addSubview(naviBar)
        naviBar.delegate = self
        //在naviBar中设置由于naviBar未布局完成，导致button不可用
        if naviBar.isNeedBackButton { naviBar.leftBarButtons = [naviBar.backBtn] }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        naviBar.naviTitle = title ?? ""
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
