//
//  PVMeUserinfoEditVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeUserinfoEditVC: PVBaseNavigationVC {

    let titles = ["选择性别", "请选择", "请输入所在城市"]
    var gender = ""
    var birthday = ""
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let l = UILabel()
        l.text = "更换"
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.backgroundColor = UIColor.clear
        l.font = kFont_text_3
        iv.addSubview(l)
        l.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        })
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didSelectedHeader(sender:)))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.font = kFont_text
        tf.textColor = kColor_text
        tf.placeholder = "请输入昵称"
        tf.isEnabled = false
        tf.addBlock(for: .editingDidEnd, block: {[weak self] (t) in
            tf.resignFirstResponder()
            tf.isEnabled = false
        })
        return tf
    }()
    lazy var inputBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "me_edit"), for: .normal)
        b.addTarget(self, action: #selector(nameEdit(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = UIColor.white
        tb.isScrollEnabled = false
        return tb
    }()
    lazy var signingView: PVMeUserinfoEditSigningView = {
        let v = PVMeUserinfoEditSigningView.init(frame: .zero)
        v.delegate = self
        return v
    }()
    lazy var checkBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "pv_check"), for: .normal)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "编辑资料"
        naviBar.rightBarButtons = [checkBtn]
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6)
        iconIV.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: UIColor.white)
    }
    
    func initUI() {
        view.addSubview(iconIV)
        view.addSubview(nameTF)
        view.addSubview(inputBtn)
        view.addSubview(tableView)
        view.addSubview(signingView)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom).offset(25 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        nameTF.snp.makeConstraints { (make) in
            make.width.equalTo(80 * KScreenRatio_6)
            make.top.equalTo(iconIV.snp.bottom).offset(15 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        inputBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameTF)
            make.left.equalTo(nameTF.snp.right).offset(2)
            make.size.equalTo(CGSize.init(width: 20 * KScreenRatio_6, height: 20 * KScreenRatio_6))
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(nameTF.snp.bottom).offset(50 * KScreenRatio_6)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(150 * KScreenRatio_6)
        }
        signingView.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
        }
    }
    

    override func rightButtonsAction(sender: UIButton) {
        
    }
    
    @objc func didSelectedHeader(sender: UITapGestureRecognizer) {
        YPJOtherTool.ypj.getPhotosAuth(target: self) {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @objc func nameEdit(sender: UIButton) {
        nameTF.isEnabled = true
        nameTF.becomeFirstResponder()
    }

}

extension PVMeUserinfoEditVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.editedImage] as? UIImage {
            
            guard let imgData = resultImage.ypj.compressImage(maxLength: 512 * 1024) else { return }
            let img = UIImage.init(data: imgData)
            iconIV.image = img
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
}

extension PVMeUserinfoEditVC: SigningViewDelegate {
    
    func signingTextChange(textView: YYTextView, _ count: @escaping (String) -> Void) {
        guard textView.hasText else {
            count("0/\(kSigningLimitCount)")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            
            guard textView.markedTextRange == nil else { return }
            
            if textView.hasText {
                if textView.text.count > kSigningLimitCount {
                    self.view.makeToast("超出字数限制")
                    textView.text = String(textView.text.prefix(kSigningLimitCount))
                    return
                }
                
            }
            let current = "\(textView.text.count)"
            let total = "/\(kSigningLimitCount)"
            count(current + total)
        }
    }

}


extension PVMeUserinfoEditVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50  * KScreenRatio_6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PVMeUserinfoEditCell.init(placeholder: titles[indexPath.row])
        if indexPath.row == 2 {//地址
            cell.contentTF.isUserInteractionEnabled = true
            cell.arrowIV.isHidden = true
        }
        if indexPath.row == 0 { cell.contentTF.text = gender }
        if indexPath.row == 1 { cell.contentTF.text = birthday }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func showAlert(title_1: String, title_2: String, handler_1: ((UIAlertAction) -> Void)?, handler_2: ((UIAlertAction) -> Void)?) {
            let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
            let ac_1 = UIAlertAction.init(title: title_1, style: .default, handler: handler_1)
            let ac_2 = UIAlertAction.init(title: title_2, style: .default, handler: handler_2)
            let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alert.addAction(ac_1)
            alert.addAction(ac_2)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        //gender
        if indexPath.row == 0 {
            showAlert(title_1: "男", title_2: "女", handler_1: { (ac) in
                self.gender = "男"
            }) { (ac) in
                self.gender = "女"
            }
            tableView.reloadRow(at: indexPath, with: .none)
        }
        //birthday
        if indexPath.row == 1 {
            let pv = PVDatePickerView.init(frame: UIScreen.main.bounds, dateFormat: nil) {[weak self] (date) in
                self?.birthday = date
                self?.tableView.reloadRow(at: indexPath, with: .none)
            }
            view.addSubview(pv)
        }
        
    }
    
}
