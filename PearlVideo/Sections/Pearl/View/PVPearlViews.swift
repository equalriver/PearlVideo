//
//  PVPearlViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/12.
//  Copyright © 2019 equalriver. All rights reserved.
//




//MARK: - section header view
protocol PVPearlSectionHeaderDelegate: NSObjectProtocol {
    func didSelectedMarket()
}

class PVPearlSectionHeaderView: UIView {
    
    
    weak public var delegate: PVPearlSectionHeaderDelegate?
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "pearl_集市"))
        return iv
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_btn_weight
        l.textColor = kColor_text
        l.text = "珍珠集市"
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_4
        l.textColor = kColor_subText
        l.text = "珍珠集市内，用户之间可相互交易珍珠"
        return l
    }()
    lazy var todayPearlLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_pink
        l.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        return l
    }()
    lazy var marketBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text_2
        b.setTitle("进入集市", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(market), for: .touchUpInside)
        return b
    }()
    lazy var taskLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.text = "每日任务"
        return l
    }()
    lazy var leftDayLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.textAlignment = .right
        return l
    }()
    lazy var sepView_1: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var sepView_2: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_pink
        v.layer.cornerRadius = 1.5
        v.layer.masksToBounds = true
        return v
    }()
    lazy var sepView_3: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconIV)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(todayPearlLabel)
        addSubview(marketBtn)
        addSubview(taskLabel)
        addSubview(leftDayLabel)
        addSubview(sepView_1)
        addSubview(sepView_2)
        addSubview(sepView_3)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(5)
            make.top.equalTo(iconIV)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        todayPearlLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(40 * KScreenRatio_6)
            make.top.equalTo(detailLabel.snp.bottom).offset(15 * KScreenRatio_6)
        }
        marketBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(todayPearlLabel.snp.bottom).offset(20 * KScreenRatio_6)
        }
        sepView_2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 3, height: 20 * KScreenRatio_6))
            make.left.equalTo(iconIV)
            make.top.equalTo(sepView_1.snp.bottom).offset(20 * KScreenRatio_6)
        }
        sepView_3.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 0.5))
            make.top.equalTo(sepView_2.snp.bottom).offset(15 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        leftDayLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(taskLabel)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        taskLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(sepView_2)
            make.left.equalTo(sepView_2.snp.right).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func market() {
        delegate?.didSelectedMarket()
    }
    
}


//MARK: - PVPearlCell
protocol PVPearlCellDelegate: NSObjectProtocol {
    func didSelectedTask(cell: UITableViewCell, sender: UIButton)
}
class PVPearlCell: PVBaseTableCell {
    
    
    weak public var delegate: PVPearlCellDelegate?
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        return l
    }()
    lazy var detailLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        return l
    }()
    lazy var taskBtn: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 5
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(taskAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(taskBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.right.equalTo(taskBtn.snp.left).offset(-5)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.width.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        taskBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailLabel.text = nil
        taskBtn.setBackgroundImage(nil, for: .normal)
        taskBtn.setTitle(nil, for: .normal)
    }
    
    @objc func taskAction(sender: UIButton) {
        delegate?.didSelectedTask(cell: self, sender: sender)
    }
    
}
