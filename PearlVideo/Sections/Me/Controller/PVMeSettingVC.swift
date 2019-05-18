//
//  PVMeSettingVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import Kingfisher

class PVMeSettingVC: PVBaseNavigationVC {
    
    let items_1 = ["实名认证", "修改密码", "交易密码"]
    let items_2 = ["用户协议", "隐私政策", "意见反馈"]
    let items_3 = ["清理缓存", "关于我们", "检测更新", UserDefaults.standard.value(forKey: kToken) == nil ? "登录" : "退出登录"]
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.isScrollEnabled = false
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.bottom.centerX.equalToSuperview()
        }
        
    }


}


extension PVMeSettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0: return items_1.count
            
        case 1: return items_2.count
            
        default: return items_3.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var img = "setting_"
        var title = ""
        var detail: String?
        var isShowBadge = false
        
        if indexPath.section == 0 {
            img += items_1[indexPath.row]
            title = items_1[indexPath.row]
        }
        if indexPath.section == 1 {
            img += items_2[indexPath.row]
            title = items_2[indexPath.row]
        }
        if indexPath.section == 2 {
            img += items_3[indexPath.row] == "登录" ? "退出登录" : items_3[indexPath.row]
            title = items_3[indexPath.row]
            if indexPath.row == 0 {//清理缓存
                let s = YPJOtherTool.ypj.getLocalFolderSize(path: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? "")
                detail = s > 1 ? String.init(format: "%.1f", s) + "M" : nil
                KingfisherManager.shared.cache.calculateDiskCacheSize { (size) in
                    let m = Double(size) / 1024.0 * 1024.0 + s
                    detail = m > 1 ? String.init(format: "%.1f", m) + "M" : nil
                }
            }
            if indexPath.row == 2 {//检测更新
                isShowBadge = true
                detail = nil
            }
        }
        let cell = PVMeSettingCell.init(img: img, title: title, detail: detail, showBadge: isShowBadge)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func loginValidate(_ handler: () -> Void) {
            guard let _ = UserDefaults.standard.value(forKey: kToken) else {

                view.makeToast("未登录")
                return
            }
            handler()
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {//实名认证
                loginValidate {
                    let vc = PVMeNameValidateVC()
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            if indexPath.row == 1 {//修改密码
                loginValidate {
                    let vc = PVMePasswordChangeVC()
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: //用户协议
                let vc = PVAgreementWebVC.init(url: "", title: "用户协议")
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 1: //隐私政策
                let vc = PVAgreementWebVC.init(url: "", title: "隐私政策")
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 2: //意见反馈
                let vc = PVMeFeedbackVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            default: break
            }
        }
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0: //清理缓存
                let cache = KingfisherManager.shared.cache
                cache.cleanExpiredDiskCache()
                cache.clearDiskCache {
                    YPJOtherTool.ypj.removeCache()
                    self.view.makeToast("清理完毕")
                    tableView.reloadRow(at: indexPath, with: .none)
                }
                break
                
            case 1: //关于我们
                let vc = PVAgreementWebVC.init(url: "", title: "关于我们")
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 2: //检测更新
                
                break
                
            case 3: //退出登录
                guard let _ = UserDefaults.standard.value(forKey: kToken) else {
                    YPJOtherTool.ypj.loginValidate(currentVC: self) {[weak self] (isFinish) in
                        if isFinish { self?.tableView.reloadData() }
                    }
                    return
                }
                YPJOtherTool.ypj.showAlert(title: nil, message: "确定退出登录吗？", style: .alert, isNeedCancel: true) { (ac) in
                    UserDefaults.standard.set(nil, forKey: kToken)
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: .kNotiName_refreshMeVC, object: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }
                break
                
            default: break
            }
            
        }
    }
}
