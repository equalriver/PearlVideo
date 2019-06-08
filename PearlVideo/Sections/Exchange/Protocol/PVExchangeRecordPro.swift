//
//  PVExchangeRecordPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import ObjectMapper

extension PVExchangeRecordVC {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return items.count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return items[index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect.init(x: 0, y: kNavigationBarAndStatusHeight + 50 * KScreenRatio_6, width: kScreenWidth, height: kScreenHeight - kNavigationBarAndStatusHeight - 50 * KScreenRatio_6)
    }
}

//MARK: - 买单
extension PVExchangeRecordBuyVC {
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) { [weak self] in
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) { [weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
    
    func loadData(page: Int) {
        
    }
}

extension PVExchangeRecordBuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVExchangeRecordCell") as? PVExchangeRecordCell
        if cell == nil {
            cell = PVExchangeRecordCell.init(style: .default, reuseIdentifier: "PVExchangeRecordCell")
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

