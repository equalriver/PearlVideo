//
//  PVExchangeBuyOrderVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeBuyOrderVC: PVBaseNavigationVC {
    
    let titles = ["价格区间", "单价", "平安果数量", "总金额", "交换密码", "收款账号"]
    
    var price = ""
    
    var count = ""
    
    var password = ""
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.isScrollEnabled = false
        return tb
    }()
    lazy var sendBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("发布", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.gray
        b.isEnabled = false
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.addTarget(self, action: #selector(sendAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发单"
        view.addSubview(tableView)
        view.addSubview(sendBtn)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(400 * KScreenRatio_6)
        }
        sendBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        sendBtn.isEnabled = price.count > 0 && count.count > 0 && password.count > 0
        sendBtn.backgroundColor = sendBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func sendAction(sender: UIButton) {
        
    }
    
    
}


extension PVExchangeBuyOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVExchangeBuyOrderCell.init(style: .default, reuseIdentifier: nil)
        cell.detailTF.addTarget(self, action: #selector(textFieldEditingChange(sender:)), for: .editingChanged)
        cell.titleLabel.text = titles[indexPath.row]
        switch indexPath.row {
        case 0: //价格区间
            cell.detailTF.isUserInteractionEnabled = false
            break
            
        case 1: //单价
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入单价", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            
            break
            
        case 2: //平安果数量
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入数量", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            
            break
            
        case 3: //总金额
            cell.detailTF.isUserInteractionEnabled = false
            break
            
        case 4: //交换密码
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入交换密码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            cell.detailTF.isSecureTextEntry = true
            break
            
        case 5: //收款账号
            cell.detailTF.isUserInteractionEnabled = false
            break
            
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 60 * KScreenRatio_6))
        v.backgroundColor = kColor_deepBackground
        
        let type = UILabel()
        type.font = kFont_text
        type.textColor = kColor_text
        type.text = "类型"
        v.addSubview(type)
        
        let detail = UILabel()
        detail.font = kFont_text
        detail.textColor = kColor_pink
        detail.textAlignment = .right
        detail.text = "买进"
        v.addSubview(detail)
        
        let sepView = UIView()
        sepView.backgroundColor = kColor_background
        v.addSubview(sepView)
        
        type.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        detail.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        sepView.snp.makeConstraints { (make) in
            make.width.bottom.centerX.equalToSuperview()
            make.height.equalTo(10 * KScreenRatio_6)
        }
        return v
    }
    
}

