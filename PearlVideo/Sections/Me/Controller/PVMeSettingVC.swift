//
//  PVMeSettingVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import Kingfisher
import ObjectMapper

class PVMeSettingVC: PVBaseNavigationVC {
    
    var data: PVMeUserValidateModel!
    
    let items_2 = ["实名认证", "修改密码", "交换密码", "收款方式"]
    let items_3 = ["意见反馈", "关于我们", "清理缓存", "检测更新", UserDefaults.standard.value(forKey: kToken) == nil ? "登录" : "退出登录"]
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_background
        tb.separatorStyle = .none
        tb.bounces = false
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        PVNetworkTool.Request(router: .getUserValidateStatus(), success: { (resp) in
            if let d = Mapper<PVMeUserValidateModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.tableView.reloadData()
            }
            
        }) { (e) in
            
        }
    }
    
}


extension PVMeSettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        case 0: return 1
            
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
        var img: UIImage?
        var imgStr = "setting_"
        var title: String?
        var detail: String?
        var detailImg = UIImage.init(named: "right_arrow")
        var isShowBadge = false
        //钱包
        if indexPath.section == 0 {
            img = UIImage.init(named: "setting_钱包")
            detailImg = UIImage.init(named: "setting_复制")
            
        }
        //账号
        if indexPath.section == 1 {
            imgStr += items_2[indexPath.row]
            img = UIImage.init(named: imgStr)
            title = items_2[indexPath.row]
        }
        //通用
        if indexPath.section == 2 {
            imgStr += items_3[indexPath.row] == "登录" ? "退出登录" : items_3[indexPath.row]
            img = UIImage.init(named: imgStr)
            title = items_3[indexPath.row]
            if indexPath.row == 2 {//清理缓存
                detailImg = nil
                let s = YPJOtherTool.ypj.getLocalFolderSize(path: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? "")
                detail = s > 1 ? String.init(format: "%.1f", s) + "M" : nil
                KingfisherManager.shared.cache.calculateDiskCacheSize { (size) in
                    let m = Double(size) / 1024.0 * 1024.0 + s
                    detail = m > 1 ? String.init(format: "%.1f", m) + "M" : nil
                    
                }
            }
            if indexPath.row == 3 {//检测更新
                isShowBadge = true
                if let v = YPJOtherTool.ypj.getCurrentVersion {
                    detail = v + " "
                }
            }
            if indexPath.row == 4 {
                title = UserDefaults.standard.value(forKey: kToken) == nil ? "登录" : "退出登录"
            }
        }
        let cell = PVMeSettingCell.init(img: img, title: title, detail: detail, rightImage: detailImg, showBadge: isShowBadge)
        if indexPath.section == 1 && indexPath.row == 0 {//实名认证
            if data != nil && data.isVerfiedSuccess {
                cell.rightBtn.setTitle("已认证", for: .normal)
                cell.rightBtn.setTitleColor(UIColor.yellow, for: .normal)
            }
        }
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
        //钱包
        if indexPath.section == 0 {
            let paste = UIPasteboard.general
            //FIX ME
            paste.string = ""  //复制到粘贴板
            view.makeToast("复制地址成功")
        }
        //账号
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: //实名认证
                let vc = PVMeNameValidateVC()
                if data != nil && data.isVerfiedSuccess { vc.validateStateData = data }
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 1: //修改密码
                let vc = PVMePasswordChangeVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 2: //交换密码
                let vc = PVMeExchangePsdVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 3: //收款方式
                let vc = PVMePayWayVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            default: break
            }
        }
        //通用
        if indexPath.section == 2 {
            switch indexPath.row {
            case 0: //意见反馈
                let vc = PVMeFeedbackVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 1: //关于我们
                let vc = PVMeAboutVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 2: //清理缓存
                let cache = KingfisherManager.shared.cache
                cache.cleanExpiredDiskCache()
                cache.clearDiskCache {
                    YPJOtherTool.ypj.removeCache()
                    self.view.makeToast("清理完毕")
                    tableView.reloadRow(at: indexPath, with: .none)
                }
                break
                
            case 3: //检测更新
                let vc = PVMeVersionVC()
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case 4: //退出登录
                guard let _ = UserDefaults.standard.value(forKey: kToken) else {
                    YPJOtherTool.ypj.loginValidate(currentVC: self) {[weak self] (isFinish) in
                        if isFinish {
                            self?.tableView.reloadData()
                            NotificationCenter.default.post(name: .kNotiName_refreshMeVC, object: nil)
                        }
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
