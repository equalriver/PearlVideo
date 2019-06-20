//
//  PVExchangeRecordDetailPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

import ObjectMapper
import SVProgressHUD

//MARK: - 买单详情
extension PVExchangeRecordBuyDetailVC {
    
    func loadData() {
        PVNetworkTool.Request(router: .recordDetail(orderId: orderId), success: { (resp) in
            if let d = Mapper<PVExchangeRecordDetailModel>().map(JSONObject: resp["result"].object) {
                self.headView.data = d
            }
            
        }) { (e) in
            
        }
    }
    
    @objc func cancelOrder(sender: UIButton) {
        YPJOtherTool.ypj.showAlert(title: "取消订单", message: "是否取消订单？", style: .alert, isNeedCancel: true) { (ac) in
            PVNetworkTool.Request(router: .cancelOrder(orderId: self.orderId), success: { (resp) in
                self.view.makeToast("已取消")
                NotificationCenter.default.post(name: .kNotiName_refreshRecordBuyDetail, object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                
            }) { (e) in
                
            }
        }
    }
    
    @objc func refreshNoti(sender: Notification) {
        loadData()
    }
}


//MARK: - 卖单详情
extension PVExchangeRecordSellDetailVC {
    
    func loadData() {
        PVNetworkTool.Request(router: .recordDetail(orderId: orderId), success: { (resp) in
            if let d = Mapper<PVExchangeRecordDetailModel>().map(JSONObject: resp["result"].object) {
                self.headView.data = d
            }
            
        }) { (e) in
            
        }
    }
    
    @objc func cancelOrder(sender: UIButton) {
        YPJOtherTool.ypj.showAlert(title: "取消订单", message: "是否取消订单？", style: .alert, isNeedCancel: true) { (ac) in
            PVNetworkTool.Request(router: .cancelOrder(orderId: self.orderId), success: { (resp) in
                self.view.makeToast("已取消")
                NotificationCenter.default.post(name: .kNotiName_refreshRecordSellDetail, object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                
            }) { (e) in
                
            }
        }
        
    }
    
    @objc func refreshNoti(sender: Notification) {
        loadData()
    }
}


//MARK: - 交换中详情
extension PVExchangeRecordChangingDetailVC {
    
    func loadData() {
        PVNetworkTool.Request(router: .recordDetail(orderId: orderId), success: { (resp) in
            if let d = Mapper<PVExchangeRecordDetailModel>().map(JSONObject: resp["result"].object) {
                self.headerView.data = d
            }
            
        }) { (e) in
            
        }
    }
    
    @objc func refreshNoti(sender: Notification) {
        loadData()
    }
    
}


extension PVExchangeRecordChangingDetailVC: ChangingFootDelegate {
    //拨打电话
    func didSelectedPhone(phone: String) {
        if UIApplication.shared.canOpenURL(URL.init(string: "telprompt:\(phone)")!){
            UIApplication.shared.openURL(URL.init(string: "telprompt:\(phone)")!)
        }
    }
    
    //copy
    func didSelectedCopy(content: String) {
        let p = UIPasteboard.general
        p.string = content
        view.makeToast("已复制")
    }
    
}

//屏幕截图
extension PVExchangeRecordChangingDetailVC: ChangingScreenshotDelegate {
    //上传图片
    func didSelectedUpload(success: @escaping () -> Void) {
        uploadImageSuccess = success
        YPJOtherTool.ypj.getPhotosAuth(target: self) {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func didTapScreenshot(image: UIImage?) {
        if type == .waitForPay {//待支付重新上传
            YPJOtherTool.ypj.getPhotosAuth(target: self) {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        }
        else {//查看图片
            guard image != nil else { return }
            guard uploadImageURL != nil else { return }
            let imgManager = LZImageBrowserManager.init(urlStr: [uploadImageURL!.absoluteString], originImageViews: [screenshotView.imageIV], originController: self, forceTouch: false, forceTouchActionTitles: nil, forceTouchActionComplete: nil)
            imgManager.selectPage = 0
            imgManager.showImageBrowser()
        }
    }
    
}

extension PVExchangeRecordChangingDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.editedImage] as? UIImage {
            
            guard let imgData = resultImage.ypj.compressImage(maxLength: 1024 * 1024) else { return }
            guard let img = UIImage.init(data: imgData) else { return }
            screenshotView.imageIV.image = img
            if let url = info[.mediaURL] as? URL { uploadImageURL = url }
            
            uploadImageSuccess?()
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: -- bottom buttons action
extension PVExchangeRecordChangingDetailVC: ChangingBottomButtonsDelegate {
    
    func didSelectedCancel() {
        //申诉
        if type == .waitForFruit {//待放平安果的申诉
            YPJOtherTool.ypj.showAlert(title: "确认申诉", message: "确认申诉将冻结双方账号确认申诉？ 可前往设置意见反馈解冻账号", style: .alert, isNeedCancel: true) { (ac) in
                PVNetworkTool.Request(router: .appealOrder(orderId: self.orderId), success: { (resp) in
                    NotificationCenter.default.post(name: .kNotiName_refreshRecordExchanging, object: nil)
                    self.view.makeToast("提交成功")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }, failure: { (e) in
                    
                })
            }
            return
        }
       
    }
    
    func didSelectedPay() {
        if type == .waitForFruit {//待放平安果
            YPJOtherTool.ypj.showAlert(title: "确认发送平安果", message: "请先确认是否已收到买家款项， 发送平安果不可撤回", style: .alert, isNeedCancel: true) { (ac) in
                PVNetworkTool.Request(router: .confirmFruit(orderId: self.orderId), success: { (resp) in
                    NotificationCenter.default.post(name: .kNotiName_refreshRecordExchanging, object: nil)
                    self.view.makeToast("提交成功")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }, failure: { (e) in
                    
                })
            }
            return
        }
        
        if type == .waitForPay {//待支付
            if screenshotView.imageIV.image == nil {
                view.makeToast("未上传支付截图")
                return
            }
            //FIX: upload
            guard let url = uploadImageURL else { return }
            PVNetworkTool.Request(router: .getAuthWithUploadImage(imageExt: "jpg"), success: { (resp) in
                
                if let d = Mapper<PVUploadImageModel>().map(JSONObject: resp["result"].object) {
                    PVNetworkTool.uploadFileWithAliyun(description: "", auth: d.uploadAuth, address: d.uploadAddress, filePath: url.absoluteString, handle: { (isSuccess) in
                        if isSuccess == false {
                            SVProgressHUD.showError(withStatus: "上传图片失败")
                            return
                        }
                        PVNetworkTool.Request(router: .payOrder(orderId: self.orderId, screenshot: d.imageUrl), success: { (resp) in
                            NotificationCenter.default.post(name: .kNotiName_refreshRecordExchanging, object: nil)
                            self.view.makeToast("提交成功")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                            
                        }, failure: { (e) in
                            
                        })
                        
                    })
                }
                
            }) { (e) in
                
            }
            return
        }
        
        
    }

}
