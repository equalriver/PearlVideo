//
//  PVHomePlayVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit
import AliyunVodPlayerSDK

//视频高度
let playViewHeight = kScreenHeight - kTabBarHeight

class PVHomePlayVC: PVBaseViewController {
    
    
    var accessKeyId: String?
    
    var accessKeySecret: String?
    
    var securityToken: String?
    
    //播放数据源列表
    var videoList = [AlivcQuVideoModel]()
    
    //播放界面容器视图数组
    var playContainerList = [PVHomePlayContainerView]()
    
    //当前正在播放的容器视图
    var currentPlayContainer: PVHomePlayContainerView?
    
    //是否加载过图片
    var isHaveQuerryImageWhenFirstEnter = false
    
    //是否已经查询完全部的数据了
    var isHaveQuerryAllVideo = false

    //记录的播放状态 - 退出后台前，再次进入前台的时候恢复之前的播放状态
    var savedPlayStatus: AliyunVodPlayerState?
    
    //是否在前台处于活跃状态
    var isActive = false
    
    //轻量化的本地现在去重方案，本地已下载的视频id以逗号分隔
    var localVideosIdString: String?
    
    //视频上传到oss服务器上之后，用于插入appserverd数据库的字典 - 临时存储用于失败的再次尝试发布
    var publishParamDic: [String: Any]?
    
    //正在下载的视频参数
    var readyDataSource: AliyunDataSource?
    
    //正在下载的mediaInfo
    var downloadingMediaInfo: AliyunDownloadMediaInfo?
    
    lazy var reachability: YYReachability = {
        let r = YYReachability.init()
        return r
    }()
    lazy var naviBarView: PVHomeNaviBarView = {
        let v = PVHomeNaviBarView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: CGFloat(kNavigationBarAndStatusHeight)))
        v.delegate = self
        return v
    }()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AliyunVodDownLoadManager.share()?.downloadDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPlayContainer?.vodPlayer != nil {
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
        for v in playContainerList {
            if v.vodPlayer != nil {
                v.vodPlayer.release()
            }
        }
        videoList.removeAll()
        if downloadingMediaInfo != nil {
            AliyunVodDownLoadManager.share()?.stopDownloadMedia(downloadingMediaInfo!)
        }
    }
    


    //MARK: - UI
    func initUI() {
        view.addSubview(naviBarView)

       
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
            var conFrame = conView.frame
            conFrame.origin.y = CGFloat(i) * playViewHeight + 1
            conView.frame = newFrameWithHandleFrame(frame: conFrame)
            view.addSubview(conView)
            conView.bringSubviewToFront(conView.coverImageView)
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
    func firstHandleWhenHaveVideoListWithStartPlayIndex(startPlayIndex: inout Int) {
        //错误处理
        if startPlayIndex > videoList.count - 1 { startPlayIndex = videoList.count - 1 }
        //下拉刷新的时候停止播放之前播放中的视频
        if currentPlayContainer?.vodPlayer != nil { currentPlayContainer?.vodPlayer.stop() }
        
        let startIndex = startPlayIndex - kPreviousCount
        for i in 0..<playContainerList.count {
            //取数据源设置播放数据
            var videoModelIndex = i
            if startIndex > 0 { videoModelIndex = i + startIndex }
            //初始化预加载资源
            if videoModelIndex < videoList.count {
                let model = videoList[videoModelIndex]
                let conView = playContainerList[i]
                if conView.videoModel != nil {
                    //如果之前有viewModel，这次reset一下，初始化状态，包括已经准备好的视频要变为初始状态
                    conView.vodPlayer.reset()
                    conView.isHavePrepared = false
                }
                conView.setVideoModel(model: model)
                conView.coverImageView.isHidden = false
            }
            else { print("预加载的个数超过了视频资源本身的个数") }
        }
        //处理要播放的视频
        //1.寻找要播放的视频
        var realPalyIndex = 0
        if startPlayIndex < videoList.count { realPalyIndex = startPlayIndex }
        let model = videoList[realPalyIndex]
        var conView: PVHomePlayContainerView?
        var indexInPlayConViewList = 0
        for (k, v) in playContainerList.enumerated() {
            if v.videoModel == model {
                conView = v
                indexInPlayConViewList = k
                break
            }
        }
        
        //2.调整资源的位置
        for (k, v) in playContainerList.enumerated() {
            var f = v.frame
            if k < indexInPlayConViewList { f.origin.y = -1 * playViewHeight - 1 }
            else if k == indexInPlayConViewList { f.origin.y = 0 }
            else { f.origin.y = playViewHeight + 1 }
            v.frame = f
        }
        
        //3.处理要播放的视频
        if conView != nil {
            currentPlayContainer = conView
            //显示第一个视频的封面
            if model.firstFrameUrl != nil && model.coverImage == nil {
                currentPlayContainer?.coverImageView.kf.setImage(with: URL.init(string: model.firstFrameUrl!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (img, error, cacheType, url) in
                    if error == nil && img != nil {
                        self.currentPlayContainer?.setCoverImage(coverImage: img!)
                        self.currentPlayContainer?.coverImageView.isHidden = self.currentPlayContainer?.playerState == .play || self.currentPlayContainer?.playerState == .pause
                    }
                })
            }
            conView?.isHavePrepared = true
            prepareWithPlayer(player: conView!.vodPlayer, model: model)
        }
    }

    //第一次进入的图片预加载,保证只执行一次
    func doQuerryImageWhenFirstEnter() {
        if isHaveQuerryImageWhenFirstEnter == true || videoList.count == 0 { return }
        isHaveQuerryImageWhenFirstEnter = true
        for v in videoList {
            tryQuerryImageWithModel(videoModel: v)
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

    
    
    
}
