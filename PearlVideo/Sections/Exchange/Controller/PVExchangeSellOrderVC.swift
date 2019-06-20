//
//  PVExchangeSellOrderVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/6.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper

class PVExchangeSellOrderVC: PVBaseNavigationVC {
    
    let titles = ["价格区间", "单价", "平安果数量", "总金额", "交换密码", "交换手续费", "收款账号"]
    
    var price = 0.0
    
    var count = 0.0
    
    var password = ""
    
    var data = PVExchangeSendOrderModel()
    
    var totalPriceTF: UITextField?
    var countTF: UITextField?
    
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
        loadInfo()
    }
    
    func loadInfo() {
        PVNetworkTool.Request(router: .readySendSellOrder, success: { (resp) in
            if let d = Mapper<PVExchangeSendOrderModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.tableView.reloadData()
            }
            
        }) { (e) in
            
        }
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        sendBtn.isEnabled = price > 0 && count > 0 && password.count > 0
        sendBtn.backgroundColor = sendBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func priceTextFieldEditingChange(sender: UITextField) {
        //tag: 0 单价，1 总金额，2 交换密码
        guard sender.hasText else { return }
        
        if sender.tag == 0 { price = Double(sender.text!) ?? 0.0 }
        count = Double(countTF!.text!) ?? 0.0
        
        if price >= data.minPrice && price <= data.maxPrice {
            if countTF != nil && countTF!.hasText { totalPriceTF?.text = "¥\(count * price)" }
        }
        else {
            view.makeToast("不在价格区间范围内")
        }
        
        if sender.tag == 2 {
            password = sender.text ?? ""
        }
        
        sendBtn.isEnabled = count > 0 && price > 0 && password.count > 0
    }
    
    @objc func sendAction(sender: UIButton) {
        PVNetworkTool.Request(router: .sendSellOrder(price: price, count: Int(count), password: password), success: { (resp) in
            self.view.makeToast("发布成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.navigationController?.popViewController(animated: true)
            })
            
        }) { (e) in
            
        }
    }
    
    
}


extension PVExchangeSellOrderVC: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.detailTF.text = data.maxPrice > 0 ? "¥\(data.minPrice)~¥\(data.maxPrice)" : ""
            break
            
        case 1: //单价
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入单价", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            cell.detailTF.addTarget(self, action: #selector(priceTextFieldEditingChange(sender:)), for: .editingChanged)
            cell.detailTF.keyboardType = .numbersAndPunctuation
            cell.detailTF.tag = 0
            break
            
        case 2: //平安果数量
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入数量", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            cell.detailTF.addTarget(self, action: #selector(priceTextFieldEditingChange(sender:)), for: .editingChanged)
            cell.detailTF.keyboardType = .numbersAndPunctuation
            cell.detailTF.tag = 1
            countTF = cell.detailTF
            break
            
        case 3: //总金额
            cell.detailTF.isUserInteractionEnabled = false
            totalPriceTF = cell.detailTF
            break
            
        case 4: //交换密码
            cell.detailTF.attributedPlaceholder = NSAttributedString.init(string: "请输入交换密码", attributes: [.font: kFont_text, .foregroundColor: kColor_text!])
            cell.detailTF.isSecureTextEntry = true
            cell.detailTF.addTarget(self, action: #selector(priceTextFieldEditingChange(sender:)), for: .editingChanged)
            cell.detailTF.tag = 2
            break
            
        case 5: //交换手续费
            cell.detailTF.isUserInteractionEnabled = false
            cell.detailTF.text = "\(data.feeRatio * 100)%"
            break
            
        case 6: //收款账号
            cell.detailTF.isUserInteractionEnabled = false
            cell.detailTF.text = data.alipayAccount
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
        detail.text = "卖出"
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


