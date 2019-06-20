//
//  PVHomeReportDetailVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVHomeReportDetailVC: PVBaseNavigationVC {
    
    public var videoId = ""
    
    public var type = "" {
        didSet{
            let att = NSMutableAttributedString.init(string: "举报理由  " + type)
            att.addAttributes([.font: kFont_text, .foregroundColor: kColor_text!], range: NSMakeRange(0, 6))
            att.addAttributes([.font: kFont_text, .foregroundColor: UIColor.white], range: NSMakeRange(6, type.count))
            reasonLabel.attributedText = att
        }
    }
    
    let addImg = UIImage.init(named: "setting_背景图")!
    var imgs: [UIImage]!
    var selectedImageIndex = 0
    
    lazy var reasonLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    lazy var sepView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.text = "举报描述（选填）"
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_background
        l.textAlignment = .right
        l.text = "0/\(kReportLimitCount)"
        return l
    }()
    lazy var contentBgView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var contentTV: YYTextView = {
        let tv = YYTextView()
        tv.placeholderFont = kFont_text
        tv.placeholderTextColor = kColor_subText
        tv.placeholderText = "详细描述举报理由..."
        tv.textColor = kColor_text
        tv.font = kFont_text
        tv.delegate = self
        return tv
    }()
    lazy var imgCollectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        l.minimumLineSpacing = 12
        l.minimumInteritemSpacing = 12
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = kColor_deepBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(PVMeFeedbackCell.self, forCellWithReuseIdentifier: "PVMeFeedbackCell")
        return cv
    }()
    lazy var commitBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.titleLabel?.font = kFont_text
        b.setTitle("提交", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.gray
        b.isEnabled = false
        b.addTarget(self, action: #selector(commitAction(sender:)), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imgs = [addImg]
        initUI()
        title = "举报详情"
    }
    
    func initUI() {
        view.addSubview(reasonLabel)
        view.addSubview(sepView)
        view.addSubview(contentLabel)
        view.addSubview(countLabel)
        view.addSubview(contentBgView)
        contentBgView.addSubview(contentTV)
        view.addSubview(imgCollectionView)
        view.addSubview(commitBtn)
        reasonLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalToSuperview().offset(30 * KScreenRatio_6)
        }
        sepView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 0.5))
            make.centerX.equalToSuperview()
            make.top.equalTo(reasonLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(reasonLabel)
            make.top.equalTo(sepView.snp.bottom).offset(20 * KScreenRatio_6)
        }
        countLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalTo(contentLabel)
        }
        contentBgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 345 * KScreenRatio_6, height: 130 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        contentTV.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.right.bottom.equalToSuperview().offset(-15 * KScreenRatio_6)
        }
        imgCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(contentBgView.snp.bottom).offset(10 * KScreenRatio_6)
            make.height.equalTo(90 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        commitBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(imgCollectionView.snp.bottom).offset(30 * KScreenRatio_6)
        }
    }
    
    


}
