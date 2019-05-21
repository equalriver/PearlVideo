//
//  PVHomeReportVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVHomeReportVC: PVBaseNavigationVC {

    public var videoId = ""
    
    let items = ["色情低俗", "政治敏感", "违法犯罪", "发布垃圾广告", "造谣传谣", "欺诈欺骗", "侮辱谩骂"]
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        tb.backgroundColor = kColor_deepBackground
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "举报视频"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }

}


extension PVHomeReportVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVHomeReportCell.init(style: .default, reuseIdentifier: nil)
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PVHomeReportDetailVC()
        vc.type = items[indexPath.row]
        vc.videoId = videoId
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
