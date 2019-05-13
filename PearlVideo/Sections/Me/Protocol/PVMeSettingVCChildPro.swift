//
//  PVMeSettingVCChildPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import StoreKit

//MARK: - 实名认证
extension PVMeNameValidateVC {
    
    @objc func acceptAgreement(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if name != nil && phone != nil && idCard != nil && sender.isSelected { confirmBtn.isEnabled = true }
    }
    
    @objc func confirm(sender: UIButton) {
        
    }
}

extension PVMeNameValidateVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {//姓名
            name = textField.text
        }
        if textField.tag == 1 {//电话
            if string.ypj.isAllNumber == false { return false }
            phone = textField.text
        }
        if textField.tag == 2 {//身份证
            if string.ypj.isAllNumber == false { return false }
            idCard = textField.text
        }
        if name != nil && phone != nil && idCard != nil && checkBtn.isSelected { confirmBtn.isEnabled = true }
        
        return true
    }
}

extension PVMeNameValidateVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeNameValidateCell.init(title: titles[indexPath.row], tag: indexPath.row, textField: self)
        
        return cell
    }
    
}


 //MARK: - 修改密码
extension PVMePasswordChangeVC {
    
    @objc func didClickGetAuthCode(sender: UIButton) {
        sender.isEnabled = false
        var t = 59
        
        self.timer.setEventHandler {
            if t <= 1 {
                self.timer.suspend()
                DispatchQueue.main.async {
                    sender.setTitle("获取验证码", for: .normal)
                    sender.isEnabled = true
                }
            }
            else {
                t -= 1
                DispatchQueue.main.async {
                    sender.setTitle("已发送(\(t))", for: .normal)
                    sender.isEnabled = false
                }
            }
        }
        self.timer.resume()
    }
    
    @objc func nextAction() {
        
    }
    
}

extension PVMePasswordChangeVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.ypj.isAllNumber == false { return false }
        if phoneTF.hasText && authCodeTF.hasText { nextBtn.isEnabled = true }
        return true
    }
    
}



//MARK: - 意见反馈
extension PVMeFeedbackVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func rightButtonsAction(sender: UIButton) {
        let uploadImages = imgs.drop { (obj) -> Bool in
            return obj != addImg
        }
        
    }
    
    @objc func keyboardShowAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardFrame = info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        if contactView.contentTV.isFirstResponder  {
            let y = keyboardFrame.origin.y - contactView.origin.y - contactView.contentTV.origin.y - contactView.contentTV.height
            UIView.animate(withDuration: duration) {
                self.view.centerY = kScreenHeight / 2 + y
            }
        }
    }
    
    @objc func keyboardHideAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        if contactView.contentTV.isFirstResponder {
            UIView.animate(withDuration: duration) {
                self.view.center = CGPoint.init(x: kScreenWidth / 2, y: kScreenHeight / 2)
            }
        }
    }
    
}

extension PVMeFeedbackVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        guard textView.superview != nil else { return }
        if textView.superview! == contactView {//问题建议
            content = textView.text ?? ""
        }
        else {//邮箱/手机号/QQ
            contact = textView.text ?? ""
        }
        if content.count > 0 && contact.count > 0 {
            commitBtn.isEnabled = true
        }
        else {
            commitBtn.isEnabled = false
        }
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
            //FIX ME: appid ?
            vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: "appid"]) {[weak self] (isFinish, error) in
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
