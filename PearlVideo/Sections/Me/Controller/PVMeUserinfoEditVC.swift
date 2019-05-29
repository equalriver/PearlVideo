//
//  PVMeUserinfoEditVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/2.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UIKit

class PVMeUserinfoEditVC: PVBaseNavigationVC {

    public var data = PVMeModel() {
        didSet{
            iconIV.kf.setImage(with: URL.init(string: data.avatarUrl))
            nameTF.text = data.nickName
            genderContent.text = data.gender == 1 ? "男" : "女"
            countLabel.text = "\(data.autograph.count)/\(kSigningLimitCount)"
            signTV.text = data.autograph
        }
    }
    
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
    lazy var contentView_1: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var contentView_2: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var contentView_3: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_background
        return v
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.text = "昵称"
        return l
    }()
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.font = kFont_text
        tf.textColor = UIColor.white
        tf.attributedPlaceholder = NSAttributedString.init(string: "请输入昵称", attributes: [.font: kFont_text, .foregroundColor: kColor_subText!])
        return tf
    }()
    lazy var genderLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.text = "性别"
        return l
    }()
    lazy var genderContent: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(genderAction))
        l.addGestureRecognizer(tap)
        return l
    }()
    lazy var genderBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "right_arrow"), for: .normal)
        b.addTarget(self, action: #selector(genderAction), for: .touchUpInside)
        return b
    }()
    lazy var signLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = UIColor.white
        l.text = "签名"
        return l
    }()
    lazy var countLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = kFont_text_3
        l.textColor = kColor_subText
        l.text = "0/\(kSigningLimitCount)"
        return l
    }()
    lazy var signTV: YYTextView = {
        let v = YYTextView()
        v.backgroundColor = kColor_background
        v.placeholderText = "编辑你的个性签名"
        v.placeholderFont = kFont_text_3
        v.placeholderTextColor = kColor_subText
        v.delegate = self
        return v
    }()
    lazy var checkBtn: UIButton = {
        let b = UIButton()
        b.setImage(UIImage.init(named: "fy_勾"), for: .normal)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        view.backgroundColor = kColor_deepBackground
        title = "编辑资料"
        naviBar.rightBarButtons = [checkBtn]
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6)
        iconIV.ypj.addCornerShape(rect: rect, cornerRadius: rect.height / 2, fillColor: kColor_deepBackground!)
    }
    
    func initUI() {
        view.addSubview(iconIV)
        view.addSubview(contentView_1)
        contentView_1.addSubview(nameLabel)
        contentView_1.addSubview(nameTF)
        view.addSubview(contentView_2)
        contentView_2.addSubview(genderLabel)
        contentView_2.addSubview(genderContent)
        contentView_2.addSubview(genderBtn)
        view.addSubview(signLabel)
        view.addSubview(countLabel)
        view.addSubview(contentView_3)
        contentView_3.addSubview(signTV)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * KScreenRatio_6, height: 100 * KScreenRatio_6))
            make.top.equalTo(naviBar.snp.bottom).offset(25 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        contentView_1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 50 * KScreenRatio_6))
            make.top.equalTo(iconIV.snp.bottom).offset(50 * KScreenRatio_6)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
            make.centerY.equalToSuperview()
        }
        nameTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(110 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        contentView_2.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: 50 * KScreenRatio_6))
            make.top.equalTo(contentView_1.snp.bottom)
            make.centerX.equalToSuperview()
        }
        genderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.centerY.equalToSuperview()
        }
    }
    

    override func rightButtonsAction(sender: UIButton) {
        guard let img = iconIV.image else { return }
        guard genderContent.text != nil else { return }
        let args: [String: Any] = ["nickName": nameTF.text ?? data.nickName, "gender": genderContent.text! == "男" ? 1 : 2, "autograph": signTV.text ?? data.autograph]
        
        PVNetworkTool.upLoadImageRequest(images: [img], imagesName: "avatarUrl", params: args, router: .editUserInfo(), success: { (resp) in
            self.navigationController?.popViewController(animated: true)
            
        }) { (e) in
            
        }
        
    }
    
    @objc func didSelectedHeader(sender: UITapGestureRecognizer) {
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
    
    @objc func genderAction() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let ac_1 = UIAlertAction.init(title: "男", style: .default) { (ac) in
            self.genderContent.text = "男"
        }
        let ac_2 = UIAlertAction.init(title: "女", style: .default) { (ac) in
            self.genderContent.text = "女"
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ac_1)
        alert.addAction(ac_2)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
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

extension PVMeUserinfoEditVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        guard textView.hasText else {
            countLabel.text = "0/\(kSigningLimitCount)"
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
            self.countLabel.text = current + total
        }
    }

}

