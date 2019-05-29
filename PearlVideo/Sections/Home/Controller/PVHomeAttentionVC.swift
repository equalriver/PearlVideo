//
//  PVHomeAttentionVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import MJRefresh
import ObjectMapper

protocol PVHomeAttentionDelegate: NSObjectProtocol {
    func didBeginAttentionHeaderRefresh(sender: UIScrollView?)
}

class PVHomeAttentionVC: PVBaseViewController {
    
    weak public var delegate: PVHomeAttentionDelegate?
    
    private var isLoadingMore = false
    
    let threshold:   CGFloat = 0.7
    let itemPerPage = 10   //每页条数
    var page = 0
    
    var dataArr = Array<PVHomeVideoModel>()
    
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 2 - 1, height: 300 * KScreenRatio_6)
        l.scrollDirection = .vertical
        l.minimumLineSpacing = 1
        l.minimumInteritemSpacing = 1
        let v = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        v.backgroundColor = kColor_background
        v.dataSource = self
        v.delegate = self
        v.register(PVHomeVideoCell.self, forCellWithReuseIdentifier: "PVHomeVideoCell")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
        loadData(page: page)
        setRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataArr.count == 0 {
            loadData(page: self.page)
        }
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .homeRecommendVideoList(page: page), success: { (resp) in
            
            if let d = Mapper<PVHomeVideoModel>().mapArray(JSONObject: resp["result"]["videoList"].arrayObject) {
                if page == 0 {
                    self.dataArr = d
                }
                else {
                    self.dataArr += d
                }
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
    
    func setRefresh() {
        let headerRef = MJRefreshHeader.init {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
            self?.delegate?.didBeginAttentionHeaderRefresh(sender: self?.collectionView)
        }
        collectionView.mj_header = headerRef
    }
    
}

extension PVHomeAttentionVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeVideoCell", for: indexPath) as! PVHomeVideoCell
        guard dataArr.count > indexPath.item else { return cell}
        cell.data = dataArr[indexPath.item]
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isLoadingMore == false {
            let current = scrollView.contentOffset.y + scrollView.frame.size.height
            let total = scrollView.contentSize.height
            let ratio = current / total
            
            let needRead = CGFloat(itemPerPage) * threshold + CGFloat(page * itemPerPage)
            let totalItem = itemPerPage * (page + 1)
            let newThreshold = needRead / CGFloat(totalItem)
            
            if ratio >= newThreshold {
                page += 1
                isLoadingMore = true
                loadData(page: page)
                print("Request page \(page) from server.")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PVHomePlayVC.init(type: 1, videoId: dataArr[indexPath.item].videoId, videoIndex: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

