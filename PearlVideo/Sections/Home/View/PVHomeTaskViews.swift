//
//  PVHomeTaskViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/14.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 我的任务

class PVHomeMyTaskHeaderPieView: UIView {
    
    private var percent: CGFloat = 0
    
    lazy var maskLayer: CAShapeLayer = {
        let l = CAShapeLayer.init()
        let p = UIBezierPath.init(arcCenter: CGPoint.init(x: 35 * KScreenRatio_6, y: 35 * KScreenRatio_6), radius: 17.5 * KScreenRatio_6, startAngle: -CGFloat.pi * 0.5, endAngle: CGFloat.pi * 1.5, clockwise: true)
        l.strokeColor = UIColor.init(hexString: "#FFC525")?.cgColor
        l.lineWidth = 35 * KScreenRatio_6
        l.fillColor = UIColor.clear.cgColor
        l.strokeEnd = 0
        l.path = p.cgPath
        return l
    }()
    
    required convenience init(percent: CGFloat) {
        self.init()
        backgroundColor = UIColor.clear
        self.percent = percent
        layer.mask = maskLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if width > 0 {
            makePieLayer(percent: percent)
            maskAnimation()
        }
    }
    
    func makePieLayer(percent: CGFloat) {
        var start: CGFloat = -CGFloat.pi * 0.5
        var end = start
        
        let layerCount = layer.sublayers?.count ?? 0
        if layerCount >= 2 { return }
        
        let pieLayer_1 = CAShapeLayer.init()
        pieLayer_1.strokeColor = nil
        pieLayer_1.fillColor = UIColor.init(hexString: "#F43C60")?.cgColor
        pieLayer_1.strokeStart = 0
        pieLayer_1.strokeEnd = percent
        layer.addSublayer(pieLayer_1)
        
        end = start + CGFloat.pi * 2 * percent
        
        let piePath_1 = UIBezierPath.init()
        piePath_1.move(to: CGPoint.init(x: width / 2, y: height / 2))
        piePath_1.addArc(withCenter: CGPoint.init(x: width / 2, y: height / 2), radius: width / 2, startAngle: start, endAngle: end, clockwise: true)
        pieLayer_1.path = piePath_1.cgPath
        start = end
        
        let pieLayer_2 = CAShapeLayer.init()
        pieLayer_2.strokeColor = nil
        pieLayer_2.fillColor = UIColor.init(hexString: "#FFC525")?.cgColor
        pieLayer_1.strokeStart = 1 - percent
        pieLayer_1.strokeEnd = 1
        layer.addSublayer(pieLayer_2)
        
        end = start + CGFloat.pi * 2 * (1 - percent)
        let piePath_2 = UIBezierPath.init()
        piePath_2.move(to: CGPoint.init(x: width / 2, y: height / 2))
        piePath_2.addArc(withCenter: CGPoint.init(x: width / 2, y: height / 2), radius: width / 2, startAngle: start, endAngle: end, clockwise: true)
        pieLayer_2.path = piePath_2.cgPath
        
    }
    
    func maskAnimation() {
        let layerCount = layer.sublayers?.count ?? 0
        if layerCount != 2 { return }
        let an = CABasicAnimation.init(keyPath: "strokeEnd")
        an.duration = 1
        an.fromValue = NSNumber.init(value: 0)
        an.toValue = NSNumber.init(value: 1)
        an.autoreverses = false
        an.isRemovedOnCompletion = false
        an.fillMode = .forwards
        an.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        maskLayer.add(an, forKey: "strokeEnd")
    }
}

class PVHomeMyTaskHeaderView: UIView {

    lazy var watchVideoLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.text = "观看视频"
        return l
    }()
    lazy var likeLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.text = "点赞视频"
        return l
    }()
    lazy var watchFinishLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.font = kFont_text_3
        return l
    }()
    lazy var likeFinishLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white
        l.font = kFont_text_3
        return l
    }()
    
    
    required convenience init(frame: CGRect, watchPercent: Int, likePercent: Int) {
        self.init(frame: frame)
        watchFinishLabel.text = "已完成\(watchPercent)%"
        likeFinishLabel.text = "已完成\(likePercent)%"
        layer.contents = UIImage.init(named: "home_task_bg")?.cgImage
        let watchPie = PVHomeMyTaskHeaderPieView.init(percent: CGFloat(watchPercent) / 100)
        let likePie = PVHomeMyTaskHeaderPieView.init(percent: CGFloat(likePercent) / 100)
        addSubview(watchVideoLabel)
        addSubview(likeLabel)
        addSubview(watchPie)
        addSubview(likePie)
        addSubview(watchFinishLabel)
        addSubview(likeFinishLabel)
        watchVideoLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15 * KScreenRatio_6)
        }
        watchPie.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.left.equalTo(watchVideoLabel.snp.right)
            make.top.equalTo(watchVideoLabel.snp.bottom)
        }
        watchFinishLabel.snp.makeConstraints { (make) in
            make.left.equalTo(watchPie).offset(45 * KScreenRatio_6)
            make.centerY.equalTo(watchPie)
        }
        likeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(watchVideoLabel)
            make.left.equalTo(watchPie.snp.right).offset(65 * KScreenRatio_6)
        }
        likePie.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(watchPie)
            make.left.equalTo(likeLabel.snp.right)
        }
        likeFinishLabel.snp.makeConstraints { (make) in
            make.left.equalTo(likePie).offset(45 * KScreenRatio_6)
            make.centerY.equalTo(likePie)
        }
    }
    
    
    
}

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
    func didSelectedExchange(cell: PVHomeAllTaskCell, sender: UIButton)
}
class PVHomeAllTaskCell: PVBaseTableCell {
    
    public var data: PVHomeTaskList! {
        didSet{
            imgIV.image = UIImage.init(named: "home_书卷\(data.category)")
            activenessLabel.textColor = kColor_text
            exchangeBtn.setTitle(data.isExchange ? "已兑换" : "兑换", for: .normal)
            exchangeBtn.isEnabled = !data.isExchange
            switch data.category {
            case 0:
                typeLabel.textColor = kColor_pink
                exchangeBtn.backgroundColor = kColor_pink
                activenessLabel.textColor = kColor_pink
//                if data.isExchange == false {
//                    exchangeBtn.setTitle("领取", for: .normal)
//                }
                exchangeBtn.setTitle("已领取", for: .normal)
                exchangeBtn.isEnabled = false
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
        v.isUserInteractionEnabled = true
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
        exchangeBtn.setTitle(nil, for: .normal)
    }
    
    @objc func exchange(sender: UIButton) {
        delegate?.didSelectedExchange(cell: self, sender: sender)
    }
    
}
