//
//  PVHomePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//


//MARK: - action
extension PVHomeVC {
    
}


//MARK: - navigation bar delegate
extension PVHomeVC: PVHomeNaviBarDelegate {
    
    func didSelectedComment() {
        
    }
    
    func didSelectedLike(sender: UIButton) {
        
    }
    
    func didSelectedShare() {
        
    }
    
    func didSelectedReport() {
        
    }
    
}


//MARK: - info delegate
extension PVHomeVC: PVHomeVideoInfoDelegate {
    
    func didClickHead() {
//        PVUserInfoVC
    }
    
}


//MARK: - collection view delegate
extension PVHomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeCell", for: indexPath) as! PVHomeCell
        
        return cell
    }
    
}
