//
//  PVHomeTaskViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 我的任务
class PVHomeMyTaskCell: PVBaseTableCell {
    
    public var data: PVHomeTaskList! {
        didSet{
            imgIV.image = UIImage.init(named: "home_书卷\(data.category)")
            switch data.category {
            case 0:
                typeLabel.textColor = kColor_pink
                break
                
            case 1:
                typeLabel.textColor = UIColor.init(hexString: "#4D7AFA")
                break
                
            case 2:
                typeLabel.textColor = UIColor.gray
                break
                
            case 3:
                typeLabel.textColor = UIColor.init(hexString: "#AE2CDF")
                break
                
            case 4:
                typeLabel.textColor = UIColor.init(hexString: "#FFC525")
                break
                
            default: break
            }
            typeLabel.text = data.name
            activenessLabel.text = "活跃度" + data.liveness
            let c = """
                    兑换所需: \(data.exchangeCount)
                    总收益: \(data.total)枚
                    所需任务: \(data.content)
                    任务周期：\(data.startTime)-\(data.endTime)
                    """
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 5
            let att = NSMutableAttributedString.init(string: c)
            att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle], range: NSMakeRange(0, c.count))
            contentLabel.attributedText = att
        }
    }
    
    lazy var imgIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "home_书卷1"))
        return v
    }()
    lazy var typeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        return l
    }()
    lazy var activenessLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 4
        return l
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(imgIV)
        imgIV.addSubview(typeLabel)
        imgIV.addSubview(activenessLabel)
        imgIV.addSubview(contentLabel)
        imgIV.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
        }
        activenessLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25 * KScreenRatio_6)
            make.centerY.equalTo(typeLabel)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(typeLabel)
            make.top.equalTo(typeLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if typeLabel.width > 0 {
//            let blueColors = [UIColor(red: 0.3, green: 0.48, blue: 0.98, alpha: 1).cgColor, UIColor(red: 0.33, green: 0.82, blue: 0.95, alpha: 1).cgColor]
//            typeLabel.ypj.addGradientLayer(colors: blueColors, startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), locations: nil)
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        typeLabel.text = nil
        activenessLabel.text = nil
        contentLabel.attributedText = nil
    }
    
}


//MARK: - 任务书卷
protocol PVHomeAllTaskDelegate: NSObjectProtocol {
    func didSelectedExchange(cell: UITableViewCell)
}
class PVHomeAllTaskCell: PVBaseTableCell {
    
    public var data: PVHomeTaskList! {
        didSet{
            imgIV.image = UIImage.init(named: "home_书卷\(data.category)")
            activenessLabel.textColor = kColor_text
        
            switch data.category {
            case 0:
                typeLabel.textColor = kColor_pink
                exchangeBtn.backgroundColor = kColor_pink
                activenessLabel.textColor = kColor_pink
                break
                
            case 1:
                typeLabel.textColor = UIColor.init(hexString: "#4D7AFA")
                exchangeBtn.backgroundColor = UIColor.init(hexString: "#4D7AFA")
                break
                
            case 2:
                typeLabel.textColor = UIColor.gray
                exchangeBtn.backgroundColor = UIColor.black
                break
                
            case 3:
                typeLabel.textColor = UIColor.init(hexString: "#AE2CDF")
                exchangeBtn.backgroundColor = UIColor.init(hexString: "#AE2CDF")
                break
                
            case 4:
                typeLabel.textColor = UIColor.init(hexString: "#FFC525")
                exchangeBtn.backgroundColor = UIColor.init(hexString: "#FFC525")
                break
                
            default: break
            }
            typeLabel.text = data.name
            activenessLabel.text = "活跃度" + data.liveness
            let c = """
            兑换所需: \(data.exchangeCount)
            总收益: \(data.total)枚
            所需任务: \(data.content)
            """
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 5
            let att = NSMutableAttributedString.init(string: c)
            att.addAttributes([.font: kFont_text_2, .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle], range: NSMakeRange(0, c.count))
            contentLabel.attributedText = att
        }
    }
    
    weak public var delegate: PVHomeAllTaskDelegate?
    
    lazy var imgIV: UIImageView = {
        let v = UIImageView()
        return v
    }()
    lazy var typeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        return l
    }()
    lazy var activenessLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .right
        return l
    }()
    lazy var contentLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        return l
    }()
    lazy var exchangeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("兑换", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(exchange(sender:)), for: .touchUpInside)
        b.layer.cornerRadius = 5
        return b
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        contentView.addSubview(imgIV)
        imgIV.addSubview(typeLabel)
        imgIV.addSubview(activenessLabel)
        imgIV.addSubview(contentLabel)
        imgIV.addSubview(exchangeBtn)
        imgIV.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10 * KScreenRatio_6)
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25 * KScreenRatio_6)
            make.top.equalToSuperview().offset(40 * KScreenRatio_6)
        }
        activenessLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-25 * KScreenRatio_6)
            make.centerY.equalTo(typeLabel)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(typeLabel)
            make.top.equalTo(typeLabel.snp.bottom).offset(10 * KScreenRatio_6)
        }
        exchangeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25 * KScreenRatio_6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if typeLabel.width > 0 {
//            let blueColors = [UIColor(red: 0.3, green: 0.48, blue: 0.98, alpha: 1).cgColor, UIColor(red: 0.33, green: 0.82, blue: 0.95, alpha: 1).cgColor]
//            typeLabel.ypj.addGradientLayer(colors: blueColors, startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), locations: nil)
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgIV.image = nil
        typeLabel.text = nil
        activenessLabel.text = nil
        contentLabel.attributedText = nil
    }
    
    @objc func exchange(sender: UIButton) {
        delegate?.didSelectedExchange(cell: self)
    }
    
}
