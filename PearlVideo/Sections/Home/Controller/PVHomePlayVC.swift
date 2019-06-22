//
//  PVHomePlayVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import AliyunVodPlayerSDK


class PVHomePlayVC: PVBaseViewController {

//    var accessKeyId: String?
//
//    var accessKeySecret: String?
//
//    var securityToken: String?
    
    var videoId = ""
    
    var userId = ""
    
    var videoIndex = 0
    
    var page = 0
    
    var currentIndex = 0
    
    
    /*
     type = 1 = 推荐
     type = 2 = 关注
     type = 3 = 我的作品
     type = 4 = 我的喜欢视频
     type = 5 = 私密视频
     */
    var type = 0
    
    var dataArr = Array<PVVideoPlayModel>()
    
    
    ///播放界面容器视图数组
    var playContainerList = [PVHomePlayContainerView]()
    
    ///当前正在播放的容器视图
    var currentPlayContainer: PVHomePlayContainerView? {
        didSet{
            allContainView.playContainer = currentPlayContainer
        }
    }
    ///评论视图
    weak var commentView: PVVideoCommentView?
    
    ///是否加载过图片
//    var isHaveQuerryImageWhenFirstEnter = false
    
    ///是否已经查询完全部的数据了
//    var isHaveQuerryAllVideo = false
    
    ///记录播放时间
    var playTimeMinutes: Int? 
    
    ///是否正在记录播放时间
    var isRecordPlayTime = false
    
    var isTimerRun = false

    ///记录的播放状态 - 退出后台前，再次进入前台的时候恢复之前的播放状态
    var savedPlayStatus: AliyunVodPlayerState? {
        willSet{
            if newValue != nil && newValue! == .play && isRecordPlayTime == false && timer.isCancelled == false {
                isRecordPlayTime = true
                timer.resume()
                isTimerRun = true
            }
            if newValue != nil && newValue! != .play && isRecordPlayTime && timer.isCancelled == false {
                isRecordPlayTime = false
                timer.suspend()
                isTimerRun = false
            }
        }
    }
    
    ///是否在前台处于活跃状态
    var isActive = true
    
    ///轻量化的本地现在去重方案，本地已下载的视频id以逗号分隔
    var localVideosIdString: String?
    
    ///视频上传到oss服务器上之后，用于插入appserverd数据库的字典 - 临时存储用于失败的再次尝试发布
    var publishParamDic: [String: Any]?
    
    ///是否播放固定的视频
    var isOnlyPlayStableVideo = false
    
    ///播放固定的视频的开始下标
    var playStableVideoStartIndex = 0 {
        willSet{
            isOnlyPlayStableVideo = true
        }
    }
    
    ///正在下载的视频参数
    var readyDataSource: AliyunDataSource?
    
    ///正在下载的mediaInfo
    var downloadingMediaInfo: AliyunDownloadMediaInfo?
    
    lazy var reachability: YYReachability = {
        let r = YYReachability.init()
        return r
    }()
    //交互视图层
    lazy var allContainView: PVHomePlayMaskView = {
        let v = PVHomePlayMaskView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        v.delegate = self
        return v
    }()
    lazy var backBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "back_arrow"), for: .normal)
        b.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        return b
    }()
    //播放时间进度条
    lazy var playTimeProgressView: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.white
        v.textAlignment = .center
        v.font = kFont_text_2
        v.backgroundColor = UIColor.clear
        let b = UIBezierPath.init(arcCenter: CGPoint.init(x: 15, y: 15), radius: 15, startAngle: -CGFloat.pi * 0.5, endAngle: CGFloat.pi * 1.5, clockwise: true)
        let l = CAShapeLayer.init()
        l.strokeColor = UIColor.gray.cgColor
        l.lineWidth = 3
        l.fillColor = UIColor.clear.cgColor
        l.strokeEnd = 1
        l.lineCap = CAShapeLayerLineCap.round
        l.path = b.cgPath
        v.layer.addSublayer(l)
        return v
    }()
    lazy var playTimeProgress: CAShapeLayer = {
        let b = UIBezierPath.init(arcCenter: CGPoint.init(x: 15, y: 15), radius: 15, startAngle: -CGFloat.pi * 0.5, endAngle: CGFloat.pi * 1.5, clockwise: true)
        let l = CAShapeLayer.init()
        l.strokeColor = UIColor.green.cgColor
        l.lineWidth = 3
        l.fillColor = UIColor.clear.cgColor
        l.strokeEnd = 0
        l.path = b.cgPath
        l.lineCap = CAShapeLayerLineCap.round
        return l
    }()
    lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.main)
        t.schedule(deadline: .now(), repeating: 60)
        return t
    }()
    lazy var likeAnimationIV: UIImageView = {
        let v = UIImageView.init(image: UIImage.init(named: "video_点赞动画"))
        v.isHidden = true
        v.alpha = 0.9
        return v
    }()
   
    
    public required convenience init(type: Int, videoId: String, videoIndex: Int, userId: String) {
        self.init()
        self.type = type
        self.videoId = videoId
        self.videoIndex = videoIndex
        self.userId = userId
        initUI()
        
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //禁用自动息屏
        UIApplication.shared.isIdleTimerDisabled = true
        initPlayConfig()
        initDownloadConfig()
        addNotification()
        addGesture()
//        getSTS()
        firstLoadData()
        loadPlayTime()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AliyunVodDownLoadManager.share()?.downloadDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPlayContainer?.vodPlayer != nil && commentView == nil {
            currentPlayContainer?.vodPlayer.resume()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if currentPlayContainer?.vodPlayer != nil {
            currentPlayContainer?.vodPlayer.pause()
        }
    }
    
    deinit {
        if isTimerRun == false { timer.resume() }
        timer.cancel()
        for v in playContainerList {
            if v.vodPlayer != nil {
                v.vodPlayer.release()
            }
        }
        dataArr.removeAll()
        if downloadingMediaInfo != nil {
            AliyunVodDownLoadManager.share()?.stopDownloadMedia(downloadingMediaInfo!)
        }
        NotificationCenter.default.removeObserver(self)
     
    }
    


    //MARK: - UI
    func initUI() {
        view.addSubview(allContainView)
        view.addSubview(backBtn)
        view.addSubview(playTimeProgressView)
        playTimeProgressView.layer.addSublayer(playTimeProgress)
        allContainView.addSubview(likeAnimationIV)
        backBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.left.equalToSuperview().offset(15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(kIphoneXLatterInsetHeight + 20)
        }
        playTimeProgressView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
            make.right.equalToSuperview().offset(-15 * KScreenRatio_6)
            make.top.equalToSuperview().offset(kIphoneXLatterInsetHeight + 20)
        }
        likeAnimationIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 80, height: 80))
            make.center.equalToSuperview()
        }
    }

    //初始化播放器,播放器的容器view等
    func initPlayConfig() {
        let allCount = kNextCount + kPreviousCount + 1
        for i in 0..<allCount {
            let player = AliyunVodPlayer.init()
            player.delegate = self
            player.isAutoPlay = false   //是否自动播放
            player.circlePlay = true    //循环播放控制
            player.displayMode = .fit   //浏览方式
            player.quality = .videoFD   //流畅度
            let pathArray = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
            //maxsize:单位 mb    maxDuration:单位秒 ,在prepare之前调用。 - 设置本地缓存
            player.setPlayingCache(true, saveDir: pathArray.first, maxSize: 1024, maxDuration: 10000)
            
            let conView = PVHomePlayContainerView.init(vodPlayer: player)
            conView.frame = UIScreen.main.bounds
            var conFrame = conView.frame
            conFrame.origin.y = CGFloat(i) * kScreenHeight + 1
            conView.frame = newFrameWithHandleFrame(frame: conFrame)
            view.addSubview(conView)
            
            playContainerList.append(conView)
        }
        //禁用自动息屏
        UIApplication.shared.isIdleTimerDisabled = true
        localVideosIdString = UserDefaults.standard.string(forKey: "localVideosIdString")
    }
 
    func initDownloadConfig() {
        let downloadManager = AliyunVodDownLoadManager.share()
        DispatchQueue.ypj_once(token: self.description) {
            let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            downloadManager?.setDownLoadPath(path)
            let encrptyFilePath = Bundle.main.path(forResource: "encryptedApp", ofType: "dat")
            //设置加密文件
            downloadManager?.setEncrptyFile(encrptyFilePath)
            //同时下载数
            downloadManager?.setMaxDownloadOperationCount(1)
            //下载进度监听器
            downloadManager?.downLoadInfoListenerDelegate(self)
        }
    }

    //做一些首次进入关于视频的处理 - 加载封面图 - 播放第一个视频
    func firstHandleWhenHavedataArrWithStartPlayIndex(startPlayIndex: inout Int) {
        //错误处理
        if startPlayIndex > dataArr.count - 1 { startPlayIndex = dataArr.count - 1 }
        //下拉刷新的时候停止播放之前播放中的视频
        if currentPlayContainer?.vodPlayer != nil { currentPlayContainer?.vodPlayer.stop() }
        
        let startIndex = startPlayIndex - kPreviousCount
        for i in 0..<playContainerList.count {
            //取数据源设置播放数据
            var dataIndex = i
            if startIndex > 0 { dataIndex = i + startIndex }
            //初始化预加载资源
            if dataIndex < dataArr.count {
                let model = dataArr[dataIndex]
                let conView = playContainerList[i]
                if conView.data != nil {
                    //如果之前有viewModel，这次reset一下，初始化状态，包括已经准备好的视频要变为初始状态
                    conView.vodPlayer.reset()
                    conView.isHavePrepared = false
                }
                conView.data = model
                conView.coverImageView.isHidden = false
            }
            else { print("预加载的个数超过了视频资源本身的个数") }
        }
        //处理要播放的视频
        //1.寻找要播放的视频
        var realPalyIndex = 0
        if startPlayIndex < dataArr.count { realPalyIndex = startPlayIndex }
        let model = dataArr[realPalyIndex]
        var conView: PVHomePlayContainerView?
        var indexInPlayConViewList = 0
        for (k, v) in playContainerList.enumerated() {
            if v.data == model {
                conView = v
                indexInPlayConViewList = k
                break
            }
        }
        
        //2.调整资源的位置
        for (k, v) in playContainerList.enumerated() {
            var f = v.frame
            if k < indexInPlayConViewList { f.origin.y = -1 * kScreenHeight - 1 }
            else if k == indexInPlayConViewList { f.origin.y = 0 }
            else { f.origin.y = kScreenHeight + 1 }
            v.frame = f
        }
        
        //3.处理要播放的视频
        if conView != nil {
            currentPlayContainer = conView
            //显示第一个视频的封面
            currentPlayContainer?.coverImageView.kf.setImage(with: URL.init(string: model.coverUrl), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (img, error, cacheType, url) in
                if error == nil && img != nil {
                    self.currentPlayContainer?.coverImageView.isHidden = self.currentPlayContainer?.playerState == .play || self.currentPlayContainer?.playerState == .pause
                }
            })
            
            conView?.isHavePrepared = true
            prepareWithPlayer(player: conView!.vodPlayer, model: model)
        }
    }
    
    //添加通知
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resignActive), name: UIApplication.willResignActiveNotification, object: nil)
        reachability.notifyBlock = {[weak self] (reach) in
            switch reach.status {
            case .none:
                self?.view.makeToast("请检查网络连接")
                
            case .WWAN:
                self?.view.makeToast("当前使用手机网络,请注意流量消耗")
                
            default:
                break
            }
        }
    }
    
    //添加手势
    func addGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.addTarget(self, action: #selector(tapAction(sender:)))
        allContainView.gestureView.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        doubleTapGesture.addTarget(self, action: #selector(doubleTapAction(sender:)))
        tapGesture.require(toFail: doubleTapGesture)
        allContainView.gestureView.addGestureRecognizer(doubleTapGesture)
        
        let panGesture = UIPanGestureRecognizer.init()
        panGesture.addTarget(self, action: #selector(panAction(sender:)))
        allContainView.gestureView.addGestureRecognizer(panGesture)
    }
    
    
}
