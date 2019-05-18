//



import MJRefresh


//MARK: - 作品
extension PVMeProductionVC {
    
    func setRefresh() {
        let headerRef = MJRefreshHeader.init {[weak self] in
            self?.delegate?.didBeginHeaderRefresh(sender: self?.collectionView)
        }
        collectionView.mj_header = headerRef
        
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        
    }
    
}

extension PVMeProductionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        cell.imgIV.image = UIImage.init(color: UIColor.gray)
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
