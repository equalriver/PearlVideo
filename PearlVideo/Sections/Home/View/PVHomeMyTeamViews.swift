//
//  PVHomeMyTeamViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/13.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - info
class PVHomeMyTeamHeaderView: UIView {
    
    lazy var infoCV: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 4, height: 70 * KScreenRatio_6)
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = kColor_deepBackground
        cv.isScrollEnabled = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(PVHomeMyTeamInfoCell.self, forCellWithReuseIdentifier: "PVHomeMyTeamInfoCell")
        return cv
    }()
    lazy var infoBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 25 * KScreenRatio_6
        return v
    }()
    lazy var infoLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        addSubview(infoCV)
        addSubview(infoBgView)
        infoBgView.addSubview(avatarIV)
        infoBgView.addSubview(infoLabel)
        infoCV.snp.makeConstraints { (make) in
            make.height.equalTo(72 * KScreenRatio_6)
            make.top.width.centerX.equalToSuperview()
        }
        infoBgView.snp.makeConstraints { (make) in
            make.height.equalTo(80 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.top.equalTo(infoCV.snp.bottom)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 50 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(15 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PVHomeMyTeamHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVHomeMyTeamInfoCell", for: indexPath) as! PVHomeMyTeamInfoCell
        
        return cell
    }
    
}

class PVHomeMyTeamInfoCell: UICollectionViewCell {
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .center
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_yellow
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailLabel.text = nil
    }
}


//MARK: - 队员列表cell
class PVHomeMyTeamListCell: PVBaseTableCell {
    
    
    lazy var avatarIV: UIImageView = {
        let v = UIImageView()
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        v.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_background!)
        return v
    }()
    lazy var activenessLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.text = "活跃度"
        return l
    }()
    lazy var activenessDetailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.text = "团队人数"
        return l
    }()
    lazy var countDetailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    lazy var teamActivenessLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.text = "团队活跃度"
        return l
    }()
    lazy var teamActivenessDetailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.textAlignment = .center
        return l
    }()
    lazy var statusIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "home_未实名"))
        v.backgroundColor = kColor_background
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        separatorView.backgroundColor = kColor_deepBackground
        separatorView.snp.updateConstraints { (make) in
            make.height.equalTo(5)
        }
        contentView.addSubview(avatarIV)
        contentView.addSubview(activenessLabel)
        contentView.addSubview(activenessDetailLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(countDetailLabel)
        contentView.addSubview(teamActivenessLabel)
        contentView.addSubview(teamActivenessDetailLabel)
        contentView.addSubview(statusIV)
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        activenessLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right)
            make.width.equalTo(282 / 3 * KScreenRatio_6)
            make.top.equalTo(avatarIV)
        }
        activenessDetailLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(activenessLabel)
            make.top.equalTo(activenessLabel.snp.bottom).offset(13 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(activenessLabel.snp.right)
            make.width.centerY.equalTo(activenessLabel)
        }
        countDetailLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(countLabel)
            make.top.equalTo(countLabel.snp.bottom).offset(13 * KScreenRatio_6)
        }
        teamActivenessLabel.snp.makeConstraints { (make) in
            make.left.equalTo(countLabel.snp.right)
            make.width.centerY.equalTo(countLabel)
        }
        teamActivenessDetailLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(teamActivenessLabel)
            make.top.equalTo(teamActivenessLabel.snp.bottom).offset(13 * KScreenRatio_6)
        }
        statusIV.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarIV.image = nil
        activenessDetailLabel.text = nil
        countDetailLabel.text = nil
        teamActivenessDetailLabel.text = nil
        statusIV.image = nil
    }
    
}
