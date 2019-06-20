//
//  PVMePro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import WMPageController
import MJRefresh
import ObjectMapper
import SVProgressHUD

//MARK: - actions
extension PVMeViewController {
    
    //setting
    override func rightButtonsAction(sender: UIButton) {
        YPJOtherTool.ypj.loginValidate(currentVC: self) {[weak self] (isLogin) in
            if isLogin {
                let vc = PVMeSettingVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: contentScrollView) {[weak self] in
            self?.loadData()
        }
        if let header = contentScrollView.mj_header as? MJRefreshNormalHeader {
            header.arrowView.image = nil
        }
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .userInfo(userId: UserDefaults.standard.string(forKey: kUserId) ?? "", next: ""), success: { (resp) in
            if let d = Mapper<PVMeModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.headerView.data = d
                self.updateMenuItemAttributeText(index: Int(self.selectIndex))
            }
            
        }) { (e) in
            
        }
    }
    
    func updateMenuItemAttributeText(index: Int) {
        var color_0 = UIColor.white
        var color_1 = UIColor.white
        var color_2 = UIColor.white
        var color_00 = kColor_border!
        var color_11 = kColor_border!
        var color_22 = kColor_border!
        if index == 0 {
            color_0 = kColor_pink!
            color_00 = kColor_pink!
        }
        if index == 1 {
            color_1 = kColor_pink!
            color_11 = kColor_pink!
        }
        if index == 2 {
            color_2 = kColor_pink!
            color_22 = kColor_pink!
        }
        
        let att_1 = NSMutableAttributedString.init(string: "\(data.videoTotal)\n" + "作品")
        att_1.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_0], range: NSMakeRange(0, "\(data.videoTotal)".count))
        att_1.addAttributes([.font: kFont_text_2, .foregroundColor: color_00], range: NSMakeRange("\(data.videoTotal)".count, 3))
        updateAttributeTitle(att_1, at: 0)
        
        let att_2 = NSMutableAttributedString.init(string: "\(data.likeTotal)\n" + "喜欢")
        att_2.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_1], range: NSMakeRange(0, "\(data.likeTotal)".count))
        att_2.addAttributes([.font: kFont_text_2, .foregroundColor: color_11], range: NSMakeRange("\(data.likeTotal)".count, 3))
        updateAttributeTitle(att_2, at: 1)
        
        let att_3 = NSMutableAttributedString.init(string: "\(data.privacyCount)\n" + "私密")
        att_3.addAttributes([.font: kFont_btn_weight, .foregroundColor: color_2], range: NSMakeRange(0, "\(data.privacyCount)".count))
        att_3.addAttributes([.font: kFont_text_2, .foregroundColor: color_22], range: NSMakeRange("\(data.privacyCount)".count, 3))
        updateAttributeTitle(att_3, at: 2)
    }
    
    //noti
    @objc func refreshNotification() {
        if UserDefaults.standard.value(forKey: kToken) == nil {
            data = PVMeModel()
            self.headerView.data = data
            self.updateMenuItemAttributeText(index: Int(self.selectIndex))
            YPJOtherTool.ypj.loginValidate(currentVC: self) {[weak self] (isLogin) in
                self?.loadData()
            }
            print("me loginValidate")
            return
        }
        loadData()
    }
    
    //scroll view delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            guard contentScrollView.contentOffset.y > 0 else { return }
            productionVC.collectionView.isScrollEnabled = scrollView.contentOffset.y >= headerViewHeight - kNavigationBarAndStatusHeight - safeInset
            let alpha: CGFloat = scrollView.contentOffset.y >= headerViewHeight - kNavigationBarAndStatusHeight ? 1.0 : scrollView.contentOffset.y / (headerViewHeight - kNavigationBarAndStatusHeight)
            effectView.alpha = alpha
            naviBar.titleView.alpha = alpha
            contentScrollView.bounces = contentScrollView.contentOffset.y <= 20
        }
        else {
            super.scrollViewDidScroll(scrollView)
        }
       
    }
    
}

//MARK: - PVMeHeaderViewDelegate
extension PVMeViewController: PVMeHeaderViewDelegate {
    //编辑or登录
    func didSelectedEdit(sender: UIButton) {
        if YPJOtherTool.ypj.loginValidate(currentVC: self, isLogin: nil) {
            let vc = PVMeUserinfoEditVC()
            vc.data = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //会员等级
    func didSelectedLevel() {
        let vc = PVHomeUserLevelVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    //活跃度
    func didSelectedActiveness() {
        let vc = PVHomeActivenessVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    //平安果
    func didSelectedFruit() {
        let vc = PVHomeFruitVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    //长按背景
    func didLongPressBackground() {
        if presentedViewController != nil { return }
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction.init(title: "拍照", style: .default) { (ac) in
            YPJOtherTool.ypj.getCameraAuth(target: self, {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .camera
                picker.cameraCaptureMode = .photo
                picker.cameraDevice = .front
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            })
        }
        let photo = UIAlertAction.init(title: "从相册选取", style: .default) { (ac) in
            YPJOtherTool.ypj.getPhotosAuth(target: self) {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(photo)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //关注
    func didSelectedAttention() {
        let vc = PVMeAttentionVC()
        vc.userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //粉丝
    func didSelectedFans() {
        let vc = PVMeFansVC()
        vc.userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Image Picker Controller Delegate
extension PVMeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.editedImage] as? UIImage {
            
            guard let imgData = resultImage.ypj.compressImage(maxLength: 512 * 1024) else { return }
            guard let img = UIImage.init(data: imgData) else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            headerView.backgroundImageIV.image = img
            guard let imgPath = img.ypj.saveImageToLocalFolder(directory: .cachesDirectory, compressionQuality: 1.0) else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            picker.dismiss(animated: true) {
                PVNetworkTool.Request(router: .getAuthWithUploadImage(imageExt: "jpg"), success: { (resp) in
                    
                    if let d = Mapper<PVUploadImageModel>().map(JSONObject: resp["result"].object) {
                        PVNetworkTool.uploadFileWithAliyun(description: "", auth: d.uploadAuth, address: d.uploadAddress, filePath: imgPath, handle: { (isSuccess) in
                            if isSuccess == false {
                                SVProgressHUD.showError(withStatus: "上传图片失败")
                                return
                            }
                            PVNetworkTool.Request(router: .editBackgroundImage(imagePath: d.imageUrl), success: { (resp) in
                                self.loadData()
                                
                            }, failure: { (e) in
                                
                            })
                            
                        })
                    }
                    
                }) { (e) in
                    
                }
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}

//MARK: - 作品, 喜欢, 私密
extension PVMeViewController: PVMeProductionDelegate, PVMeLikeDelegate, PVMeSecureDelegate {
    
    func scrollViewWillDragging(sender: UIScrollView) {
        if contentScrollView.contentOffset.y <= 0 { sender.isScrollEnabled = false }
    }
    
    func didBeginHeaderRefresh(sender: UIScrollView?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender?.mj_header.endRefreshing()
            self.effectView.alpha = 0
            self.naviBar.titleView.alpha = 0
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: true)
        }
    }
    
}


//MARK: - page controller delegate
extension PVMeViewController {
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return 3
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["作品", "喜欢", "私密"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {//作品
            productionVC.userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
            return productionVC
        }
        if index == 1 {//喜欢
            likeVC.userId = UserDefaults.standard.string(forKey: kUserId) ?? ""
            return likeVC
        }
        if index == 2 {//私密
            return secureVC
        }
        
        return UIViewController()
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect.init(x: 0, y: headerViewHeight, width: kScreenWidth, height: 50 * KScreenRatio_6)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        let h = kScreenHeight - kTabBarHeight - 50 * KScreenRatio_6 - kNavigationBarAndStatusHeight - safeInset
        return CGRect.init(x: 0, y: headerViewHeight + 50 * KScreenRatio_6, width: kScreenWidth, height: h)
    }

    override func pageController(_ pageController: WMPageController, didEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        guard let index = info["index"] as? Int else { return }
        
        updateMenuItemAttributeText(index: index)

    }
}
