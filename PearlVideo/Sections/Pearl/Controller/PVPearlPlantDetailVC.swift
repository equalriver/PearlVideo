//
//  PVPearlPlantDetailVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVPearlPlantDetailVC: PVBaseNavigationVC {
    
    
    lazy var pearlBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitle("可用水草", for: .normal)
        b.setImage(UIImage.init(named: "pearl_pearlDetail_水草"), for: .normal)
        b.isUserInteractionEnabled = false
        return b
    }()
    lazy var pearlCountLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 29 * KScreenRatio_6, weight: .semibold)
        l.textColor = UIColor.white
        return l
    }()
    lazy var headerView: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "pearl_plantDetail_bg"))
        return v
    }()
    lazy var sectionHeaderView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 345 * KScreenRatio_6, height: 55 * KScreenRatio_6))
        v.backgroundColor = UIColor.white
        
        let sep = UIView()
        sep.backgroundColor = UIColor.init(hexString: "#6AE15A")
        sep.layer.cornerRadius = 1.5
        sep.layer.masksToBounds = true
        v.addSubview(sep)
        
        let l = UILabel()
        l.font = kFont_text_weight
        l.textColor = kColor_text
        l.text = "水草明细"
        v.addSubview(l)
        
        sep.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize.init(width: 3, height: 20 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        })
        l.snp.makeConstraints { (make) in
            make.left.equalTo(sep.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.layer.shadowColor = UIColor(red: 0.34, green: 0.38, blue: 0.82, alpha: 0.52).cgColor
        tb.layer.shadowOffset = CGSize(width: 0, height: 7)
        tb.layer.shadowOpacity = 0.52
        tb.layer.shadowRadius = 34
        tb.layer.cornerRadius = 5
        return tb
    }()
    lazy var feedButton: UIButton = {
        let b = UIButton()
        b.setTitle("喂养贝壳", for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitleColor(UIColor.init(hexString: "#53C8FF"), for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "我的水草"
        naviBar.rightBarButtons = [feedButton]
    }
    
    func initUI() {
        headerView.addSubview(pearlBtn)
        headerView.addSubview(pearlCountLabel)
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        pearlBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50 * KScreenRatio_6)
        }
        pearlCountLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pearlBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(345 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    
    override func rightButtonsAction(sender: UIButton) {
        
    }
    
}

extension PVPearlPlantDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVPearlPearlDetailCell") as? PVPearlPearlDetailCell
        if cell == nil {
            cell = PVPearlPearlDetailCell.init(style: .default, reuseIdentifier: "PVPearlPearlDetailCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
}

