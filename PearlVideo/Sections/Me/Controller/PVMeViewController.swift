//
//  PVMeViewController.swift


import UIKit
import ObjectMapper

class PVMeViewController: PVBaseWMPageVC {
    
    var isShowMoreList = false {
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.forceLayoutSubviews()
            }
        }
    }
    
    
    lazy var settingBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_设置"), for: .normal)
        return b
    }()
    lazy var badgeView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.red
        v.layer.cornerRadius = 2.5
        v.layer.masksToBounds = true
        return v
    }()
    lazy var messageBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_msg"), for: .normal)
        b.addSubview(badgeView)
        badgeView.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize.init(width: 5, height: 5))
            make.top.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(5)
        })
        b.isHidden = true
        return b
    }()
    lazy var shareBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_share"), for: .normal)
        return b
    }()
    lazy var headerView: PVMeHeaderView = {
        let v = PVMeHeaderView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    

    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isNeedBackButton = false
//        title = "我的"
        view.backgroundColor = UIColor.white
        titleColorNormal = kColor_subText!
        titleColorSelected = kColor_text!
        menuViewStyle = .line
        //FIX ME: layoutSubviews ?
        menuView?.progressView.layer.contents = UIImage.init(named: "gradient_bg")?.cgImage
        
        naviBar.rightBarButtons = [shareBtn, messageBtn]
        naviBar.leftBarButtons = [settingBtn]
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 330 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }


}

