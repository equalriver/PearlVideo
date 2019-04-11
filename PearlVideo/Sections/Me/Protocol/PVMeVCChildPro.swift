//


//MARK: - 作品
extension PVMeProductionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //上拉
        if velocity.y > 1 && isShowMoreView == false {
            self.delegate?.listViewShow(isShow: true)
            isShowMoreView = true
        }
        //下拉
        if velocity.y < -1 && isShowMoreView == true && scrollView.contentOffset.y <= 0 {
            self.delegate?.listViewShow(isShow: false)
            isShowMoreView = false
        }
    }
    
}


//MARK: - 喜欢
extension PVMeLikeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //上拉
        if velocity.y > 1 && isShowMoreView == false {
            self.delegate?.listViewShow(isShow: true)
            isShowMoreView = true
        }
        //下拉
        if velocity.y < -1 && isShowMoreView == true && scrollView.contentOffset.y <= 0 {
            self.delegate?.listViewShow(isShow: false)
            isShowMoreView = false
        }
    }
    
}
