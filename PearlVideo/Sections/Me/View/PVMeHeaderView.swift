//
//  PVMeHeaderView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

protocol PVMeHeaderViewDelegate: NSObjectProtocol {
    func didSelectedEdit()
    func didSelectedLevel()
    func didSelectedActiveness()
    func didSelectedFruit()
    func didLongPressBackground()
}

class PVMeHeaderView: UIView {
    
    public var data = PVMeModel() {
        didSet{
            titlesCV.reloadData()
            backgroundImageIV.kf.setImage(with: URL.init(string: data.backgroundImageUrl), placeholder: UIImage.init(named: "me_bg"), options: nil, progressBlock: nil, completionHandler: nil)
            avatarIV.kf.setImage(with: URL.init(string: data.avatarUrl), placeholder: UIImage.init(named: "me_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            nameLabel.text = data.nickName
            
            if data.gender == 0 { genderIV.image = nil }
            else {
                genderIV.image = data.gender == 1 ? UIImage.init(named: "me_male") : UIImage.init(named: "me_female")
            }
            fansLabel.text = data.nickName.count > 0 ? "\(data.fansCount)粉丝 | \(data.followCount)关注" : nil
            if data.isMine {
                editBtn.setTitle("编辑个人资料", for: .normal)
                editBtn.backgroundColor = kColor_deepBackground
                editBtn.layer.borderColor = UIColor.white.cgColor
            }
            else {
                if data.nickName.count > 0 {
                    editBtn.setTitle("+关注", for: .normal)
                    editBtn.backgroundColor = kColor_pink
                    editBtn.layer.borderColor = nil
                }
                else {
                    editBtn.setTitle("登录/注册", for: .normal)
                    editBtn.backgroundColor = kColor_deepBackground
                    editBtn.layer.borderColor = UIColor.white.cgColor
                }
                
            }
            introLabel.text = data.autograph
            authIV.isHidden = !data.isCertification
        }
    }

    weak public var delegate: PVMeHeaderViewDelegate?
    
    lazy var backgroundImageIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "me_bg"))
        let long = UILongPressGestureRecognizer.init(actionBlock: {[weak self] (ges) in
            self?.delegate?.didLongPressBackground()
        })
        long.minimumPressDuration = 1.0
        v.addGestureRecognizer(long)
        v.isUserInteractionEnabled = true
        return v
    }()
    lazy var borderContentView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var avatarIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "me_placeholder"))
        iv.layer.cornerRadius = 45 * KScreenRatio_6
        iv.layer.masksToBounds = true
        return iv
    }()
    lazy var authIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "me_auth"))
        v.isHidden = true
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        return l
    }()
    lazy var genderIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var fansLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        return l
    }()
    lazy var editBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("登录/注册", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 15 * KScreenRatio_6
        b.backgroundColor = kColor_background
        b.addBlock(for: .touchUpInside, block: {[weak self] (btn) in
            self?.delegate?.didSelectedEdit()
        })
        return b
    }()
    lazy var starIV: UIImageView = {
        return UIImageView()
    }()
    lazy var introLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_subText
        l.numberOfLines = 2
        return l
    }()
    lazy var titlesCV: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: kScreenWidth / 3, height: 70 * KScreenRatio_6)
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        let c = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        c.backgroundColor = kColor_background
        c.isScrollEnabled = false
        c.dataSource = self
        c.delegate = self
        c.register(PVMeTitlesCell.self, forCellWithReuseIdentifier: "PVMeTitlesCell")
        return c
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(backgroundImageIV)
        addSubview(borderContentView)
        addSubview(avatarIV)
        addSubview(authIV)
        borderContentView.addSubview(nameLabel)
        borderContentView.addSubview(genderIV)
        borderContentView.addSubview(fansLabel)
        borderContentView.addSubview(editBtn)
        borderContentView.addSubview(starIV)
        borderContentView.addSubview(introLabel)
        borderContentView.addSubview(titlesCV)
        backgroundImageIV.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(240 * KScreenRatio_6)
        }
        borderContentView.snp.makeConstraints { (make) in
            make.bottom.centerX.width.equalToSuperview()
            make.top.equalTo(backgroundImageIV.snp.bottom)
        }
        avatarIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 90 * KScreenRatio_6, height: 90 * KScreenRatio_6))
            make.left.equalTo(borderContentView).offset(10 * KScreenRatio_6)
            make.top.equalTo(borderContentView).offset(-45 * KScreenRatio_6)
        }
        authIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.right.equalTo(avatarIV).offset(-17 * KScreenRatio_6)
            make.bottom.equalTo(avatarIV).offset(2)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIV.snp.right).offset(10 * KScreenRatio_6)
            make.top.equalTo(avatarIV).offset(25 * KScreenRatio_6)
        }
        genderIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(3)
        }
        fansLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
        editBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 145 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.left.equalTo(nameLabel)
            make.top.equalTo(fansLabel.snp.bottom).offset(7)
        }
        starIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalTo(editBtn)
            make.left.equalTo(editBtn.snp.right).offset(10 * KScreenRatio_6)
        }
        introLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalTo(avatarIV.snp.bottom).offset(30 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
        titlesCV.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(70 * KScreenRatio_6)
        }
    }
}

extension PVMeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeTitlesCell", for: indexPath) as! PVMeTitlesCell
        guard data.nickName.count > 0 else { return cell }
        switch indexPath.item {
        case 0: //等级
            cell.numberLabel.text = data.Level.count > 0 ? data.Level : "LV0"
            cell.nameBtn.setTitle("会员等级", for: .normal)
            cell.nameBtn.setImage(UIImage.init(named: "me_会员等级"), for: .normal)
            break
            
        case 1: //活跃度
            cell.numberLabel.text = data.LivenessCount + "+" + data.reelLivenessCount
            cell.nameBtn.setTitle("活跃度", for: .normal)
            cell.nameBtn.setImage(UIImage.init(named: "me_活跃度"), for: .normal)
            break
            
        case 2: //平安果
            cell.numberLabel.text = data.pearlToal
            cell.nameBtn.setTitle("平安果", for: .normal)
            cell.nameBtn.setImage(UIImage.init(named: "me_平安果"), for: .normal)
            break
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if data.isMine == false { return }
//        switch indexPath.item {
//        case 0: //会员等级
//            delegate?.didSelectedLevel()
//            break
//
//        case 1: //活跃度
//            delegate?.didSelectedActiveness()
//            break
//
//        case 2: //总平安果
//            delegate?.didSelectedFruit()
//            break
//
//        default:
//            break
//        }
    }
}

//MARK: - titles collection cell
class PVMeTitlesCell: UICollectionViewCell {
    
    lazy var numberLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.backgroundColor = kColor_background
        l.textAlignment = .center
        return l
    }()
    lazy var nameBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitleColor(kColor_text, for: .normal)
        b.isUserInteractionEnabled = false
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_background
        contentView.backgroundColor = kColor_background
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameBtn)
        numberLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameBtn.snp.makeConstraints { (make) in
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
        numberLabel.textColor = UIColor.white
        nameBtn.setTitle(nil, for: .normal)
        nameBtn.setImage(nil, for: .normal)
    }
    
}
