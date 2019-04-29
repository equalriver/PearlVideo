//
//  PVPearlHeaderViews.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/27.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Lottie


//MARK: - header view
protocol PVPearlHeaderDelegate: NSObjectProtocol {
    func didSelectedLevelUp()
    func didSelectedPearlDetail()
    func didSelectedPlantDetail()
    func didSelectedUserLevel()
    func didSelectedShellLevel()
    func didSelectedFeedPlant(sender: UIButton, completion: @escaping (_ increase: String?) -> Void)
}

class PVPearlHeaderView: UIView {
    
    
    weak public var delegate: PVPearlHeaderDelegate?
    
    private var pearlIncrease: String?
    
    lazy var animationBackgroundView: LOTAnimationView = {
        let v = LOTAnimationView.init(name: "pearlAnimation.json", bundle: Bundle.main)
        v.animationSpeed = 1.0
        v.loopAnimation = true
        return v
    }()
    lazy var levelUpView: PVPearlHeaderLevelUpView = {
        let v = PVPearlHeaderLevelUpView.init(frame: .zero)
        v.layer.cornerRadius = 20 * KScreenRatio_6
        //        v.layer.masksToBounds = true
        v.backgroundColor = UIColor.init(hexString: "#85ECFC")
        v.levelUpBtn.addTarget(self, action: #selector(levelUp), for: .touchUpInside)
        return v
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
        initUI()
        animationBackgroundView.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(animationBackgroundView)
        animationBackgroundView.addSubview(levelUpView)
        animationBackgroundView.addSubview(pearlDetailBtn)
        animationBackgroundView.addSubview(plantDetailBtn)
        animationBackgroundView.addSubview(userLevelBtn)
        animationBackgroundView.addSubview(shellLevelBtn)
        animationBackgroundView.addSubview(feedPlantBtn)
        animationBackgroundView.addSubview(shellStackView)
        animationBackgroundView.addSubview(pearlAddView)
        layer.addSublayer(animationLayer)
        
        animationBackgroundView.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        levelUpView.snp.makeConstraints { (make) in
            make.height.equalTo(40 * KScreenRatio_6)
            make.top.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.width.equalTo(130)
        }
        pearlDetailBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50 * KScreenRatio_6, height: 60 * KScreenRatio_6))
            make.right.equalToSuperview().offset(-10 * KScreenRatio_6)
            make.top.equalToSuperview().offset(10 * KScreenRatio_6)
        }
        plantDetailBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(pearlDetailBtn.snp.bottom).offset(10 * KScreenRatio_6)
        }
        userLevelBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(plantDetailBtn.snp.bottom).offset(10 * KScreenRatio_6)
        }
        shellLevelBtn.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(pearlDetailBtn)
            make.top.equalTo(userLevelBtn.snp.bottom).offset(10 * KScreenRatio_6)
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
    
    @objc func levelUp() {
        delegate?.didSelectedLevelUp()
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
            self.feedAnimation()
        })
    }
    
    //喂养动画
    func feedAnimation() {
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

//MARK: - 贝壳升级view
class PVPearlHeaderLevelUpView: UIView {
    
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "pearl_珍珠"))
        return v
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = UIColor.white
        return l
    }()
    lazy var levelUpBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text_2
        b.setTitle("升级", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.init(hexString: "#F9DF4F")
        b.layer.cornerRadius = 12.5 * KScreenRatio_6
        b.layer.masksToBounds = true
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconIV)
        addSubview(countLabel)
        addSubview(levelUpBtn)
        iconIV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        levelUpBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-7)
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 25 * KScreenRatio_6))
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 水草喂养alert
class PVPearlHeaderFeedAlert: UIView {
    
    private var feedCount = 0 {
        didSet{
            countTF.text = "\(feedCount)"
        }
    }
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
    lazy var iconIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "pearl_detail_水草"))
        return v
    }()
    lazy var plantLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.textAlignment = .center
        l.text = "可以喂养贝壳"
        return l
    }()
    lazy var minusBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("-", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.init(hexString: "#6AE15A")
        let rect = CGRect.init(x: 0, y: 0, width: 45 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        b.ypj.makeViewRoundingMask(roundedRect: rect, corners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        b.addTarget(self, action: #selector(minusAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var addBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("+", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.init(hexString: "#6AE15A")
        let rect = CGRect.init(x: 0, y: 0, width: 45 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        b.ypj.makeViewRoundingMask(roundedRect: rect, corners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize.init(width: rect.height / 2, height: rect.height / 2))
        b.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var countTF: UITextField = {
        let tf = UITextField()
        tf.font = kFont_text
        tf.textColor = kColor_text
        tf.textAlignment = .center
        tf.keyboardType = .numbersAndPunctuation
        tf.layer.borderColor = UIColor.init(hexString: "#6AE15A")!.cgColor
        tf.layer.borderWidth = 1
        tf.delegate = self
        return tf
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("取消", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = kColor_background
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var feedBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_btn_weight
        b.setTitle("喂养", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.backgroundColor = UIColor.init(hexString: "#6AE15A")
        return b
    }()
    
    
    public required convenience init(totalCount: Int, completion: @escaping (_ plantCount: Int?) -> Void) {
        self.init()
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.init(white: 0.3, alpha: 0.6)
        feedCount = totalCount
        feedBtn.addBlock(for: .touchUpInside) {[weak self] (btn) in
            completion(self?.feedCount)
        }
        initUI()
        scaleAnimation(view: contentView)
    }
    
    func initUI() {
        addSubview(contentView)
        addSubview(iconIV)
        contentView.addSubview(plantLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(minusBtn)
        contentView.addSubview(addBtn)
        contentView.addSubview(countTF)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(feedBtn)
        contentView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 290 * KScreenRatio_6, height: 250 * KScreenRatio_6))
            make.center.equalToSuperview()
        }
        iconIV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 75 * KScreenRatio_6, height: 75 * KScreenRatio_6))
            make.bottom.equalTo(contentView.snp.top).offset(37.5 * KScreenRatio_6)
        }
        plantLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(70 * KScreenRatio_6)
            make.centerX.width.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.size.centerX.equalTo(plantLabel)
            make.top.equalTo(plantLabel.snp.bottom).offset(5)
        }
        countTF.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30 * KScreenRatio_6)
        }
        minusBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 45 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalTo(countTF)
            make.right.equalTo(countTF.snp.left)
        }
        addBtn.snp.makeConstraints { (make) in
            make.size.centerY.equalTo(minusBtn)
            make.left.equalTo(countTF.snp.right)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50 * KScreenRatio_6)
            make.bottom.left.equalToSuperview()
        }
        feedBtn.snp.makeConstraints { (make) in
            make.size.equalTo(cancelBtn)
            make.right.bottom.equalToSuperview()
        }
    }
    
    func scaleAnimation(view: UIView) {
        let an = CAKeyframeAnimation.init(keyPath: "transform")
        an.duration = 0.4
        an.beginTime = 0.0
        an.fillMode = .forwards
        an.isRemovedOnCompletion = true
        an.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        var values = Array<Any>()
        values.append(NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 0, y: 0)))
        values.append(NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 1, y: 1)))
        an.values = values
        
        let an_1 = CAKeyframeAnimation.init(keyPath: "transform")
        an_1.duration = 0.3
        an_1.beginTime = 0.4
        an_1.fillMode = .forwards
        an_1.isRemovedOnCompletion = true
        an_1.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        var values_1 = Array<Any>()
        values_1.append(NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 1, y: 1)))
        values_1.append(NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 0.8, y: 0.8)))
        values_1.append(NSValue.init(cgAffineTransform: CGAffineTransform.init(scaleX: 1, y: 1)))
        an_1.values = values
        
        let groups = CAAnimationGroup.init()
        groups.animations = [an, an_1]
        groups.duration = 0.7
        groups.isRemovedOnCompletion = true
        groups.fillMode = .forwards
        
        view.layer.add(groups, forKey: nil)
    }
    
    @objc func minusAction(sender: UIButton) {
        
    }
    
    @objc func addAction(sender: UIButton) {
        
    }
    
    @objc func cancelAction(sender: UIButton) {
        removeFromSuperview()
    }
    
}

extension PVPearlHeaderFeedAlert: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard textField.hasText else { return true }
        if textField.text!.ypj.isAllNumber {
            feedCount = Int(textField.text!) ?? feedCount
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return string.ypj.isAllNumber
    }
}
