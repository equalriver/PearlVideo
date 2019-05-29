//
//  PVVideoCommentReplyVC.swift
//  PearlVideo
//
//  Created by equalriver on 2019/5/24.
//  Copyright © 2019 equalriver. All rights reserved.
//

import UITableView_FDTemplateLayoutCell

class PVVideoCommentReplyVC: PVBaseViewController {
    
    var commentId = 0
    var videoId = ""
    
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

//MARK: - header view delegate
extension PVVideoCommentReplyVC: PVVideoCommentReplyHeaderDelegate {
    
    func didSelectedLike(sender: UIButton) {
        
    }
    
    func didSelectedDismiss() {
        dismiss(animated: true, completion: nil)
    }

}

//MARK: - table view delegate
extension PVVideoCommentReplyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVVideoCommentCell", cacheBy: indexPath, configuration: { (cell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVVideoCommentCell", for: indexPath) as! PVVideoCommentCell
        cell.delegate = self
        
        return cell
    }
}

//MARK: - cell delegate
extension PVVideoCommentReplyVC: PVVideoCommentCellDelegate {
    
    func didSelectedAvatar(cell: PVVideoCommentCell) {
        
    }
    
    func didSelectedLike(cell: PVVideoCommentCell, sender: UIButton) {
        
    }
    
    func didSelectedMoreReply(cell: PVVideoCommentCell, sender: UIButton) {
        
    }
    
}

//MARK: - input view delegate
extension PVVideoCommentReplyVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        if textView.contentSize.height > textView.height && textView.contentSize.height <= 80 {
            let offsetY = textView.contentSize.height - textView.height
            commentInputView.origin.y -= offsetY
            commentInputView.height += offsetY
        }
    }
    
}

extension PVVideoCommentReplyVC {
    
    func didSelectedDone(textView: YYTextView) {
        if textView.hasText {
            PVNetworkTool.Request(router: .twiceComment(id: commentId, videoId: videoId, content: textView.text), success: { (resp) in
                
                
            }) { (e) in
                
            }
        }
        textView.text = nil
        textView.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.commentInputView.origin.y = kScreenHeight * 2 - 50 * KScreenRatio_6
            self.commentInputView.height = 50 * KScreenRatio_6
        }
    }
    
}
