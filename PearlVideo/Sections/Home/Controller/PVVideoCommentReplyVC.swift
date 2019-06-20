//
//  PVVideoCommentReplyVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/24.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UITableView_FDTemplateLayoutCell
import ObjectMapper

class PVVideoCommentReplyVC: PVBaseViewController {
    
    var commentId = 0
    var videoId = ""
    var data = PVCommentReplyModel()
    
    let inputViewRect = CGRect.init(x: 0, y: kScreenHeight - 50 * KScreenRatio_6, width: kScreenWidth, height: 50 * KScreenRatio_6)
    
    lazy var headerView: PVVideoCommentReplyHeader = {
        let v = PVVideoCommentReplyHeader.init(frame: .zero)
        v.delegate = self
        return v
    }()
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = kColor_deepBackground
        tb.separatorStyle = .none
        tb.delegate = self
        tb.dataSource = self
        tb.register(PVVideoCommentCell.self, forCellReuseIdentifier: "PVVideoCommentCell")
        return tb
    }()
    lazy var commentInputView: PVAttentionDetailCommentInputView = {
        let v = PVAttentionDetailCommentInputView.init(frame: .zero, delegate: self)
        return v
    }()
    
    required convenience init(commentId: Int, videoId: String) {
        self.init()
        initUI()
        self.commentId = commentId
        self.videoId = videoId
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowAction(noti:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideAction(noti:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    func initUI() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(commentInputView)
        headerView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
            make.height.equalTo(210 * KScreenRatio_6)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(commentInputView.snp.top)
        }
        commentInputView.snp.makeConstraints { (make) in
            make.height.equalTo(50 * KScreenRatio_6)
            make.bottom.centerX.width.equalToSuperview()
        }
    }
    
    @objc func keyboardShowAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        guard let keyboardFrame = info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        UIView.animate(withDuration: duration) {
            self.commentInputView.centerY = self.inputViewRect.origin.y + self.inputViewRect.height / 2 - keyboardFrame.height
        }
        
    }
    
    @objc func keyboardHideAction(noti: Notification) {
        guard let info = noti.userInfo else { return }
        guard let duration = info[UIApplication.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.commentInputView.centerY = self.inputViewRect.origin.y + self.inputViewRect.height / 2
        }
    }
    
    func loadData() {
        PVNetworkTool.Request(router: .commentReplyList(commitId: commentId), success: { (resp) in
            if let d = Mapper<PVCommentReplyModel>().map(JSONObject: resp["result"].object) {
                self.data = d
                self.headerView.data = d
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.headerView.snp.updateConstraints({ (make) in
                        let h = self.data.content.ypj.getStringHeight(font: kFont_text_2, width: kCommentContentWidth)
                        make.height.equalTo(200 * KScreenRatio_6 + h)
                    })
                })
            }
            
        }) { (e) in
            
        }
    }
    
}

//MARK: - header view delegate
extension PVVideoCommentReplyVC: PVVideoCommentReplyHeaderDelegate {
    //头像
    func didSelectedAvatar() {
        if let currentId = UserDefaults.standard.string(forKey: kUserId) {
            if data.userId == currentId { return }
        }
        let vc  = PVUserInfoVC()
        vc.userId = data.userId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //点赞
    func didSelectedLike(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        data.status = sender.isSelected ? 1 : 2
        if sender.isSelected { data.commentThumbupCount += 1 }
        else { data.commentThumbupCount -= 1 }
        sender.setTitle("\(data.commentThumbupCount)", for: .normal)
        let args: [String: Any] = ["data": data, "sender": sender]
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoHeaderLike(args:)), object: args)
        self.perform(#selector(videoHeaderLike(args:)), with: args, afterDelay: 2)
    }
    
    @objc func videoHeaderLike(args: [String: Any]) {
        guard let data = args["data"] as? PVCommentReplyModel else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoLike(id: data.videoId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("点赞：", data.userId)
        }) { (e) in
            
        }
    }
    
    func didSelectedDismiss() {
        dismiss(animated: true, completion: nil)
    }

}

//MARK: - table view delegate
extension PVVideoCommentReplyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.replies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVVideoCommentCell", cacheBy: indexPath, configuration: { (cell) in
            guard let cell = cell as? PVVideoCommentCell else { return }
            cell.data = self.data.replies[indexPath.row]
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVVideoCommentCell", for: indexPath) as! PVVideoCommentCell
        cell.delegate = self
        guard data.replies.count > indexPath.row else { return cell }
        cell.data = data.replies[indexPath.row]
        return cell
    }
}

//MARK: - cell delegate
extension PVVideoCommentReplyVC: PVVideoCommentCellDelegate {
    //头像
    func didSelectedAvatar(cell: PVVideoCommentCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if let currentId = UserDefaults.standard.string(forKey: kUserId) {
            if data.replies[indexPath.row].userId == currentId { return }
        }
        let vc  = PVUserInfoVC()
        vc.userId = data.replies[indexPath.row].userId
        navigationController?.pushViewController(vc, animated: true)
    }
    //点赞
    func didSelectedLike(cell: PVVideoCommentCell, sender: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        sender.isSelected = !sender.isSelected
        if sender.isSelected { data.replies[indexPath.row].commentThumbupCount += 1 }
        else { data.replies[indexPath.row].commentThumbupCount -= 1 }
        sender.setTitle("\(data.replies[indexPath.row].commentThumbupCount)", for: .normal)
        data.replies[indexPath.row].status = sender.isSelected ? 1 : 2
        let args: [String: Any] = ["data": data.replies[indexPath.row], "sender": sender]
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(videoLike(args:)), object: args)
        self.perform(#selector(videoLike(args:)), with: args, afterDelay: 2)
    }
    
    @objc func videoLike(args: [String: Any]) {
        guard let data = args["data"] as? PVVideoCommentModel else { return }
        guard let sender = args["sender"] as? UIButton else { return }
        PVNetworkTool.Request(router: .videoLike(id: data.videoId, action: sender.isSelected ? 1 : 2), success: { (resp) in
            print("点赞：", data.userId)
        }) { (e) in
            
        }
    }
    
}

//MARK: - input view delegate
extension PVVideoCommentReplyVC: YYTextViewDelegate {
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            PVNetworkTool.Request(router: .twiceComment(id: commentId, videoId: videoId, content: textView.text), success: { (resp) in
                self.loadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    textView.text = ""
                })
                
            }) { (e) in
                
            }
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
}

