//
//  PVAttentionVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVAttentionVC: PVBaseNavigationVC {
    
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 2 - 2, height: 186 * KScreenRatio_6)
        l.minimumLineSpacing = 4
        l.minimumInteritemSpacing = 4
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        cv.register(PVAttentionCell.self, forCellWithReuseIdentifier: "PVAttentionCell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关注"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.bottom.centerX.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.stateUnlogin(title: "登录可同步关注", img: nil)
    }
 

}


extension PVAttentionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVAttentionCell", for: indexPath) as! PVAttentionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
