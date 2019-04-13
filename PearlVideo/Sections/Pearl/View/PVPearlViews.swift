//
//  PVPearlViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/12.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - header view
protocol PVPearlHeaderDelegate: NSObjectProtocol {
    func didSelectedPearlDetail()
    func didSelectedPlantDetail()
    func didSelectedUserLevel()
    func didSelectedShellLevel()
    func didSelectedFeedPlant(sender: UIButton, completion: (_ increase: String?) -> Void)
}

class PVPearlHeaderView: UIView {
    
    
    weak public var delegate: PVPearlHeaderDelegate?
    
    private var pearlIncrease: String?
    
    lazy var gifBackgroundView: UIImageView = {
        let iv = UIImageView()
        iv.kf.setImage(with: URL.init(fileURLWithPath: "pearl.gif"))
        return iv
    }()
    lazy var pearlDetailBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setTitle("珍珠明细", for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!), for: .normal)
        b.setImage(UIImage.init(named: "pearl_detail_珍珠"), for: .normal)
        b.addTarget(self, action: #selector(pearlDetail), for: .touchUpInside)
        return b
    }()
    lazy var plantDetailBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setTitle("水草明细", for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!), for: .normal)
        b.setImage(UIImage.init(named: "pearl_detail_水草"), for: .normal)
        b.addTarget(self, action: #selector(plantDetail), for: .touchUpInside)
        return b
    }()
    lazy var userLevelBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setTitle("用户等级", for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!), for: .normal)
        b.setImage(UIImage.init(named: "pearl_level_用户"), for: .normal)
        b.addTarget(self, action: #selector(userLevel), for: .touchUpInside)
        return b
    }()
    lazy var shellLevelBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setTitle("贝壳等级", for: .normal)
        b.titleLabel?.font = kFont_text_3
        b.setTitleColor(UIColor.init(patternImage: UIImage.init(named: "gradient_bg")!), for: .normal)
        b.setImage(UIImage.init(named: "pearl_level_贝壳"), for: .normal)
        b.addTarget(self, action: #selector(shellLevel), for: .touchUpInside)
        return b
    }()
    lazy var feedPlantBtn: ImageTopButton = {
        let b = ImageTopButton()
        b.setImage(UIImage.init(named: "pearl_tap_水草"), for: .normal)
        b.addTarget(self, action: #selector(feedPlant(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var shellStackView: UIStackView = {
        let s = UIStackView.init()
        s.backgroundColor = UIColor.clear
        return s
    }()
    lazy var pearlAddView: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitleColor(UIColor.white, for: .normal)
        b.setImage(UIImage.init(named: "pearl_珍珠"), for: .normal)
        b.isUserInteractionEnabled = false
        b.alpha = 0
        return b
    }()
    lazy var bezierPath: UIBezierPath = {
        let b = UIBezierPath.init()
        return b
    }()
    lazy var animationLayer: CALayer = {
        let l = CALayer.init()
        l.contents = UIImage.init(named: "pearl_水草")!.cgImage
        l.frame = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        l.isHidden = true
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(animationLayer)
        addSubview(gifBackgroundView)
        gifBackgroundView.addSubview(pearlDetailBtn)
        gifBackgroundView.addSubview(plantDetailBtn)
        gifBackgroundView.addSubview(userLevelBtn)
        gifBackgroundView.addSubview(shellLevelBtn)
        gifBackgroundView.addSubview(feedPlantBtn)
        gifBackgroundView.addSubview(shellStackView)
        gifBackgroundView.addSubview(pearlAddView)
       
        gifBackgroundView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        pearlDetailBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10 * KScreenRatio_6)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        plantDetailBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(pearlDetailBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        userLevelBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(plantDetailBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        shellLevelBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(userLevelBtn.snp.bottom).offset(15 * KScreenRatio_6)
        }
        feedPlantBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.bottom.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        shellStackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(70 * KScreenRatio_6)
            make.right.equalTo(feedPlantBtn.snp.left).offset(-5)
            make.height.equalTo(40 * KScreenRatio_6)
            make.bottom.equalToSuperview()
        }
        pearlAddView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(shellStackView.snp.top).offset(-10)
        }
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func pearlDetail() {
        delegate?.didSelectedPearlDetail()
    }
    
    @objc func plantDetail() {
        delegate?.didSelectedPlantDetail()
    }
    
    @objc func userLevel() {
        delegate?.didSelectedUserLevel()
    }
    
    @objc func shellLevel() {
        delegate?.didSelectedShellLevel()
    }
    
    @objc func feedPlant(sender: UIButton) {
        delegate?.didSelectedFeedPlant(sender: sender, completion: { (increase) in
            self.pearlIncrease = increase
            self.pearlAddView.setTitle(increase, for: .normal)
            self.followAnimation()
        })
    }
    
    //跟进动画
    func followAnimation() {
        let startPoint = feedPlantBtn.origin
        let endPoint = CGPoint.init(x: shellStackView.centerX + feedPlantBtn.width / 2, y: shellStackView.origin.y)
        let curvePoint = CGPoint.init(x: (endPoint.x - startPoint.x) + endPoint.x, y: startPoint.y - 50 * KScreenRatio_6)
        
        bezierPath.move(to: startPoint)
        bezierPath.addCurve(to: endPoint, controlPoint1: startPoint, controlPoint2: curvePoint)
        
        let t: CFTimeInterval = 1
        
        let an = CAKeyframeAnimation.init(keyPath: "position")
        an.path = bezierPath.cgPath
        an.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        an.duration = t
        
        let alphaAn = CABasicAnimation.init(keyPath: "alpha")
        alphaAn.beginTime = 0.7
        alphaAn.duration = t - 0.7
        alphaAn.fromValue = NSNumber.init(value: 1.0)
        alphaAn.toValue = NSNumber.init(value: 0.1)
        alphaAn.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        
        
        let groups = CAAnimationGroup.init()
        groups.animations = [an, alphaAn]
        groups.duration = t
//        groups.isRemovedOnCompletion = false
        groups.fillMode = .forwards
        groups.delegate = self
        
        animationLayer.add(groups, forKey: nil)
      
    }
    
}

extension PVPearlHeaderView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        animationLayer.isHidden = false
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        animationLayer.isHidden = true
        bezierPath.removeAllPoints()
        
        if self.pearlIncrease != nil {
            
            self.pearlAddView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                
                var center = self.pearlAddView.center
                center.y -= 200 * KScreenRatio_6
                self.pearlAddView.center = center
                self.pearlAddView.alpha = 0
                
            }) { (isFinish) in
                
                if isFinish {
                    self.pearlAddView.snp.remakeConstraints({ (make) in
                        make.centerX.equalToSuperview()
                        make.bottom.equalTo(self.shellStackView.snp.top).offset(-10)
                    })
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
}


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
        addSubview(marketBtn)
        addSubview(taskLabel)
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
        marketBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.top.equalToSuperview().offset(20 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        sepView_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 10 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(iconIV.snp.bottom).offset(20 * KScreenRatio_6)
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
