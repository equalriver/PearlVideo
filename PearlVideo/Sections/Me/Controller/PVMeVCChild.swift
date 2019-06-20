//


import UIKit

//MARK: - 作品
protocol PVMeProductionDelegate: NSObjectProtocol {
    func scrollViewWillDragging(sender: UIScrollView)
    func didBeginHeaderRefresh(sender: UIScrollView?)
}

class PVMeProductionVC: PVBaseViewController {
    
    weak public var delegate: PVMeProductionDelegate?
    
    public var userId: String = UserDefaults.standard.string(forKey: kUserId) ?? "" {
        didSet{
            loadData(page: 0)
        }
    }
    
    var isLoadingMore = false
    
    var dataArr = Array<PVMeVideoList>()
    
    let threshold: CGFloat = 0.6
    let itemPerPage: CGFloat = 10   //每页条数
    var page: CGFloat = 0
    var nextPage = ""
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshMeProductionVC, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: - 喜欢
protocol PVMeLikeDelegate: NSObjectProtocol {
    func scrollViewWillDragging(sender: UIScrollView)
    func didBeginHeaderRefresh(sender: UIScrollView?)
}

class PVMeLikeVC: PVBaseViewController {
    
    weak public var delegate: PVMeLikeDelegate?
    
    public var userId: String = UserDefaults.standard.string(forKey: kUserId) ?? "" {
        didSet{
            loadData(page: 0)
        }
    }
    
    var isLoadingMore = false
    
    var dataArr = Array<PVMeVideoList>()
    
    let threshold: CGFloat = 0.6
    let itemPerPage: CGFloat = 10   //每页条数
    var page: CGFloat = 0
    var nextPage = ""
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshMeLikeVC, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//MARK: - 私密
protocol PVMeSecureDelegate: NSObjectProtocol {
    func scrollViewWillDragging(sender: UIScrollView)
    func didBeginHeaderRefresh(sender: UIScrollView?)
}

class PVMeSecureVC: PVBaseViewController {
    
    weak public var delegate: PVMeSecureDelegate?
    
    public var userId: String = UserDefaults.standard.string(forKey: kUserId) ?? "" {
        didSet{
            loadData(page: 0)
        }
    }
    
    var isLoadingMore = false
    
    var dataArr = Array<PVMeVideoList>()
    
    let threshold: CGFloat = 0.6
    let itemPerPage: CGFloat = 10   //每页条数
    var page: CGFloat = 0
    var nextPage = ""
    
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
        loadData(page: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNoti(sender:)), name: .kNotiName_refreshMeSecrityVC, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


//MARK: - 等级
class PVMeLevelVC: PVBaseNavigationVC {
    
    let items = ["准星达人", "一星达人", "二星达人", "三星达人", "城市合伙人"]
    let defaultImgs = ["me_星级达人0_gray", "me_星级达人1_gray", "me_星级达人2_gray", "me_星级达人3_gray", "me_星级达人4_gray"]
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 100 * KScreenRatio_6, height: 135 * KScreenRatio_6)
        l.scrollDirection = .vertical
        l.minimumLineSpacing = 2
        l.minimumInteritemSpacing = 2
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = kColor_deepBackground
        cv.isScrollEnabled = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(PVMeLevelCell.self, forCellWithReuseIdentifier: "PVMeLevelCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kColor_deepBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-30 * KScreenRatio_6)
            make.centerX.bottom.equalToSuperview()
        }
        title = "等级"
    }
    
}
