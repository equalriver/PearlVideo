//
//  PVHomePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

import AliyunVodPlayerSDK

//MARK: - action
extension PVHomePlayVC {
    
    
    
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
            self.currentPlayContainer!.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: playViewHeight)
            if let preView = self.previousViewToView(containerView: self.currentPlayContainer!) {
                preView.frame = CGRect.init(x: 0, y: -1 * playViewHeight - 1, width: kScreenWidth, height: playViewHeight)
            }
            if let nextView = self.nextViewToView(containerView: self.currentPlayContainer!) {
                nextView.frame = CGRect.init(x: 0, y: playViewHeight + 1, width: kScreenWidth, height: playViewHeight)
            }
        }
    }
  
    //view向上移动一屏
    func animtaionUpView(containerView: PVHomePlayContainerView, completion: ((Bool) -> Void)?) {
        var f = containerView.frame
        f.origin.y = -1 * playViewHeight - 1
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
        f.origin.y = playViewHeight + 1
        UIView.animate(withDuration: kAnimationTime, animations: {
            containerView.frame = f
            
        }, completion: completion)
    }
    
}

//MARK: - data manager
extension PVHomePlayVC {
    //初始化数据
    func configBaseData() {
        isHaveQuerryImageWhenFirstEnter = false
        isHaveQuerryAllVideo = false
        isActive = true
        querryOriginalVideolistSuccess {
            var index = 0
            self.firstHandleWhenHaveVideoListWithStartPlayIndex(startPlayIndex: &index)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
                self.doQuerryImageWhenFirstEnter()
            })
        }
    }
    
    //请求基本的数据 - accessKeyId - accessKeySecret - securityToken - 第一次的播放数据
    func querryOriginalVideolistSuccess(success: (() -> Void)?) {
        
        //FIX ME: load data
        self.videoList.removeAll()
        //赋值
        for v in self.videoList {
            self.tryQuerryImageWithModel(videoModel: v)
        }
        success?()
    }
    
    //请求播放的视频列表 videoId 开始的视频的id，不包含此视频
    func querryVideoDataWithStartVideoId(videoId: String, count: Int) {
        guard accessKeyId != nil && accessKeySecret != nil && securityToken != nil else {
            configBaseData()
            return
        }
        //FIX ME: load data
        let dataArr = [AlivcQuVideoModel]() //请求的数据
        if self.isHaveQuerryAllVideo == true { return }
        if dataArr.count < count { self.isHaveQuerryAllVideo = true }
        if let lastModel = self.videoList.last {
            //这个分支，说明数据已经加载进来了，因为传入的最后一个视频和视频列表里的最后一个视频不相等
            //有时候滑动过快，同一页会请求2-3次的情况，防止数据重复加进来
            if lastModel.id != videoId { return }
        }
        if dataArr.count == 0 {
            self.isHaveQuerryAllVideo = true
            return
        }
        for v in dataArr {
            self.tryQuerryImageWithModel(videoModel: v)
        }
        self.videoList += dataArr
        //用户滑动过快的时候等待请求下来再去管理预加载资源
        managePreloadingSourceWhenPlayNext()
    }

    //清空之前的数据，重新加载
    func reloadData() {
        configBaseData()
    }
    
    
}

//MARK: - play manager
extension PVHomePlayVC {
    //播放上一个视频
    func playPrevious() {
        guard currentPlayContainer != nil else { return }
        let previousView = previousViewToView(containerView: currentPlayContainer!)
        if previousView != nil && previousView!.videoModel != nil {
            animationDownView(containerView: currentPlayContainer!, completion: nil)
            stopPlayCurrent(currentPlayContainView: currentPlayContainer!, changeToPlay: previousView!)
            currentPlayContainer = previousView
            
        }
    }
    

    
//    [self stopPlayCurrent:self.currentPlayContainer changeToPlay:previousView];
//    self.currentPlayContainer = previousView;
//
//    [self managePreloadingSourceWhenPlayPrevious];
//
//    }else{
//    [self cancelPan];
//    if (self.videoList.count > 0) {
//    NSInteger currentModelIndex = [self.videoList indexOfObject:self.currentPlayContainer.videoModel];
//    if (currentModelIndex == 0 && !_isOnlyPlayStableVideo) {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (window) {
//    self.refreshHud = [MBProgressHUD showMessage:@"刷新中..." alwaysInView:window];
//    }else{
//    self.refreshHud = [MBProgressHUD showMessage:@"刷新中..." alwaysInView:self.view];
//    }
//
//    [self reloadData];
//    }else if(currentModelIndex == 0 &&_isOnlyPlayStableVideo){
//    [MBProgressHUD showMessage:@"无更多视频" inView:self.view];
//    }else{
//    NSAssert(false, @"往下滑动逻辑处理有漏洞");
//    }
//    }else{
//    //视频列表为空，可能之前无网络，这里添加下拉刷新的逻辑
//    if (!_isOnlyPlayStableVideo) {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (window) {
//    self.refreshHud = [MBProgressHUD showMessage:@"刷新中..." alwaysInView:window];
//    }else{
//    self.refreshHud = [MBProgressHUD showMessage:@"刷新中..." alwaysInView:self.view];
//    }
//    [self reloadData];
//    }
  
    
    //准备播放视频
    func prepareWithPlayer(player: AliyunVodPlayer, model: AlivcQuVideoModel) {
        player.stop()   //SDK开发人员的建议：准备之前先stop，防止prepare多次引发一些问题
        player.prepare(withVid: model.videoId, accessKeyId: accessKeyId, accessKeySecret: accessKeySecret, securityToken: securityToken)
        if accessKeyId == nil || accessKeySecret == nil || securityToken == nil { print("sts异常") }
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
            if lastView == nil || lastView?.videoModel == nil { return }
            guard let lastModelIndex = videoList.firstIndex(of: lastView!.videoModel!) else { return }
            let targetModelIndex = lastModelIndex + 1
            
            if targetModelIndex < videoList.count {
                //要变化的conView
                guard let firstView = playContainerList.first else { return }
                //下一个播放的资源
                let model = videoList[targetModelIndex]
                //准备工作
                clearWhenContainView(conView: firstView, newModel: model)
                //调整在列表中位置
                playContainerList = playContainerList.filter { (obj) -> Bool in
                    return obj != firstView
                }
                playContainerList.append(firstView)
                
                //调整在视图中的位置
                var f = firstView.frame
                f.origin.y = playViewHeight + 1
                firstView.frame = f
            }
            else {
                if isHaveQuerryAllVideo == false {
                    //用户滑动过快，此时滑到了最后一个，但是之前请求的下一个页面的播放数据还没有请求下来，这里也不做处理，等待请求下来，然后会再次调用本方法，调整资源位置
                    
                }
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
            //如果kPreviousCount为1，则firtView为currentPlayContainer
            guard let firtView = playContainerList.first else { return }
            if firtView.videoModel == nil { return }
            guard let firstModelIndex = videoList.firstIndex(where: { (obj) -> Bool in
                return obj == firtView.videoModel!
            }) else { return }
            let targetModelIndex = firstModelIndex - 1
            if targetModelIndex >= 0 {
                //要变化的containView
                guard let lastView = playContainerList.last else { return }
                //新的播放资源
                let targetModel = videoList[targetModelIndex]
                //准备
                clearWhenContainView(conView: lastView, newModel: targetModel)
                //调整在列表中的位置
                playContainerList = playContainerList.filter { (obj) -> Bool in
                    return obj != lastView
                }
                playContainerList.insert(lastView, at: 0)
                
                //调整在视图中的位置
                var f = lastView.frame
                f.origin.y = -1 * playViewHeight - 1
                lastView.frame = f
            }
        }
    }

    
    //准备播放下一个视频的清除数据工作
    func clearWhenContainView(conView: PVHomePlayContainerView, newModel: AlivcQuVideoModel) {
        //清空图片
        conView.clearImage()
        //通过reset来清空上个视频播放的最后一帧图像 - 这是不合理的，但是是sdk的设计与我本身的处理策略导致，目前先这样处理
        conView.vodPlayer.reset()
        //显示封面图
        conView.coverImageView.isHidden = false
        //设置新的播放资源
        conView.setVideoModel(model: newModel)
        //准备播放新的播放资源
        if conView.videoModel != nil {
            prepareWithPlayer(player: conView.vodPlayer, model: conView.videoModel!)
        }
        conView.isHavePrepared = true
    }

    //停止播放当前的视频，播放下一个视频
    func stopPlayCurrent(currentPlayContainView: PVHomePlayContainerView, changeToPlay nextPlayContainerView: PVHomePlayContainerView) {
        currentPlayContainView.isHavePrepared = false
        currentPlayContainView.vodPlayer.stop()
        currentPlayContainView.setPreCoverImageWhenStop()
        if nextPlayContainerView.isHavePrepared == false {
            guard nextPlayContainerView.videoModel != nil else { return }
            prepareWithPlayer(player: nextPlayContainerView.vodPlayer, model: nextPlayContainerView.videoModel!)
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
    
}

//MARK: - public method
extension PVHomePlayVC {
    //尝试加载图片
    func tryQuerryImageWithModel(videoModel: AlivcQuVideoModel) {
        if videoModel.firstFrameUrl != nil && videoModel.firstFrameImage == nil {
            UIImageView().kf.setImage(with: URL.init(string: videoModel.firstFrameUrl!), placeholder: nil, options: nil, progressBlock: nil) { (img, error, cacheType, url) in
                if img != nil { videoModel.firstFrameImage = img }
            }
        }
    }
    
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
        currentPlayContainer?.vodPlayer.pause()
    }
    
    @objc func becomeActive() {
        isActive = true
        if currentPlayContainer?.playerState == AliyunVodPlayerState.prepared {
            currentPlayContainer?.vodPlayer.start() //应对下拉刷新过程中退后台的处理
        }
        else if savedPlayStatus == AliyunVodPlayerState.play {
            currentPlayContainer?.vodPlayer.resume()
        }
        //FIX ME: 尝试重新上传发布
        
    }
    
    
    
}
