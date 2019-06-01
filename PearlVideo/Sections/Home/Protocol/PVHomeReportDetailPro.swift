//
//  PVHomeReportDetailPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: - action
extension PVHomeReportDetailVC {
    
    @objc func commitAction(sender: UIButton) {
        sender.isEnabled = false
        
        let uploadImages = imgs.filter { (obj) -> Bool in
            return obj != addImg
        }
        var imgPaths = Array<String>()
        for v in uploadImages {
            if let p = v.ypj.saveImageToLocalFolder(directory: .cachesDirectory, compressionQuality: 1.0) {
                imgPaths.append(p)
            }
        }
        //FIX image未上传
        PVNetworkTool.Request(router: .videoReport(videoId: videoId, type: type, content: contentTV.text ?? ""), success: { (resp) in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }) { (e) in
            
        }
        
        
    }
    
}


//MARK: - collection view delegate
extension PVHomeReportDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PVMeFeedbackCell", for: indexPath) as! PVMeFeedbackCell
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        YPJOtherTool.ypj.getPhotosAuth(target: self) {
            self.selectedImageIndex = indexPath.item
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
}

//MARK: - image picker
extension PVHomeReportDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.editedImage] as? UIImage {
            
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
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}

extension PVHomeReportDetailVC: PVMeFeedbackImageDelegate {
    
    func didSeletedDelete(cell: UICollectionViewCell) {
        if let indexPath = imgCollectionView.indexPath(for: cell) {
            if imgs.count > indexPath.item {
                imgs.remove(at: indexPath.item)
                imgCollectionView.deleteItems(at: [indexPath])
            }
        }
    }
    
}

//MARK: - YYTextViewDelegate
extension PVHomeReportDetailVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        guard textView.hasText else {
            countLabel.text = "0/\(kReportLimitCount)"
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            
            guard textView.markedTextRange == nil else { return }
            
            if textView.hasText {
                if textView.text.count > kReportLimitCount {
                    self.view.makeToast("超出字数限制")
                    textView.text = String(textView.text.prefix(kReportLimitCount))
                    return
                }
                
            }
            let current = "\(textView.text.count)"
            let total = "/\(kReportLimitCount)"
            self.countLabel.text = current + total
        }
    }
    
}
