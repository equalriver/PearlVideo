
//
//  PVPearlMarketChildVCs.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - 买单
class PVPearlMarketBuyVC: PVBaseNavigationVC {
    
    
    lazy var sepView: UIView = {
        let v = UIView.init()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 105 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        l.minimumLineSpacing = 5
        l.minimumInteritemSpacing = 5
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.register(PVPearlMarketBuyCollectionCell.self, forCellWithReuseIdentifier: "PVPearlMarketBuyCollectionCell")
        return cv
    }()
    lazy var headerView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 180 * KScreenRatio_6))
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(tableView)
        headerView.addSubview(sepView)
        headerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth - 40 * KScreenRatio_6, height: 140 * KScreenRatio_6 + 7))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.bottom.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
    }
}
