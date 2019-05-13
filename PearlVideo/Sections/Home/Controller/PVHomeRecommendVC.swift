//
//  PVHomeRecommendVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

protocol PVHomeRecommendDelegate: NSObjectProtocol {
    func listViewShow(isShow: Bool)
}

class PVHomeRecommendVC: UIViewController {
    
    weak public var delegate: PVHomeRecommendDelegate?
    
    public var isShowMoreView = false

    private var isLoadingMore = false
    
    let threshold:   CGFloat = 0.7
    let itemPerPage: CGFloat = 10   //每页条数
    var currentPage: CGFloat = 0
    var skip = 1
    
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
//        v.showsVerticalScrollIndicator = false
        v.register(PVHomeVideoCell.self, forCellWithReuseIdentifier: "PVHomeVideoCell")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
        loadData(page: skip)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: kToken) == nil {
            collectionView.stateUnlogin(title: "登录", img: nil) {
                self.loadData(page: self.skip)
            }
        }
    }
    
    func loadData(page: Int) {
        isLoadingMore = true
        PVNetworkTool.Request(router: .homeVideoList(page: skip), success: { (resp) in
            
            self.isLoadingMore = false
            
        }) { (e) in
            self.skip = self.skip > 1 ? self.skip - 10 : 1
            self.currentPage = self.currentPage > 0 ? self.currentPage - 1 : 0
            self.isLoadingMore = false
        }
    }
    
}

extension PVHomeRecommendVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeVideoCell", for: indexPath) as! PVHomeVideoCell
        cell.nameLabel.text = "sadadadad"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
                skip += 10
                isLoadingMore = true
                loadData(page: skip)
                print("Request page \(currentPage) from server.")
            }
        }
    }
    
   
}
