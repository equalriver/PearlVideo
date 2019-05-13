
//
//  PVMeSettingVCChild.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 实名认证
class PVMeNameValidateVC: PVBaseNavigationVC {
    
    var name: String?
    var phone: String?
    var idCard: String?
    let titles = ["真实姓名", "联系电话", "身份证号码"]
    
    lazy var headerView: UILabel = {
        let v = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 55))
        v.backgroundColor = UIColor.white
        let sep = UIView.init(frame: CGRect.init(x: 0, y: 54.5, width: kScreenWidth, height: 0.5))
        sep.backgroundColor = kColor_background
        v.addSubview(sep)
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.dataSource = self
        tb.delegate = self
        tb.isScrollEnabled = false
        return tb
    }()
    lazy var checkBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("同意珍视频用户协议", for: .normal)
        b.setTitleColor(kColor_pink, for: .normal)
        b.setImage(UIImage.init(named: "login_unselected"), for: .normal)
        b.setImage(UIImage.init(named: "login_selected"), for: .selected)
        b.isSelected = true
        b.addTarget(self, action: #selector(acceptAgreement(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitle("开始认证", for: .normal)
        b.titleLabel?.font = kFont_text
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.isEnabled = false
        b.addTarget(self, action: #selector(confirm(sender:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"
        initUI()
        
    }
    
    func initUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(checkBtn)
        view.addSubview(confirmBtn)
        headerView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 55 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(150 * KScreenRatio_6)
        }
        checkBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalTo(tableView.snp.bottom).offset(10 * KScreenRatio_6)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.equalTo(checkBtn.snp.bottom).offset(30 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
    }
    
}


//MARK: - 修改密码
class PVMePasswordChangeVC: PVBaseNavigationVC {
    
    
    lazy var phoneTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入手机号码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.delegate = self
        return tf
    }()
    lazy var authCodeTF: PVBottomLineTextField = {
        let tf = PVBottomLineTextField()
        tf.font = kFont_text
        tf.placeholder = "请输入验证码"
        tf.textColor = kColor_text
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numbersAndPunctuation
        tf.delegate = self
        return tf
    }()
    lazy var getAuthCodeBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("获取验证码", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.addTarget(self, action: #selector(didClickGetAuthCode(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var nextBtn: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage.init(named: "gradient_bg"), for: .normal)
        b.titleLabel?.font = kFont_text
        b.setTitle("下一步", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.layer.cornerRadius = 20 * KScreenRatio_6
        b.layer.masksToBounds = true
        b.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        b.isEnabled = false
        return b
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 1)
        return t
    }()
    
    
    //life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    deinit {
        timer.resume()
        timer.cancel()
    }
    
    func initUI() {
        view.addSubview(phoneTF)
        view.addSubview(authCodeTF)
        view.addSubview(getAuthCodeBtn)
        view.addSubview(nextBtn)
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(naviBar.snp.bottom).offset(40 * KScreenRatio_6)
            make.size.equalTo(CGSize.init(width: 300 * KScreenRatio_6, height: 30 * KScreenRatio_6))
        }
        authCodeTF.snp.makeConstraints { (make) in
            make.left.height.equalTo(phoneTF)
            make.top.equalTo(phoneTF.snp.bottom).offset(40 * KScreenRatio_6)
            make.width.equalTo(170 * KScreenRatio_6)
        }
        getAuthCodeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 130 * KScreenRatio_6, height: 30 * KScreenRatio_6))
            make.centerY.equalTo(authCodeTF)
            make.left.equalTo(authCodeTF.snp.right).offset(30 * KScreenRatio_6)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 330 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(getAuthCodeBtn.snp.bottom).offset(30 * KScreenRatio_6)
        }
        
    }
    
}


//MARK: - 意见反馈
class PVMeFeedbackVC: PVBaseNavigationVC {
    
    let addImg = UIImage.init(named: "setting_背景图")!
    var imgs: [UIImage]!
    var content = ""
    var contact = ""
    
    var selectedImageIndex = 0
    
    
    lazy var contentView: PVMeFeedbackItemView = {
        let v = PVMeFeedbackItemView.init(title: "欢迎您对我们提出意见或建议", placeholder: "您遇到的问题以及建议", delegate: self)
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var contactView: PVMeFeedbackItemView = {
        let v = PVMeFeedbackItemView.init(title: "留下您的邮箱/手机号/QQ", placeholder: "留下您的联系方式方便我们回馈您", delegate: self)
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var imgTitleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_text
        l.text = "上传问题截图"
        return l
    }()
    lazy var imgCollectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6)
        l.minimumLineSpacing = 12
        l.minimumInteritemSpacing = 12
        l.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: l)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.register(PVMeFeedbackCell.self, forCellWithReuseIdentifier: "PVMeFeedbackCell")
        return cv
    }()
    lazy var commitBtn: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = kFont_text
        b.setTitle("提交", for: .normal)
        b.setTitleColor(kColor_background, for: .disabled)
        b.setTitleColor(kColor_pink, for: .normal)
        b.isEnabled = false
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "意见反馈"
        imgs = [addImg]
        naviBar.rightBarButtons = [commitBtn]
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowAction(noti:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideAction(noti:)), name: UIApplication.keyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initUI() {
        view.addSubview(contentView)
        view.addSubview(contactView)
        view.addSubview(imgTitleLabel)
        view.addSubview(imgCollectionView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(130 * KScreenRatio_6)
        }
        imgTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.bottom).offset(15 * KScreenRatio_6)
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        imgCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.top.equalTo(imgTitleLabel.snp.bottom).offset(10 * KScreenRatio_6)
            make.height.equalTo(90 * KScreenRatio_6)
            make.width.equalTo(kScreenWidth - 40 * KScreenRatio_6)
        }
        contactView.snp.makeConstraints { (make) in
            make.top.equalTo(imgCollectionView.snp.bottom).offset(15 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(130 * KScreenRatio_6)
        }
    }
    
}


//MARK: - 检测更新
class PVMeVersionVC: PVBaseNavigationVC {
    
    let items = ["去评分", "更新"]
    //最新版本号
    var newVersion = ""
    
    
    lazy var logoIV: UIImageView = {
        let iv = UIImageView.init(image: UIImage.init(named: "me_logo"))
        return iv
    }()
    lazy var versionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.backgroundColor = kColor_background
        let s = "珍视v" + (YPJOtherTool.ypj.currentVersion ?? "")
        let att = NSMutableAttributedString.init(string: s)
        att.addAttributes([.font: UIFont.systemFont(ofSize: 25 * KScreenRatio_6, weight: .semibold),
                           .foregroundColor: kColor_text!], range: NSMakeRange(0, 2))
        att.addAttributes([.font: UIFont.systemFont(ofSize: 18 * KScreenRatio_6),
                           .foregroundColor: kColor_text!], range: NSMakeRange(2, s.count - 2))
        l.attributedText = att
        return l
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = kColor_background
        tb.dataSource = self
        tb.delegate = self
        tb.isScrollEnabled = false
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "版本"
        view.backgroundColor = kColor_background
        initUI()
    }
    
    func initUI() {
        view.addSubview(logoIV)
        view.addSubview(versionLabel)
        view.addSubview(tableView)
        logoIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 70 * KScreenRatio_6))
            make.centerX.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(40 * KScreenRatio_6)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoIV.snp.bottom).offset(30 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.width.bottom.centerX.equalToSuperview()
            make.top.equalTo(versionLabel.snp.bottom).offset(60 * KScreenRatio_6)
        }
    }
    
}
