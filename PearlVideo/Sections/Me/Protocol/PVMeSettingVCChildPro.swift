//
//  PVMeSettingVCChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import StoreKit
import ObjectMapper
import SVProgressHUD
import CommonCrypto

//MARK: - 实名认证

extension PVMeNameValidateVC {
    /*
    func firstLoadData() {
        SVProgressHUD.show()
        PVNetworkTool.Request(router: .getUserValidateToken(idCard: <#T##String#>, name: <#T##String#>), success: { (resp) in
           
            if let d = Mapper<PVUserValidateModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                if d.verifyStage == UserValidateStageType.success.rawValue {
                    self.didValidateContent.isHidden = false
                    self.validateContent.isHidden = true
                    self.setNameAndIdCard(data: d)
                }
                else {
                    self.didValidateContent.isHidden = true
                    self.validateContent.isHidden = false
                }
            }
            SVProgressHUD.dismiss()
            
        }) { (e) in
            SVProgressHUD.dismiss()
        }
    }
    */
    
    // 人脸认证
    /*
    func loadData() {
        PVNetworkTool.Request(router: .getUserValidateToken(idCard: idCardTF.text ?? "", name: nameTF.text ?? ""), success: { (resp) in
            if let s = resp["result"]["bizMessage"].string {
                self.view.makeToast(s)
            }
            if let d = Mapper<PVUserValidateModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                if d.verifyStage == UserValidateStageType.success.rawValue {
                    self.didValidateContent.isHidden = false
                    self.validateContent.isHidden = true
                    self.setNameAndIdCard(data: d)
                }
                //去支付
                if d.verifyStage == UserValidateStageType.payment.rawValue {
                    self.didValidateContent.isHidden = true
                    self.validateContent.isHidden = false
                    AlipaySDK.defaultService()?.payOrder(d.payOrder, fromScheme: kAlipayScheme, callback: { (dic) in
                        
                        self.alertView?.closeAction()
                    })
                }
                //认证
                if d.verifyStage == UserValidateStageType.processing.rawValue {
                    self.alertView?.closeAction()
                    RPSDK.start(d.verifyToken.token, rpCompleted: { (auditState) in
                        //认证通过
                        if auditState == .PASS {
                            self.loadData()
                        }
                        else if(auditState == .FAIL) { //认证不通过
                            self.view.makeToast("认证不通过")
                        }
                        else if(auditState == .IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时、未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可
                            YPJOtherTool.ypj.showAlert(title: nil, message: "系统处理中，请稍后查看认证结果", style: .alert, isNeedCancel: false, handle: nil)
                        }
                        else if(auditState == .NOT) { //未认证，用户取消
                            
                        }
                        else if(auditState == .EXCEPTION) { //系统异常
                            self.view.makeToast("系统异常")
                        }
                    }, withVC: self.navigationController)
                }
            }
            
        }) { (e) in
            
        }
    }
    */
    
    func loadData() {
        guard idCardTF.hasText && nameTF.hasText else { return }
        let uuid = YPJOtherTool.ypj.getUUIDWithkeyChain()
        
        PVNetworkTool.Request(router: .userValidate(name: nameTF.text!, idCard: idCardTF.text!, deviceId: uuid), success: { (resp) in
            SVProgressHUD.dismiss()
            self.alertView?.closeAction()
            if let s = resp["result"]["bizMessage"].string {
                self.view.makeToast(s)
            }
            if let d = Mapper<PVUserValidateModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                //认证成功
                if d.verifyStage == UserValidateStageType.success.rawValue {
                    SVProgressHUD.showSuccess(withStatus: "认证成功")
                    self.didValidateContent.isHidden = false
                    self.validateContent.isHidden = true
                    self.setNameAndIdCard(name: d.name, idCard: d.idCard)
                    NotificationCenter.default.post(name: .kNotiName_userValidateSuccess, object: nil)
                }
                //去支付
                if d.verifyStage == UserValidateStageType.payment.rawValue {
                    self.didValidateContent.isHidden = true
                    self.validateContent.isHidden = false
                    let v = PVMeNameValidateAlert.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
                    v.delegate = self
                    self.alertView = v
                    self.view.addSubview(v)
                   
                }
                //认证失败
                if d.verifyStage == UserValidateStageType.fail.rawValue {
                    self.view.makeToast("认证失败")
                }
            }
        }) { (e) in
            self.alertView?.closeAction()
        }
        
        
    }
    
    func setNameAndIdCard(name: String, idCard: String) {
        let att_name = NSMutableAttributedString.init(string: "真实姓名    " + name)
        att_name.addAttributes([.font: kFont_text, .foregroundColor: kColor_subText!], range: NSMakeRange(0, 8))
        att_name.addAttributes([.font: kFont_text, .foregroundColor: UIColor.white], range: NSMakeRange(8, name.count))
        nameLabel.attributedText = att_name
        
        let att_idCard = NSMutableAttributedString.init(string: "身份证号    " + idCard)
        att_idCard.addAttributes([.font: kFont_text, .foregroundColor: kColor_subText!], range: NSMakeRange(0, 8))
        att_idCard.addAttributes([.font: kFont_text, .foregroundColor: UIColor.white], range: NSMakeRange(8, idCard.count))
        idCardLabel.attributedText = att_idCard
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        confirmBtn.isEnabled = checkBtn.isSelected && nameTF.hasText && idCardTF.hasText
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    //checkbox
    @objc func acceptAgreement(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmBtn.isEnabled = sender.isSelected && nameTF.hasText && idCardTF.hasText
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    //认证协议
    @objc func protocolAction(sender: UIButton) {
        let vc = PVAgreementWebVC.init(url: kValidateURL, title: "认证协议")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //认证
    @objc func confirm(sender: UIButton) {
        view.endEditing(true)
        loadData()
    }
    
    @objc func alipayCallbackNoti(sender: Notification?) {
        SVProgressHUD.show(withStatus: "认证中...")
        if self.data.idCard.count > 0 {
            SVProgressHUD.dismiss()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadData()
        }
    }
}

extension PVMeNameValidateVC: PVMeNameValidateAlertDelegate {
    
    func didSelectedValidate() {
        AlipaySDK.defaultService()?.payOrder(data.payOrder, fromScheme: kAlipayScheme, callback: { (dic) in
            print("alipay payOrder: ", dic ?? "")
            
        })
    }
}

 //MARK: - 修改密码
extension PVMePasswordChangeVC {
    
    @objc func textFieldEditingChange(sender: UITextField) {
        nextBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText
        nextBtn.backgroundColor = nextBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func didClickGetAuthCode(sender: UIButton) {
        guard phoneTF.hasText else {
            view.makeToast("请输入手机号")
            return
        }
        guard phoneTF.text!.ypj.isPhoneNumber else {
            view.makeToast("手机号输入不正确")
            return
        }
        sender.isEnabled = false
        PVNetworkTool.Request(router: .getAuthCode(phone: phoneTF.text!), success: { (resp) in
            auth()
            
        }) { (e) in
            sender.isEnabled = true
             
        }
        
        func auth() {
            var t = 60
            self.timer.setEventHandler {
                if t <= 1 {
                    self.timer.suspend()
                    DispatchQueue.main.async {
                        sender.setTitle("获取验证码", for: .normal)
                        sender.backgroundColor = kColor_pink
                        sender.isEnabled = true
                    }
                }
                else {
                    t -= 1
                    DispatchQueue.main.async {
                        sender.setTitle("重新发送(\(t)s)", for: .normal)
                        sender.backgroundColor = UIColor.gray
                        sender.isEnabled = false
                    }
                }
            }
            self.timer.resume()
            authCodeTF.becomeFirstResponder()
        }
    }
    
    @objc func nextAction(sender: UIButton) {
        sender.isEnabled = false
        PVNetworkTool.Request(router: .validateAuthCode(phone: phoneTF.text ?? "", code: authCodeTF.text ?? ""), success: { (resp) in
            sender.isEnabled = true
            let vc = PVMePasswordEditVC()
            vc.phone = self.phoneTF.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (e) in
            sender.isEnabled = true
             
        }
    }
    
}

extension PVMePasswordEditVC {
    
    @objc func textFieldEditingChange(sender: UITextField) {
        commitBtn.isEnabled = passwordTF_1.hasText && passwordTF_2.hasText
        commitBtn.backgroundColor = commitBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func secureAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if secureBtn_1 == sender {
            passwordTF_1.isSecureTextEntry = !sender.isSelected
        }
        if secureBtn_2 == sender {
            passwordTF_2.isSecureTextEntry = !sender.isSelected
        }

    }
    
    @objc func commitAction(sender: UIButton) {
        guard passwordTF_1.hasText && passwordTF_2.hasText else { return }
        guard passwordTF_1.text! == passwordTF_2.text! else {
            view.makeToast("两次输入的密码不一致")
            return
        }
        sender.isEnabled = false
        PVNetworkTool.Request(router: .changePsd(userId: kUserId, phone: phone, psd: passwordTF_1.text!), success: { (resp) in
            sender.isEnabled = true
            self.view.makeToast("修改成功")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.navigationController?.popToRootViewController(animated: true)
            })
            
        }) { (e) in
            sender.isEnabled = true
        }
    }
    
}

//MARK: - 交换密码
extension PVMeExchangePsdVC {
    
    @objc func textFieldEditingChange(sender: UITextField) {
        confirmBtn.isEnabled = phoneTF.hasText && authCodeTF.hasText && passwordTF_1.hasText && passwordTF_2.hasText
        confirmBtn.backgroundColor = confirmBtn.isEnabled ? kColor_pink : UIColor.gray
    }
    
    @objc func getAuthCode(sender: UIButton) {
        guard phoneTF.hasText else {
            view.makeToast("请输入手机号")
            return
        }
        guard phoneTF.text!.ypj.isPhoneNumber else {
            view.makeToast("手机号输入不正确")
            return
        }
        sender.isEnabled = false
        PVNetworkTool.Request(router: .getAuthCode(phone: phoneTF.text!), success: { (resp) in
            auth()
            
        }) { (e) in
            sender.isEnabled = true
             
        }
        
        func auth() {
            var t = 60
            self.timer.setEventHandler {
                if t <= 1 {
                    self.timer.suspend()
                    DispatchQueue.main.async {
                        sender.setTitle("获取验证码", for: .normal)
                        sender.backgroundColor = kColor_pink
                        sender.isEnabled = true
                    }
                }
                else {
                    t -= 1
                    DispatchQueue.main.async {
                        sender.setTitle("重新发送(\(t)s)", for: .normal)
                        sender.backgroundColor = UIColor.gray
                        sender.isEnabled = false
                    }
                }
            }
            self.timer.resume()
            authCodeTF.becomeFirstResponder()
        }
    }
    
    @objc func confirmAction(sender: UIButton) {
        sender.isEnabled = false
        
    }
}

//MARK: - 收款方式
extension PVMePayWayVC {
    
    @objc func addAccount(sender: UIButton) {
        let v = PVMePayWayAlert.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        v.delegate = self
        view.addSubview(v)
    }
    
}

extension PVMePayWayVC: PVMePayWayAlertDelegate {
    
    func didSelectedConfirm(name: String, account: String) {
        let att = NSMutableAttributedString.init(string: "修改 " + account)
        att.addAttributes([.font: kFont_text, .foregroundColor: kColor_text!], range: NSMakeRange(0, 3))
        att.addAttributes([.font: kFont_btn_weight, .foregroundColor: kColor_text!], range: NSMakeRange(3, account.count))
        addBtn.setAttributedTitle(att, for: .normal)
    }
}

//MARK: - 意见反馈
extension PVMeFeedbackVC {
    
    @objc func commitAction(sender: UIButton) {
        let uploadImages = imgs.filter { (obj) -> Bool in
            return obj != addImg
        }
        var imgPaths = Array<String>()
        for v in uploadImages {
            if let p = v.ypj.saveImageToLocalFolder(directory: .cachesDirectory, compressionQuality: 1.0) {
                imgPaths.append(p)
            }
        }
        //FIX
        //类型: 1解冻 2优化意见 3其他
        PVNetworkTool.Request(router: .feedback(type: type, name: name, phone: phone, idCard: idCard, imageUrl: [""], content: content), success: { (resp) in
            self.navigationController?.popToRootViewController(animated: true)
            
        }) { (e) in
            
        }
    }
    
    //我的反馈
    override func rightButtonsAction(sender: UIButton) {
        let vc = PVMeMyFeedbackVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func typeAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            typeBgView.frame = CGRect.init(x: 0, y: kNavigationBarAndStatusHeight + topBgView.height, width: kScreenWidth, height: kScreenHeight - kNavigationBarAndStatusHeight - topBgView.height)
            view.addSubview(typeBgView)
            typeTableView.height = 0
            UIView.animate(withDuration: 0.3) {
                self.typeTableView.height += 150 * KScreenRatio_6
                sender.imageView?.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            }
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                sender.imageView?.transform = CGAffineTransform.identity
                self.typeTableView.height = 0
                
            }) { (isFinish) in
                self.typeBgView.removeFromSuperview()
            }
        }
    }
    
    @objc func typeDismiss(sender: UITapGestureRecognizer) {
        typeAction(sender: typeBtn)
    }
    
    @objc func textFieldEditingChange(sender: UITextField) {
        if sender == nameTF { name = nameTF.text ?? "" }
        if sender == phoneTF { phone = phoneTF.text ?? "" }
        if sender == idCardTF { idCard = idCardTF.text ?? "" }
        if sender == contentTF {
            if contentTF.hasText && contentTF.text!.count > kFeedbackContentLimitCount && contentTF.markedTextRange == nil {
                contentTF.text = String(contentTF.text!.prefix(kFeedbackContentLimitCount))
                return
            }
            content = contentTF.text ?? ""
            contentCountLabel.text = "\(content.count)/\(kFeedbackContentLimitCount)"
        }
        if name.count > 0 && phone.count > 0 && idCard.count > 0 && content.count > 0 {
            commitBtn.isEnabled = true
            commitBtn.backgroundColor = kColor_pink
        }
        else {
            commitBtn.isEnabled = false
            commitBtn.backgroundColor = UIColor.gray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension PVMeFeedbackVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeFeedbackTypeCell.init(style: .default, reuseIdentifier: nil)
        cell.titleLabel.text = ["解冻", "优化意见", "其它"][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        type = indexPath.row + 1
        typeBtn.isSelected = !typeBtn.isSelected
        typeBtn.setTitle(["解冻", "优化意见", "其它"][indexPath.row], for: .normal)
        typeTableView.height = 0
        typeBtn.imageView?.transform = CGAffineTransform.identity
        typeBgView.removeFromSuperview()
    }
    
}

extension PVMeFeedbackVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeFeedbackCell", for: indexPath) as! PVMeFeedbackCell
        cell.delegate = self
        cell.imgIV.image = imgs[indexPath.item]
        cell.deleteBtn.isHidden = imgs[indexPath.item] == addImg
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        YPJOtherTool.ypj.getPhotosAuth(target: self) {
            self.selectedImageIndex = indexPath.item
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
}

extension PVMeFeedbackVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let imgData = resultImage.ypj.compressImage(maxLength: 512 * 1024) else { return }
            guard let img = UIImage.init(data: imgData) else { return }
            guard imgs.count > selectedImageIndex else { return }
            if selectedImageIndex == imgs.count - 1 {
                if selectedImageIndex == kFeedbackImageLimitCount - 1 {//最后一张替换
                    imgs[selectedImageIndex] = img
                }
                else {//add
                    imgs.insert(img, at: selectedImageIndex)
                }
                
            }
            else {//替换
                imgs[selectedImageIndex] = img
            }
            imgCollectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}

extension PVMeFeedbackVC: PVMeFeedbackImageDelegate {
    //删除照片
    func didSeletedDelete(cell: UICollectionViewCell) {
        if let indexPath = imgCollectionView.indexPath(for: cell) {
            if imgs.count > indexPath.item {
                imgs.remove(at: indexPath.item)
                imgCollectionView.deleteItems(at: [indexPath])
            }
            if imgs.contains(addImg) == false {
                imgs.append(addImg)
                imgCollectionView.reloadData()
            }
        }
    }
    
}

extension PVMeFeedbackVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard touch.view != nil else { return true }
        if touch.view!.isDescendant(of: typeTableView) { return false }
        return true
    }
}

//MARK: - 我的反馈
extension PVMeMyFeedbackVC {
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .myFeedback(page: page * 10), success: { (resp) in
            if let d = Mapper<PVMeFeedbackList>().mapArray(JSONObject: resp["result"]["feedbackList"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else { self.dataArr += d }
                self.tableView.reloadData()
            }
            if self.dataArr.count == 0 { self.tableView.stateEmpty() }
            else { self.tableView.stateNormal() }
            self.tableView.mj_footer.endRefreshing()
            
        }) { (e) in
            self.page = self.page > 0 ? self.page - 1 : 0
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func setRefresh() {
        PVRefresh.headerRefresh(scrollView: tableView) {[weak self] in
            self?.page = 0
            self?.loadData(page: 0)
        }
        PVRefresh.footerRefresh(scrollView: tableView) {[weak self] in
            self?.page += 1
            self?.loadData(page: self?.page ?? 0)
        }
    }
}

extension PVMeMyFeedbackVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PVMeMyFeedbackCell") as? PVMeMyFeedbackCell
        if cell == nil {
            cell = PVMeMyFeedbackCell.init(style: .default, reuseIdentifier: "PVMeMyFeedbackCell")
        }
        cell?.delegate = self
        guard dataArr.count > indexPath.row else { return cell! }
        cell?.data = dataArr[indexPath.row]
        return cell!
    }
}

extension PVMeMyFeedbackVC: PVMeMyFeedbackDelegate {
    
    func didSelectedHandle(sender: UIButton, cell: PVMeMyFeedbackCell) {
        
    }
    
}

//MARK: - 关于我们
extension PVMeAboutVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeAboutCell.init(image: imgs[indexPath.row], title: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {//用户协议
           let vc = PVAgreementWebVC.init(url: kUserAgreementURL, title: "用户协议")
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {//隐私政策
            let vc = PVAgreementWebVC.init(url: kSecureURL, title: "隐私政策")
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {//社区管理公约
            let vc = PVAgreementWebVC.init(url: kCommunityURL, title: "社区管理公约")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - 检测更新
extension PVMeVersionVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeVersionCell.init(title: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func gotoStore() {
            let vc = SKStoreProductViewController.init()
            vc.delegate = self
            vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: kAPPID]) {[weak self] (isFinish, error) in
                if error != nil { print(error!.localizedDescription) }
                else {
                    self?.present(vc, animated: true, completion: nil)
                }
            }
        }
        
        if indexPath.row == 0 {//评分
            gotoStore()
        }
        if indexPath.row == 1 {//更新
            gotoStore()
        }
    }
    
}

//内置app store delegate
extension PVMeVersionVC: SKStoreProductViewControllerDelegate {
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
