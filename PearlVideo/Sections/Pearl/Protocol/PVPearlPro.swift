//
//  PVPearlPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - action
extension PVPearlVC {
    //规则
    override func rightButtonsAction(sender: UIButton) {
        
    }
    
}

//MARK: - header view delegate
extension PVPearlVC: PVPearlHeaderDelegate {
    //升级贝壳
    func didSelectedLevelUp() {
        YPJOtherTool.ypj.showAlert(title: nil, message: "升级x贝壳LVxx需消耗xx珍珠", style: .alert, isNeedCancel: true) { (ac) in
            
        }
    }
    
    //珍珠明细
    func didSelectedPearlDetail() {
        
    }
    
    //水草明细
    func didSelectedPlantDetail() {
        
    }
    
    //用户等级
    func didSelectedUserLevel() {
        
    }
    
    //贝壳等级
    func didSelectedShellLevel() {
        
    }
    
    //喂养水草
    func didSelectedFeedPlant(sender: UIButton, completion: @escaping (String?) -> Void) {
        let alert = PVPearlHeaderFeedAlert.init(totalCount: 1000) {[weak self] (count) in
            completion("\(count ?? 0)")
        }
        view.addSubview(alert)
    }
    
}

//MARK: - section header delegate
extension PVPearlVC: PVPearlSectionHeaderDelegate {
    //进入集市
    func didSelectedMarket() {
        
    }
    
}

//MARK: - action
extension PVPearlVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 170 * KScreenRatio_6 : 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //每日任务
        if indexPath.section == 0 {
            let cell = PVPearlCell.init(style: .default, reuseIdentifier: nil)
            cell.delegate = self
            return cell
        }
        //玩法
        if indexPath.section == 1 {
            let c = PVPearlRuleCell.init(style: .default, reuseIdentifier: nil)
            return c
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return sectionHeaderView }
        else {
            let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50 * KScreenRatio_6))
            v.backgroundColor = UIColor.white
            
            let l = UILabel()
            l.font = kFont_text
            l.textColor = kColor_subText
            l.text = "玩法"
            v.addSubview(l)
            
            let sep_1 = UIView()
            sep_1.backgroundColor = kColor_pink
            sep_1.layer.cornerRadius = 1.5
            sep_1.layer.masksToBounds = true
            v.addSubview(sep_1)
            
            let sep_2 = UIView()
            sep_2.backgroundColor = kColor_background
            v.addSubview(sep_2)
            
            sep_1.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 3, height: 20 * KScreenRatio_6))
                make.left.equalToSuperview().offset(15 * KScreenRatio_6)
                make.centerY.equalToSuperview()
            }
            sep_2.snp.makeConstraints { (make) in
                make.height.equalTo(0.5)
                make.width.centerX.bottom.equalToSuperview()
            }
            l.snp.makeConstraints { (make) in
                make.left.equalTo(sep_1.snp.right).offset(10)
                make.centerY.equalToSuperview()
            }
            
            return v
        }
        
    }
    
}

//MARK: - cell delegate
extension PVPearlVC: PVPearlCellDelegate {
    
    func didSelectedTask(cell: UITableViewCell, sender: UIButton) {
        
    }

}
