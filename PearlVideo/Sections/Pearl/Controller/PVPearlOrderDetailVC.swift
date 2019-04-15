//
//  PVPearlOrderDetailVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/15.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVPearlOrderDetailVC: PVBaseNavigationVC {


    //upload image
    var uploadImage: UIImage?
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = UIColor.white
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(naviBar.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
        
    }
    
    func makeCall(phone: String) {
        let alert = UIAlertController.init(title: nil, message: "是否拨打联系电话?", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "是", style: .default, handler: { (ac) in
            guard URL.init(string: "telprompt:\(phone)") != nil else {
                self.view.makeToast("未设置电话或电话信息有误")
                return
            }
            if UIApplication.shared.canOpenURL(URL.init(string: "telprompt:\(phone)")!){
                UIApplication.shared.openURL(URL.init(string: "telprompt:\(phone)")!)
            }
        })
        let cancel = UIAlertAction.init(title: "否", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension PVPearlOrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 130 * KScreenRatio_6 }//付款信息
        if indexPath.row == 1 { return 150 * KScreenRatio_6 }//买家信息
        if indexPath.row == 2 { return 205 * KScreenRatio_6 }//卖家信息
        if indexPath.row == 3 { return 320 * KScreenRatio_6 }//支付截图
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = PVPearlOrderDetailPayCell.init(style: .default, reuseIdentifier: nil)
            
            return cell
        }
        if indexPath.row == 1 {
            let cell = PVPearlOrderDetailBuyerCell.init(style: .default, reuseIdentifier: nil)
            cell.delegate = self
            return cell
        }
        if indexPath.row == 2 {
            let cell = PVPearlOrderDetailSellerCell.init(style: .default, reuseIdentifier: nil)
            cell.delegate = self
            
            return cell
        }
        if indexPath.row == 3 {
            let cell = PVPearlOrderDetailScreenShotCell.init(style: .default, reuseIdentifier: nil)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}

//买家信息 delegate
extension PVPearlOrderDetailVC: PVPearlOrderDetailBuyerDelegate {
    
    func didSelectedNameCopy(cell: UITableViewCell) {
        let pasteboard = UIPasteboard.init()
        pasteboard.string = ""
        view.makeToast("复制成功")
    }
    
    func didSelectedRingUp(cell: UITableViewCell) {
        makeCall(phone: "")
    }
    
}

//MARK: - 卖家信息 delegate
extension PVPearlOrderDetailVC: PVPearlOrderDetailSellerDelegate {
    
    func didSelectedSellerNameCopy(cell: UITableViewCell) {
        let pasteboard = UIPasteboard.init()
        pasteboard.string = ""
        view.makeToast("复制成功")
    }
    
    func didSelectedSellerRingUp(cell: UITableViewCell) {
        makeCall(phone: "")
    }
    
    func didSelectedAliPayCopy(cell: UITableViewCell) {
        let pasteboard = UIPasteboard.init()
        pasteboard.string = ""
        view.makeToast("复制成功")
    }
    
    
}

//MARK: - 支付截图 delegate
extension PVPearlOrderDetailVC: PVPearlOrderDetailScreenShotDelegate {
    
    func didSelectedAddImage(sender: UIImageView, cell: UITableViewCell) {
        YPJOtherTool.ypj.getPhotosAuth(target: self) {
            let vc = UIImagePickerController.init()
            vc.allowsEditing = false
            vc.sourceType = .photoLibrary
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
}

extension PVPearlOrderDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.originalImage] as? UIImage {
            
            guard let imgData = resultImage.ypj.compressImage(maxLength: 512 * 1024) else { return }
            guard let img = UIImage.init(data: imgData) else { return }
            uploadImage = img
            tableView.reloadRow(at: IndexPath.init(row: 3, section: 0), with: .none)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}
