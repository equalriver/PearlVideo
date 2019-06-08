//
//  PVExchangeRecord.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

class PVExchangeRecordVC: PVBaseWMPageVC {
    
    let items = ["买单", "卖单", "交换中", "已完成"]
    
    
    override func viewDidLoad() {
        titleSizeNormal = 18 * KScreenRatio_6
        titleSizeSelected = 18 * KScreenRatio_6
        titleColorNormal = UIColor.white
        titleColorSelected = kColor_pink!
        menuViewStyle = .line
        progressWidth = 30 * KScreenRatio_6
        
        super.viewDidLoad()
        
        
    }
    
    
}

//MARK: - 买单
class PVExchangeRecordBuyVC: PVBaseViewController {
    
    var page = 0
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        setRefresh()
        loadData(page: 0)
    }
    
}
