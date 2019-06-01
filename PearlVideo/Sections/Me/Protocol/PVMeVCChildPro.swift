//


import ObjectMapper
import MJRefresh


//MARK: - 作品
extension PVMeProductionVC {
    
    func setRefresh() {
        let headerRef = MJRefreshHeader.init {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
            self?.delegate?.didBeginHeaderRefresh(sender: self?.collectionView)
        }
        collectionView.mj_header = headerRef
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .userInfoVideo(userId: UserDefaults.standard.string(forKey: kUserId) ?? "", type: 3, page: page * 10), success: { (resp) in
            
            if let d = Mapper<PVMeVideoList>().mapArray(JSONObject: resp["result"]["videoList"].arrayObject) {
                if page == 0 {
                    self.dataArr = d
                }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.collectionView.stateEmpty() }
                else { self.collectionView.stateNormal() }
                self.collectionView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.isLoadingMore = false
            })
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.isLoadingMore = false
        }
    }
    
}

extension PVMeProductionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        guard dataArr.count > indexPath.item else { return cell }
        cell.data = dataArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PVMeVideoPlayVC.init(type: 3, videoId: dataArr[indexPath.item].videoId, videoIndex: 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = itemPerPage * threshold + page * itemPerPage
            let totalItem = itemPerPage * (page + 1)
            let newThreshold = needRead / totalItem
            
            if ratio >= newThreshold {
                page += 1
                isLoadingMore = true
                print("Request page \(page) from server.")
            }
        }
    }
    
}


//MARK: - 喜欢
extension PVMeLikeVC {
    
    func setRefresh() {
        let headerRef = MJRefreshHeader.init {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
            self?.delegate?.didBeginHeaderRefresh(sender: self?.collectionView)
        }
        collectionView.mj_header = headerRef
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .userInfoVideo(userId: UserDefaults.standard.string(forKey: kUserId) ?? "", type: 3, page: page * 10), success: { (resp) in
            
            if let d = Mapper<PVMeVideoList>().mapArray(JSONObject: resp["result"]["videoList"].arrayObject) {
                if page == 0 {
                    self.dataArr = d
                }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.collectionView.stateEmpty() }
                else { self.collectionView.stateNormal() }
                self.collectionView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.isLoadingMore = false
            })
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.isLoadingMore = false
        }
    }
    
}

extension PVMeLikeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        guard dataArr.count > indexPath.item else { return cell }
        cell.data = dataArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PVMeVideoPlayVC.init(type: 3, videoId: dataArr[indexPath.item].videoId, videoIndex: 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = itemPerPage * threshold + page * itemPerPage
            let totalItem = itemPerPage * (page + 1)
            let newThreshold = needRead / totalItem
            
            if ratio >= newThreshold {
                page += 1
                isLoadingMore = true
                print("Request page \(page) from server.")
            }
        }
    }
    
}

//MARK: - 私密
extension PVMeSecureVC {
    
    func setRefresh() {
        let headerRef = MJRefreshHeader.init {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
            self?.delegate?.didBeginHeaderRefresh(sender: self?.collectionView)
        }
        collectionView.mj_header = headerRef
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .userInfoVideo(userId: UserDefaults.standard.string(forKey: kUserId) ?? "", type: 3, page: page * 10), success: { (resp) in
            
            if let d = Mapper<PVMeVideoList>().mapArray(JSONObject: resp["result"]["videoList"].arrayObject) {
                if page == 0 {
                    self.dataArr = d
                }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                if self.dataArr.count == 0 { self.collectionView.stateEmpty() }
                else { self.collectionView.stateNormal() }
                self.collectionView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.isLoadingMore = false
            })
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.isLoadingMore = false
        }
    }
    
}

extension PVMeSecureVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeProductionCell", for: indexPath) as! PVMeProductionCell
        guard dataArr.count > indexPath.item else { return cell }
        cell.data = dataArr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PVMeVideoPlayVC.init(type: 3, videoId: dataArr[indexPath.item].videoId, videoIndex: 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = itemPerPage * threshold + page * itemPerPage
            let totalItem = itemPerPage * (page + 1)
            let newThreshold = needRead / totalItem
            
            if ratio >= newThreshold {
                page += 1
                isLoadingMore = true
                print("Request page \(page) from server.")
            }
        }
    }
    
}

//MARK: - 等级
extension PVMeLevelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeLevelCell", for: indexPath) as! PVMeLevelCell
        cell.nameLabel.text = items[indexPath.item]
        cell.imgIV.image = UIImage.init(named: defaultImgs[indexPath.item])
        return cell
    }
    
}
