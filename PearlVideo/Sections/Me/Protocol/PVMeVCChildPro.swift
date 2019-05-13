//


//MARK: - 作品
extension PVMeProductionVC {
    func loadData(page: Int) {
        isLoadingMore = true
        
    }
    
    
}

extension PVMeProductionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //上拉
        if velocity.y > 0 && isShowMoreView == false {
            self.delegate?.listViewShow(isShow: true)
            isShowMoreView = true
        }
        //下拉
        if velocity.y < 0 && isShowMoreView == true && scrollView.contentOffset.y <= 0 {
            self.delegate?.listViewShow(isShow: false)
            isShowMoreView = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = itemPerPage * threshold + currentPage * itemPerPage
            let totalItem = itemPerPage * (currentPage + 1)
            let newThreshold = needRead / totalItem
            
            if ratio >= newThreshold {
                currentPage += 1
                isLoadingMore = true
                print("Request page \(currentPage) from server.")
            }
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
