//
//  PVPearlMarketChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单
extension PVPearlMarketBuyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVPearlMarketBuyCollectionCell", for: indexPath) as! PVPearlMarketBuyCollectionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension PVPearlMarketBuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVPearlMarketBuyCell") as? PVPearlMarketBuyCell
        if cell == nil {
            cell = PVPearlMarketBuyCell.init(style: .default, reuseIdentifier: "PVPearlMarketBuyCell")
        }
        cell?.delegate = self
        
        return cell!
    }
    
}

extension PVPearlMarketBuyVC: PVPearlMarketBuyDelegate {
    
    func didSelectedBuy(cell: UITableViewCell) {
        
    }
    
}
