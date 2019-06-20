//
//  PVHomePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//
import ObjectMapper
import AliyunVodPlayerSDK

//MARK: - action
extension PVHomePlayVC {
    
    func firstLoadData() {
        PVNetworkTool.Request(router: .videoList(type: self.type, videoIndex: self.videoIndex, videoId: self.videoId, userId: userId), success: { (resp) in
            if let nextPos = resp["result"]["nextPos"].int { self.videoIndex = nextPos }
            
            if let d = Mapper<PVVideoPlayModel>().mapArray(JSONObject: resp["result"]["videoList"].arrayObject) {
                if self.page == 0 { self.dataArr = d }
                else { self.dataArr += d }
                self.firstHandleWhenHavedataArrWithStartPlayIndex(startPlayIndex: &self.playStableVideoStartIndex)
                //用户滑动过快的时候等待请求下来再去管理预加载资源
                self.managePreloadingSourceWhenPlayNext()
                
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
        }
    }
    
    func loadPlayTime() {
        PVNetworkTool.Request(router: .getVideoPlayTime, success: { (resp) in
            guard let isOpen = resp["result"]["isTimeEffective"].bool else { return }
            if isOpen == false {
                self.playTimeProgressView.isHidden = true
                return
            }
            if let m = resp["result"]["minutes"].int {
                self.playTimeMinutes = m
                self.timer.setEventHandler(handler: { [weak self] in
                    guard self != nil && self!.playTimeMinutes != nil else { return }
                    if self!.playTimeMinutes! > kVideoPlayTime { self?.timer.cancel()
                        return
                    }
                    DispatchQueue.main.async {
                        self!.playTimeMinutes! += 1
                        self?.playTimeProgressView.text = "\(self!.playTimeMinutes!)"
                        self?.playTimeProgress.strokeEnd = CGFloat(self!.playTimeMinutes!) / CGFloat(kVideoPlayTime)
                        PVNetworkTool.Request(router: .setVideoPlayTime(minutes: self!.playTimeMinutes!), success: { (resp) in

                        }, failure: { (e) in

                        })
                    }
                })
            }
            
        }) { (e) in
            
        }
    }
    /*
    //获取点播STS
    func getSTS() {
        PVNetworkTool.Request(router: .getVideoSTS, success: { (resp) in
            if let accessKeyId = resp["result"]["accessKeyId"].string {
                self.accessKeyId = accessKeyId
            }
            if let accessKeySecret = resp["result"]["accessKeySecret"].string {
                self.accessKeySecret = accessKeySecret
            }
            if let securityToken = resp["result"]["securityToken"].string {
                self.securityToken = securityToken
            }
            firstLoadData()
            
        }) { (e) in
            
        }

    }
    */
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .videoList(type: type, videoIndex: videoIndex, videoId: videoId, userId: userId), success: { (resp) in
            if let nextPos = resp["result"]["nextPos"].int { self.videoIndex = nextPos }
            
            if let d = Mapper<PVVideoPlayModel>().mapArray(JSONObject: resp["result"]["dataArr"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else { self.dataArr += d }
                
            }
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
        }
    }
    
    @objc func backAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
 
}

//MARK: - UI config when UP Down
extension PVHomePlayVC {
    //根据vodPlayer找到存放它的对应的容器视图
    func containerViewWithVodPlayer(vodPlayer: AliyunVodPlayer) -> PVHomePlayContainerView? {
        //找到对应的conView
        for v in playContainerList {
            if v.vodPlayer == vodPlayer { return v }
        }
        return nil
    }
    
    //返回containerView的下一个视图
    func nextViewToView(containerView: PVHomePlayContainerView) -> PVHomePlayContainerView? {
        for v in playContainerList {
            if v == containerView {
                guard let index = playContainerList.firstIndex(of: v) else { break }
                let nextIndex = index + 1
                if nextIndex < playContainerList.count { return playContainerList[nextIndex] }
            }
        }
        return nil
    }
  
    //返回containerView的上一个视图
    func previousViewToView(containerView: PVHomePlayContainerView) -> PVHomePlayContainerView? {
        for v in playContainerList {
            if v == containerView {
                guard let index = playContainerList.firstIndex(of: v) else { break }
                let pIndex = index - 1
                if pIndex >= 0 { return playContainerList[pIndex] }
            }
        }
        return nil
    }
     
    //隐藏封面图
    func hideCoverImageWithVodPlayer(vodPlayer: AliyunVodPlayer) {
        if let updateConView = containerViewWithVodPlayer(vodPlayer: vodPlayer) {
            updateConView.coverImageView.isHidden = true
        }
    }
 
    //取消滑动,各view归位
    func cancelPan() {
        guard currentPlayContainer != nil else { return }

        UIView.animate(withDuration: kAnimationTime) {
            self.currentPlayContainer!.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            if let preView = self.previousViewToView(containerView: self.currentPlayContainer!) {
                preView.frame = CGRect.init(x: 0, y: -1 * kScreenHeight - 1, width: kScreenWidth, height: kScreenHeight)
            }
            if let nextView = self.nextViewToView(containerView: self.currentPlayContainer!) {
                nextView.frame = CGRect.init(x: 0, y: kScreenHeight + 1, width: kScreenWidth, height: kScreenHeight)
            }
        }
    }
  
    //view向上移动一屏
    func animtaionUpView(containerView: PVHomePlayContainerView, completion: ((Bool) -> Void)?) {
        var f = containerView.frame
        f.origin.y = -1 * kScreenHeight - 1
        UIView.animate(withDuration: kAnimationTime, animations: {
            containerView.frame = f
            
        }, completion: completion)
    }
   
    //view在当前的屏幕
    func animtaionCurrentView(containerView: PVHomePlayContainerView, completion: ((Bool) -> Void)?) {
        var f = containerView.frame
        f.origin.y = 0
        UIView.animate(withDuration: kAnimationTime, animations: {
            containerView.frame = f
            
        }, completion: completion)
    }
   
    //view向下移动一屏
    func animationDownView(containerView: PVHomePlayContainerView, completion: ((Bool) -> Void)?) {
        var f = containerView.frame
        f.origin.y = kScreenHeight + 1
        UIView.animate(withDuration: kAnimationTime, animations: {
            containerView.frame = f
            
        }, completion: completion)
    }
    
}

//MARK: - play manager
extension PVHomePlayVC {
    //播放上一个视频
    func playPrevious() {
        guard currentPlayContainer != nil else { return }
        let previousView = previousViewToView(containerView: currentPlayContainer!)
        if previousView != nil && previousView!.data != nil {
            animationDownView(containerView: currentPlayContainer!, completion: nil)
            stopPlayCurrent(currentPlayContainView: currentPlayContainer!, changeToPlay: previousView!)
            currentPlayContainer = previousView
            managePreloadingSourceWhenPlayPrevious()
        }
        else {
            cancelPan()
            if dataArr.count > 0 {
                let currentModelIndex = currentPlayContainer!.data.index(ofAccessibilityElement: dataArr)
                if currentModelIndex == 0 {
                    loadData(page: 0)
                }
            }
            else {
                loadData(page: 0)
            }
        }
    }
 
    //播放下一个视频
    func playNext() {
        if currentPlayContainer == nil { return }
        let nextPlayerView = nextViewToView(containerView: currentPlayContainer!)
        if nextPlayerView != nil && nextPlayerView?.data != nil {
            animtaionUpView(containerView: currentPlayContainer!, completion: nil)
            stopPlayCurrent(currentPlayContainView: currentPlayContainer!, changeToPlay: nextPlayerView!)
            currentPlayContainer = nextPlayerView
            managePreloadingSourceWhenPlayNext()
            tryQuerryNewPlayVideo()
        }
        else {
            cancelPan()
            guard let modelIndex = dataArr.firstIndex(of: currentPlayContainer!.data) else { return }
            if modelIndex == dataArr.count - 1 || isOnlyPlayStableVideo {
                view.makeToast("已经是最后一个视频了")
            }
            else {
                managePreloadingSourceWhenPlayNext()
                tryQuerryNewPlayVideo()
            }
            
        }
        
    }
    
    //停止播放当前的视频，播放下一个视频
    func stopPlayCurrent(currentPlayContainView: PVHomePlayContainerView, changeToPlay nextPlayContainerView: PVHomePlayContainerView) {
        currentPlayContainView.isHavePrepared = false
        currentPlayContainView.vodPlayer.stop()
        currentPlayContainView.setPreCoverImageWhenStop()
        if nextPlayContainerView.isHavePrepared == false {
            guard nextPlayContainerView.data != nil else { return }
            prepareWithPlayer(player: nextPlayContainerView.vodPlayer, model: nextPlayContainerView.data)
            nextPlayContainerView.isHavePrepared = true
        }
        else {
            switch nextPlayContainerView.playerState {
            case .prepared: //已准备好
                nextPlayContainerView.vodPlayer.start()
                break
                
            default: break
                
            }
        }
        animtaionCurrentView(containerView: nextPlayContainerView, completion: nil)
        
    }
    
    
    
    //准备播放视频
    func prepareWithPlayer(player: AliyunVodPlayer, model: PVVideoPlayModel) {
        player.stop()   //SDK开发人员的建议：准备之前先stop，防止prepare多次引发一些问题
        player.prepare(with: URL.init(string: model.videoURL))
//        player.prepare(withVid: model.videoId, accessKeyId: accessKeyId, accessKeySecret: accessKeySecret, securityToken: securityToken)
//        if accessKeyId == nil || accessKeySecret == nil || securityToken == nil { print("sts异常") }
    }
    
    //根据情况判断是否要去请求新的资源
    func tryQuerryNewPlayVideo() {
        if currentPlayContainer == nil { return }
        guard let currentIndexInSouce = dataArr.firstIndex(of: currentPlayContainer!.data) else { return }
        //剩余个数
        let lessCount = dataArr.count - currentIndexInSouce - 1
        //加载更多
        if lessCount < kCountLess_mustQurryMoreData {
            page += 1
            loadData(page: page)
        }
    }
    
    //准备播放下一个视频的清除数据工作
    func clearWhenContainView(conView: PVHomePlayContainerView, newModel: PVVideoPlayModel) {
        //清空图片
        conView.clearImage()
        //通过reset来清空上个视频播放的最后一帧图像 - 这是不合理的，但是是sdk的设计与我本身的处理策略导致，目前先这样处理
        conView.vodPlayer.reset()
        //显示封面图
        conView.coverImageView.isHidden = false
        //设置新的播放资源
        conView.data = newModel
        //准备播放新的播放资源
        if conView.data != nil {
            prepareWithPlayer(player: conView.vodPlayer, model: conView.data)
        }
        conView.isHavePrepared = true
    }
    
    //向上滑动的时候管理预加载资源
    func managePreloadingSourceWhenPlayNext() {
        //1.出现上划的情况
        //实际的在当前播放视图上面的资源数
        var upCount = 100000
        
        //当前播放视图在预加载资源列表中的位置
        guard currentPlayContainer != nil else { return }
        guard let currentIndex = playContainerList.firstIndex(of: currentPlayContainer!) else { return }
        upCount = currentIndex
        if upCount > kPreviousCount {
            //如果kNextCount为1，则lastView为currentPlayContainer，理解不了也没事
            let lastView = playContainerList.last
            if lastView == nil || lastView?.data == nil { return }
            guard let lastModelIndex = dataArr.firstIndex(of: lastView!.data) else { return }
            let targetModelIndex = lastModelIndex + 1
            
            if targetModelIndex < dataArr.count {
                //要变化的conView
                guard let firstView = playContainerList.first else { return }
                //下一个播放的资源
                let model = dataArr[targetModelIndex]
                //准备工作
                clearWhenContainView(conView: firstView, newModel: model)
                //调整在列表中位置
                playContainerList = playContainerList.filter { (obj) -> Bool in
                    return obj != firstView
                }
                playContainerList.append(firstView)
                
                //调整在视图中的位置
                var f = firstView.frame
                f.origin.y = kScreenHeight + 1
                firstView.frame = f
            }
           
        }
    }
    
    
    //向下滑动的时候管理预加载资源
    func managePreloadingSourceWhenPlayPrevious() {
        //实际的在当前播放视图下面的资源数
        var downCount = 100000
        //当前播放视图在预加载资源列表中的位置
        guard currentPlayContainer != nil else { return }
        guard let currentIndex = playContainerList.firstIndex(of: currentPlayContainer!) else { return }
        downCount = playContainerList.count - 1 - currentIndex
        if downCount > kNextCount {
            //如果kPreviousCount为1，则firstView为currentPlayContainer
            guard let firstView = playContainerList.first else { return }
            if firstView.data == nil { return }
            guard let firstModelIndex = dataArr.firstIndex(of: firstView.data) else { return }
            let targetModelIndex = firstModelIndex - 1
            if targetModelIndex >= 0 {
                //要变化的containView
                guard let lastView = playContainerList.last else { return }
                //新的播放资源
                let targetModel = dataArr[targetModelIndex]
                //准备
                clearWhenContainView(conView: lastView, newModel: targetModel)
                //调整在列表中的位置
                playContainerList = playContainerList.filter { (obj) -> Bool in
                    return obj != lastView
                }
                playContainerList.insert(lastView, at: 0)
                
                //调整在视图中的位置
                var f = lastView.frame
                f.origin.y = -1 * kScreenHeight - 1
                lastView.frame = f
            }
        }
    }
    
    
    

    
}

//MARK: - gesture
extension PVHomePlayVC {
    //边界值处理，上+ 中 + 下，最多在这3个屏幕之中 边界值+2，保证view不会超出此范围
    func newFrameWithHandleFrame(frame: CGRect) -> CGRect {
        var f = frame
        if f.origin.y < f.height * -1 - 2 { f.origin.y = f.height * -1 - 2 }
        if f.origin.y > f.height + 2 { f.origin.y = f.height + 2 }
        return f
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        guard let player = currentPlayContainer?.vodPlayer else { return }
        switch player.playerState() {
        case .play:
            player.pause()
            break
            
        case .stop:
            player.replay()
            break
            
        case .pause:
            player.resume()
            break
            
        default:
            prepareWithPlayer(player: player, model: currentPlayContainer!.data)
            break
        }
    }
    
    @objc func panAction(sender: UIPanGestureRecognizer) {
        let s = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        switch sender.state {
        case .changed:
            changedToCommitTranslation(translation: translation)
            break
            
        case .ended:
            if abs(s.y) < kMinPanSpeed && abs(translation.y) < kScreenHeight / 2 {
                cancelPan()
            }
            else {
                endToCommitTranslation(translation: translation)
            }
            break
            
        case .cancelled:
            cancelPan()
            break
            
        default:
            break
        }
    }
    
    //手势改变中的处理，主要是view的位置变化  当前播放的视图变化
    func changedToCommitTranslation(translation: CGPoint) {
        guard currentPlayContainer != nil else { return }
        var currentFrame = currentPlayContainer!.frame
        currentFrame.origin.y = translation.y
        currentPlayContainer!.frame = newFrameWithHandleFrame(frame: currentFrame)
        
        guard let previousView = previousViewToView(containerView: currentPlayContainer!) else { return }
        var previousFrame = previousView.frame
        previousFrame.origin.y = kScreenHeight * -1 + translation.y
        previousView.frame = newFrameWithHandleFrame(frame: previousFrame)
        
        guard let nextView = nextViewToView(containerView: currentPlayContainer!) else { return }
        var nextFrame = nextView.frame
        nextFrame.origin.y = kScreenHeight + translation.y
        nextView.frame = newFrameWithHandleFrame(frame: nextFrame)
    }
    
    //手势结束的时候处理,判断滑动方向，播放上一个视频或者下一个视频
    func endToCommitTranslation(translation: CGPoint) {
        let absX = abs(translation.x)
        let absY = abs(translation.y)
        // 设置滑动有效距离
        if max(absX, absY) < 10 {
            cancelPan()
            return
        }
        if absX > absY {
            cancelPan()
        }
        else {
            if translation.y < 0 {//向上滑动
                playNext()
            }
            else {//向下滑动
                playPrevious()
            }
        }
    }
 
}

//MARK: - public method
extension PVHomePlayVC {
    
    func checkLocalHaveTheMedia(mediaInfo: AliyunDownloadMediaInfo) -> Bool {
        if localVideosIdString != nil {
            let strArray = localVideosIdString!.components(separatedBy: ",")
            for v in strArray {
                if v == mediaInfo.vid { return true }
            }
        }
        return false
    }
    
}

//MARK: - notification
extension PVHomePlayVC {
    
    @objc func resignActive() {
        isActive = false
        currentPlayContainer?.vodPlayer?.pause()
    }
    
    @objc func becomeActive() {
        isActive = true
        if currentPlayContainer?.playerState == AliyunVodPlayerState.prepared {
            currentPlayContainer?.vodPlayer?.start() //应对下拉刷新过程中退后台的处理
        }
        else if savedPlayStatus == AliyunVodPlayerState.play {
            currentPlayContainer?.vodPlayer?.resume()
        }
        
    }
    
    
    
}
