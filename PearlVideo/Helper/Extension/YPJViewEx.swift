//
//  YPJViewEx.swift


import Foundation

//MARK: - state view
extension UIView {
    
    //emptyButtonTag  errorButtonTag  loadingImageViewTag  unloginButtonTag
    
    ///未登录
    public func stateUnlogin(title: String, img: UIImage?) {
        guard UserDefaults.standard.value(forKey: "token") == nil else { return }
        if self.isKind(of: UIScrollView.self) { (self as! UIScrollView).isScrollEnabled = false }
        
        removeTagView()
        
        createUnloginView(title: title, img: img)
    }
    
    
    ///加载中
    public func stateLoading() {
        
        if self.isKind(of: UIScrollView.self) { (self as! UIScrollView).isScrollEnabled = false }
        
        removeTagView()
        
        let iv = self.createStateLoadingIV()
        iv.startAnimating()
    }
    
    ///正常状态
    public func stateNormal() {
        
        if self.isKind(of: UIScrollView.self) { (self as! UIScrollView).isScrollEnabled = true }
        
        removeTagView()
    }
    
    ///无数据
    public func stateEmpty(title: String?, img: UIImage?, buttonTitle: String?, handle: (() -> Void)?) {
        
        if self.isKind(of: UIScrollView.self) { (self as! UIScrollView).isScrollEnabled = true }
        
        removeTagView()
        
        self.createStateEmptyView(title: title, img: img, btnTitle: buttonTitle) {
            if handle != nil { handle!() }
        }
        
    }
    
    ///出错
    public func stateError(handle: (() -> Void)?) {
        
        if self.isKind(of: UIScrollView.self) { (self as! UIScrollView).isScrollEnabled = false }
        
        removeTagView()
        
        self.createStateErrorBtn {
            if handle != nil { handle!() }
        }
        
    }
    
    //MARK: - private method
    private func removeTagView() {
        for v in self.subviews {
            if v.tag == emptyButtonTag || v.tag == errorButtonTag || v.tag == loadingImageViewTag || v.tag == unloginButtonTag { v.removeFromSuperview() }
        }
    }
    
    //创建未登录 view
    private func createUnloginView(title: String, img: UIImage?) {
        let v = UIView()
        v.backgroundColor = self.backgroundColor
        v.tag = unloginButtonTag
        self.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
        
        let imgIV = UIImageView.init(image: img ?? UIImage.init(named: "state_unlogin"))
        v.addSubview(imgIV)
        imgIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(v)
            make.centerY.equalTo(v).multipliedBy(0.6)
        }
        
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.text = title
        l.textAlignment = .center
        v.addSubview(l)
        l.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgIV.snp.bottom).offset(5)
        }
        
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("登录/注册", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.addBlock(for: .touchUpInside) { (sender) in
            if let vc = YPJOtherTool.ypj.currentViewController() {
                YPJOtherTool.ypj.loginValidate(currentVC: vc, isLogin: {[weak self] (isLogin) in
                    if isLogin {
                        self?.stateNormal()
                    }
                })
            }
        }
        v.addSubview(b)
        b.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 40))
            make.centerX.equalTo(v)
            make.top.equalTo(l.snp.bottom).offset(40)
        }
        
    }
    
    //创建 empty view
    private func createStateEmptyView(title: String?, img: UIImage?, btnTitle: String?, handle: (() -> Void)?) {
        
        let v = UIView()
        v.backgroundColor = self.backgroundColor
        v.tag = emptyButtonTag
        self.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalTo(self)
        }
        
        let imgIV = UIImageView.init(image: img)
        v.addSubview(imgIV)
        imgIV.snp.makeConstraints { (make) in
            make.centerX.equalTo(v)
            make.centerY.equalTo(v).multipliedBy(0.6)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = kFont_text
        titleLabel.textColor = kColor_subText
        titleLabel.text = title
        titleLabel.textAlignment = .center
        v.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(v)
            make.top.equalTo(imgIV.snp.bottom).offset(20 * KScreenRatio_6)
            make.height.equalTo(20 * KScreenRatio_6)
        }
        
        if btnTitle != nil {
            let stateEmptyBtn = UIButton()
            stateEmptyBtn.backgroundColor = kColor_theme
            stateEmptyBtn.titleLabel?.font = kFont_text_3_weight
            stateEmptyBtn.setTitle(btnTitle, for: .normal)
            stateEmptyBtn.setTitleColor(UIColor.white, for: .normal)
            stateEmptyBtn.layer.cornerRadius = kCornerRadius
            stateEmptyBtn.layer.masksToBounds = true
            v.addSubview(stateEmptyBtn)
            stateEmptyBtn.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 114 * KScreenRatio_6, height: 34 * KScreenRatio_6))
                make.centerX.equalTo(v)
                make.top.equalTo(titleLabel.snp.bottom).offset(20 * KScreenRatio_6)
            }
            stateEmptyBtn.addBlock(for: .touchUpInside) { (btn) in
                handle?()
            }
        }
        
    }
    
    //创建loading view
    private func createStateLoadingIV() -> UIImageView {
        
        let stateLoadingIV = UIImageView()
        stateLoadingIV.tag = loadingImageViewTag
        self.addSubview(stateLoadingIV)
        
        stateLoadingIV.snp.remakeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
        }
        //        var imgs = Array<UIImage>()
        //
        //        for v in 1...30 {
        //            if let img = UIImage.init(named: "图层\(v)") {
        //                imgs.append(img)
        //            }
        //        }
        //        stateLoadingIV.animationImages = imgs
        //        stateLoadingIV.animationDuration = 1
        //        stateLoadingIV.animationRepeatCount = 0
        
        return stateLoadingIV
    }
    
    //创建error view
    private func createStateErrorBtn(handle: @escaping () -> Void) {
        
        let v = UIView()
        v.backgroundColor = self.backgroundColor
        v.tag = errorButtonTag
        self.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalTo(self)
        }
        
        let imgIV = UIImageView.init(image: UIImage.init(named: "state_error"))
        v.addSubview(imgIV)
        imgIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 130 * KScreenRatio_6, height: 120 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250 * KScreenRatio_6)
        }
        
        let stateErrorBtn = UIButton()
        stateErrorBtn.layer.cornerRadius = 20
        stateErrorBtn.layer.masksToBounds = true
        stateErrorBtn.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        stateErrorBtn.titleLabel?.font = kFont_text
        stateErrorBtn.setTitle("重试", for: .normal)
        stateErrorBtn.setTitleColor(UIColor.white, for: .normal)
        stateErrorBtn.addBlock(for: .touchUpInside) { (sender) in
            handle()
        }
        v.addSubview(stateErrorBtn)
        stateErrorBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 40))
            make.centerX.equalTo(v)
            make.top.equalTo(imgIV.snp.bottom).offset(40 * KScreenRatio_6)
        }
    }
    
}


