//
//  PVHomeHeaderViewPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import FSPagerView


extension PVHomeHeaderView: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return data.bannerList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        if cell.imageView != nil { cell.imageView?.image = nil }
        cell.imageView?.kf.setImage(with: URL.init(string: data.bannerList[index].imageUrl))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        bannerPageControl.currentPage = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        delegate?.didSelectedBanner(index: index)
    }
    
}

extension PVHomeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == titlesCV { return 4 }
        if collectionView == actionItemsCV { return 4 }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == titlesCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeTitlesCell", for: indexPath) as! PVHomeTitlesCell
            switch indexPath.item {
            case 0: //会员等级
                cell.nameLabel.text = "会员等级"
                cell.numberLabel.text = "\(data.level)"
                break
                
            case 1: //活跃度
                cell.nameLabel.text = "活跃度"
                cell.numberLabel.text = "\(data.activeness_1)+\(data.activeness_2)"
                break
                
            case 2: //平安果
                cell.nameLabel.text = "平安果"
                cell.numberLabel.text = "\(data.total)"
                cell.numberLabel.textColor = kColor_yellow
                break
                
            case 3: //当前收益
                cell.nameLabel.text = "当前收益"
                cell.numberLabel.text = "\(data.currentIncome)"
                cell.numberLabel.textColor = kColor_yellow
                break
                
            default: break
            }
            return cell
        }
        if collectionView == actionItemsCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeActionItemsCell", for: indexPath) as! PVHomeActionItemsCell
            cell.iconIV.image = UIImage.init(named: actionImgs[indexPath.item])
            cell.nameLabel.text = actionTitles[indexPath.item]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == titlesCV {
            delegate?.didSelectedTitlesItem(index: indexPath.item)
        }
        if collectionView == actionItemsCV {
            delegate?.didSelectedActionItem(index: indexPath.item)
        }
    }
}
