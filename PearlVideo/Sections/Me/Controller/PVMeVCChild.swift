//


import UIKit

protocol PVMeProductionDelegate: NSObjectProtocol {
    func didBeginHeaderRefresh(sender: UIScrollView?)
}

//MARK: - 作品
class PVMeProductionVC: PVBaseViewController {
    
    weak public var delegate: PVMeProductionDelegate?
    
    var isLoadingMore = false
    
    let threshold:   CGFloat = 0.7
    let itemPerPage: CGFloat = 10   //每页条数
    var currentPage: CGFloat = 0
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 123 * KScreenRatio_6, height: 160 * KScreenRatio_6)
        l.minimumInteritemSpacing = 2
        l.minimumLineSpacing = 2
        l.sectionInset = .zero
        l.scrollDirection = .vertical
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = kColor_deepBackground
        cv.register(PVMeProductionCell.self, forCellWithReuseIdentifier: "PVMeProductionCell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
        setRefresh()
    }

}

//MARK: - 喜欢
class PVMeLikeVC: PVBaseViewController {
    
    weak public var delegate: PVMeProductionDelegate?
    
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 120 * KScreenRatio_6, height: 160 * KScreenRatio_6)
        l.minimumInteritemSpacing = 3
        l.minimumLineSpacing = 3
        l.sectionInset = .zero
        l.scrollDirection = .vertical
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        cv.register(PVMeProductionCell.self, forCellWithReuseIdentifier: "PVMeProductionCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.size.centerY.centerX.equalToSuperview()
        }
        
    }
    
}
