//
//  PVExchangeRecordDetailPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/6/4.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - 买单详情
extension PVExchangeRecordBuyDetailVC {
    
    func loadData() {
        PVNetworkTool.Request(router: .recordDetail(orderId: orderId), success: { (resp) in
            
            
        }) { (e) in
            
        }
    }
    
    @objc func cancelOrder(sender: UIButton) {
        PVNetworkTool.Request(router: .cancelOrder(orderId: orderId), success: { (resp) in
            
            
        }) { (e) in
            
        }
    }
    
}


//MARK: - 卖单详情
extension PVExchangeRecordSellDetailVC {
    
    @objc func cancelOrder(sender: UIButton) {
        
    }
    
}


//MARK: - 交换中详情
extension PVExchangeRecordChangingDetailVC {}


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

//MARK: - bottom buttons action
extension PVExchangeRecordChangingDetailVC: ChangingBottomButtonsDelegate {
    
    func didSelectedCancel() {
        //申诉
        if type == .payWithFruit {//待放平安果
            
            return
        }
       
    }
    
    func didSelectedPay() {
        
        if type == .payWithFruit {//待放平安果
            
            return
        }
        
        if type == .waitForPay {//待支付
            if screenshotView.imageIV.image == nil {
                view.makeToast("未上传支付截图")
                return
            }
            //FIX: upload
            if let url = uploadImageURL {
                
            }
            
            return
        }
    }

}
