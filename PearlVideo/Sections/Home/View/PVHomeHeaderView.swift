//
//  PVHomeViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

import FSPagerView

protocol PVHomeHeaderDelegate: NSObjectProtocol {
    func didSelectedBanner(index: Int)
    func didSelectedTitlesItem(index: Int)
    func didSelectedActionItem(index: Int)
}

class PVHomeHeaderView: UIView {
    
    weak public var delegate: PVHomeHeaderDelegate?
    
    public var data = PVHomeModel() {
        didSet{
            bannerPageControl.numberOfPages = data.bannerList.count
            bannerView.reloadData()
            noticeBannerView.data = data
            titlesCV.reloadData()
        }
    }
    
    let actionImgs = ["home_任务", "home_组队", "home_团队", "home_商学院"]
    let actionTitles = ["任务", "组队", "团队", "商学院"]
    
    
    lazy var bannerView: FSPagerView = {
        let v = FSPagerView.init(frame: .zero)
        v.isInfinite = true
        v.scrollDirection = .horizontal
        v.automaticSlidingInterval = 3
        v.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        v.dataSource = self
        v.delegate = self
        return v
    }()
    lazy var bannerPageControl: FSPageControl = {
        let p = FSPageControl.init(frame: .zero)
        p.setFillColor(UIColor.gray, for: .normal)
        p.setFillColor(UIColor.white, for: .selected)
        return p
    }()
    lazy var noticeBannerView: PVHomeNoticeBannerView = {
        let v = PVHomeNoticeBannerView.init(frame: .zero)
        return v
    }()
    lazy var titlesCV: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 4, height: 90 * KScreenRatio_6)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        let c = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        c.backgroundColor = kColor_background
        c.isScrollEnabled = false
        c.dataSource = self
        c.delegate = self
        c.register(PVHomeTitlesCell.self, forCellWithReuseIdentifier: "PVHomeTitlesCell")
        return c
    }()
    lazy var actionItemsCV: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 4, height: 80 * KScreenRatio_6)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        let c = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        c.backgroundColor = kColor_background
        c.isScrollEnabled = false
        c.dataSource = self
        c.delegate = self
        c.register(PVHomeActionItemsCell.self, forCellWithReuseIdentifier: "PVHomeActionItemsCell")
        return c
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bannerView)
        addSubview(bannerPageControl)
        addSubview(noticeBannerView)
        addSubview(titlesCV)
        addSubview(actionItemsCV)
        bannerView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.height.equalTo(200 * KScreenRatio_6)
        }
        bannerPageControl.snp.makeConstraints { (make) in
            make.height.equalTo(30 * KScreenRatio_6)
            make.width.bottom.centerX.equalTo(bannerView)
        }
        noticeBannerView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom)
            make.height.equalTo(40 * KScreenRatio_6)
        }
        titlesCV.snp.makeConstraints { (make) in
            make.height.equalTo(90 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(noticeBannerView.snp.bottom)
        }
        actionItemsCV.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.top.equalTo(titlesCV.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//MARK: - notice banner view
class PVHomeNoticeBannerView: UIView {
    
    public var data = PVHomeModel() {
        didSet{
            bannerView.reloadData()
        }
    }
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "home_notice"))
        return iv
    }()
    lazy var bannerView: FSPagerView = {
        let p = FSPagerView.init(frame: .zero)
        p.backgroundColor = kColor_background
        p.scrollDirection = .vertical
        p.isInfinite = true
        p.automaticSlidingInterval = 3
        p.register(PVHomeNoticeBannerCell.self, forCellWithReuseIdentifier: "PVHomeNoticeBannerCell")
        p.dataSource = self
        p.delegate = self
        return p
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        addSubview(iconIV)
        addSubview(bannerView)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
            make.left.equalToSuperview().offset(30 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.centerY.right.equalToSuperview()
            make.height.equalToSuperview()
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PVHomeNoticeBannerView: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return data.noticeList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PVHomeNoticeBannerCell", at: index) as! PVHomeNoticeBannerCell
        cell.contentLabel.text = data.noticeList[index].title
        return cell
    }
}

//MARK: - Notice Banner Cell
class PVHomeNoticeBannerCell: FSPagerViewCell {
    
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.backgroundColor = kColor_background
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.layer.shadowColor = nil
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowOpacity = 1
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.width.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.text = nil
    }
    
}

//MARK: - titles collection cell
class PVHomeTitlesCell: UICollectionViewCell {
    
    lazy var numberLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.backgroundColor = kColor_background
        l.textAlignment = .center
        return l
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.backgroundColor = kColor_background
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = nil
        nameLabel.text = nil
        numberLabel.textColor = UIColor.white
    }
    
}

//MARK: - action items cell
class PVHomeActionItemsCell: UICollectionViewCell {
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.backgroundColor = kColor_background
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        iconIV.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconIV.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
    }
    
}
