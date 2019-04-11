//
//  PVHomeVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVHomeVC: PVBaseViewController {
    
    
    
    lazy var naviBarView: PVHomeNaviBarView = {
        let v = PVHomeNaviBarView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
        v.delegate = self
        return v
    }()
    lazy var infoView: PVHomeVideoInfoView = {
        let v = PVHomeVideoInfoView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    lazy var contentCV: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(PVHomeCell.self, forCellWithReuseIdentifier: "PVHomeCell")
        return cv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    
    func initUI() {
        view.addSubview(contentCV)
        view.addSubview(naviBarView)
        view.addSubview(infoView)
        contentCV.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        infoView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 110 * KScreenRatio_6))
            make.bottom.left.equalToSuperview()
        }
    }

}
