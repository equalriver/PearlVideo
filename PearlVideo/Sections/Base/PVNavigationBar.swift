//
//  PVNavigationBar.swift


import UIKit
import SnapKit

public protocol PVNavigationButtonDelegate: class {
    func leftButtonsAction(sender: UIButton)
    func rightButtonsAction(sender: UIButton)
}

class PVNavigationBar: UIView {
    
    weak public var delegate: PVNavigationButtonDelegate?
    
    override var backgroundColor: UIColor? {
        didSet{
            for v in self.subviews {
                v.backgroundColor = backgroundColor
            }
        }
    }
    ///默认显示返回
    public var isNeedBackButton = true {
        didSet{
            backBtn.isHidden = !isNeedBackButton
        }
    }
    
    //title view
    public lazy var titleView: UIView = {
        let v = UILabel.init()
        v.backgroundColor = .clear
        v.font = kFont_btn_weight
        v.textColor = UIColor.white
        v.textAlignment = .center
        return v
    }()
    
    //title
    public var naviTitle = "" {
        willSet{
            if titleView.isKind(of: UILabel.self) {
                let label = titleView as! UILabel
                label.text = newValue
            }
        }
    }
    
    //title color
    public var naviTitleColor = UIColor.white {
        willSet{
            if titleView.isKind(of: UILabel.self) {
                let label = titleView as! UILabel
                label.textColor = newValue
            }
        }
    }
    
    ///底部的黑线
    public lazy var naviBottomLine: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 0.5))
        v.backgroundColor = kColor_background
        v.isOpaque = true
        return v
    }()
    
    ///背景图
    public var naviBackgroundImage = UIImage() {
        willSet{
            self.layer.contents = newValue.cgImage
        }
    }
    
    //返回按钮
    public lazy var backBtn: UIButton = {
        let b = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: navigationBarButtonWidth, height: navigationBarButtonHeight))
        b.tag = naviBackButtonTag
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        return b
    }()
    
    //leftBarButtons stack view
    private lazy var leftBtnBgView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .leading
        v.distribution = .equalSpacing
        return v
    }()
    //rightBarButtons stack view
    private lazy var rightBtnBgView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .leading
        v.distribution = .equalSpacing
        return v
    }()
    
    ///leftBarButtons
    public var leftBarButtons = Array<UIButton>.init() {
        willSet{
            leftBtnBgView.snp.updateConstraints { (make) in
                make.width.equalTo((CGFloat)(newValue.count) * (navigationBarButtonWidth + 5))
            }
            for item in newValue {
                item.titleLabel?.font = kFont_naviBtn_weight
                item.tag = item.tag == naviBackButtonTag ? naviBackButtonTag : newValue.index(of: item)!
                
                if leftBtnBgView.arrangedSubviews.contains(item) {
                    leftBtnBgView.removeArrangedSubview(item)
                    item.removeAllTargets()
                }
                else {
                    leftBtnBgView.addArrangedSubview(item)
                    item.addTarget(self, action: #selector(didClickLeftBarButton(sender:)), for: .touchUpInside)
                }
            }
            
        }
    }
    
    public var rightBarButtons = Array<UIButton>.init(){
        willSet {
            var totalWidth: CGFloat = 0
            
            for item in newValue {
                item.titleLabel?.font = kFont_naviBtn_weight
                item.tag = newValue.index(of: item)!
                if let text = item.titleLabel?.text {
                    totalWidth += text.ypj.getStringWidth(font: kFont_naviBtn_weight, height: navigationBarButtonHeight)
                }
                
                if rightBtnBgView.arrangedSubviews.contains(item) {
                    rightBtnBgView.removeArrangedSubview(item)
                    item.removeAllTargets()
                }
                else {
                    rightBtnBgView.addArrangedSubview(item)
                    item.addTarget(self, action: #selector(didClickRightBarButton(sender:)), for: .touchUpInside)
                }
            }
            totalWidth = totalWidth > navigationBarButtonWidth + 5 ? totalWidth : navigationBarButtonWidth + 5
            rightBtnBgView.snp.updateConstraints { (make) in
                make.width.equalTo((CGFloat)(newValue.count) * 5 + totalWidth)
            }
        }
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = kColor_deepBackground
        initUI()
    }
    
    func initUI() {
        addSubview(naviBottomLine)
        addSubview(titleView)
        addSubview(leftBtnBgView)
        addSubview(rightBtnBgView)
        
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
            make.width.equalTo(kScreenWidth - navigationBarButtonWidth * 3 - 30)
            make.height.equalTo(30 * KScreenRatio_6)
        }
        leftBtnBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(titleView)
            make.height.equalTo(navigationBarButtonHeight)
            make.width.equalTo(navigationBarButtonWidth)
        }
        rightBtnBgView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(titleView)
            make.height.equalTo(navigationBarButtonHeight)
            make.width.equalTo(navigationBarButtonWidth)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - action
    @objc func didClickLeftBarButton(sender: UIButton) {
        
        delegate?.leftButtonsAction(sender: sender)
    }
    
    @objc func didClickRightBarButton(sender: UIButton) {
        
        delegate?.rightButtonsAction(sender: sender)
    }
}



