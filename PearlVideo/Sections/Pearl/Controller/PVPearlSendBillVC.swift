//
//  PVPearlSendBillVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlSendBillVC: PVBaseNavigationVC {
    
    let items = ["当前价格", "单价", "珍珠数量", "总金额", "交易手续费"]
    var price = ""
    var count = ""
    var account = ""
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    lazy var releaseBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("发布", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.addTarget(self, action: #selector(didSelectedRelease(sender:)), for: .touchUpInside)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.isEnabled = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发单"
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(tableView)
        view.addSubview(releaseBtn)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-220 * KScreenRatio_6)
        }
        releaseBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(25 * KScreenRatio_6)
        }
    }
    
    @objc func didSelectedRelease(sender: UIButton) {
        
    }
   

}

extension PVPearlSendBillVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 { return items.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //type
        if indexPath.section == 0 {
            let cell = PVPearlSendBillTypeCell.init(style: .default, reuseIdentifier: nil)
            
            return cell
        }
        //
        if indexPath.section == 1 {
            let cell = PVPearlSendBillCell.init(style: .default, reuseIdentifier: nil)
            cell.titleLabel.text = items[indexPath.row]
            
            cell.detailTF.tag = indexPath.row
            if indexPath.row == 0 {//当前价格
                cell.detailTF.isUserInteractionEnabled = false
                
            }
            if indexPath.row == 1 {//单价
                cell.detailTF.placeholder = "请输入单价"
            }
            if indexPath.row == 2 {//珍珠数量
                cell.detailTF.placeholder = "请输入数量"
            }
            if indexPath.row == 3 {//总金额
                cell.detailTF.placeholder = "金额"
            }
            if indexPath.row == 4 {//交易手续费
                
            }
            
            return cell
        }
        //收款账号
        if indexPath.section == 2 {
            let cell = PVPearlSendBillCell.init(style: .default, reuseIdentifier: nil)
            cell.titleLabel.text = "收款账号"
            
            cell.detailTF.tag = 20
        }
        return UITableViewCell()
    }
    
}

