//
//  PVVideoShareAlert.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/28.
//  Copyright © 2019 equalriver. All rights reserved.
//


protocol PVVideoShareAlertDelegate: NSObjectProtocol {
    func alertDidShow()
    func alertDidDismiss()
    func didSelectedSharePlatform(type: PVVideoSharePlatformType)
}

enum PVVideoSharePlatformType {
    ///朋友圈
    case moments
    case weixin
    case qq
    case weibo
}

class PVVideoShareAlert: UIView {
    
    weak public var delegate: PVVideoShareAlertDelegate?
    
    let imgs = ["share_朋友圈", "share_微信", "share_qq", "share_微博"]
    let titles = ["朋友圈", "微信", "QQ", "微博"]
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 200 * KScreenRatio_6))
        v.backgroundColor = kColor_deepBackground
        return v
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.text = "分享到"
        return l
    }()
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 60 * KScreenRatio_6, height: 80 * KScreenRatio_6)
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = 10 * KScreenRatio_6
        l.minimumLineSpacing = 10 * KScreenRatio_6
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = kColor_deepBackground
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.register(PVVideoShareAlertCell.self, forCellWithReuseIdentifier: "PVVideoShareAlertCell")
        return cv
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("取消", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = kColor_deepBackground
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        backgroundColor = UIColor.clear
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.3) { (isFinish) in
            if isFinish { self.delegate?.alertDidShow() }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(cancelBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-50 * KScreenRatio_6)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-30 * KScreenRatio_6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.width.bottom.centerX.equalToSuperview()
            make.height.equalTo(50 * KScreenRatio_6)
        }
    }
    
    @objc func cancelAction(sender: UIButton) {
        self.delegate?.alertDidDismiss()
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.3) { (isFinish) in
            if isFinish {
                self.removeFromSuperview()
            }
        }
    }
}

extension PVVideoShareAlert: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVVideoShareAlertCell", for: indexPath) as! PVVideoShareAlertCell
        cell.iconIV.image = UIImage.init(named: imgs[indexPath.item])
        cell.nameLabel.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var type = PVVideoSharePlatformType.moments
        switch indexPath.item {
        case 0:
            type = .moments
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cancelAction(sender: self.cancelBtn)
            }
            break
        case 1:
            type = .weixin
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cancelAction(sender: self.cancelBtn)
            }
            break
        case 2:
            type = .qq
            break
        case 3:
            type = .weibo
            break
        default:
            break
        }
        delegate?.didSelectedSharePlatform(type: type)
        
    }
    
}

class PVVideoShareAlertCell: UICollectionViewCell {
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.top.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconIV.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
