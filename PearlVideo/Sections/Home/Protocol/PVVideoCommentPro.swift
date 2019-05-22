//
//  PVHomeCommentPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//
import UITableView_FDTemplateLayoutCell
import ObjectMapper

extension PVVideoCommentView {
    
    func loadData(page: Int) {
        PVNetworkTool.Request(router: .videoCommentList(videoId: videoId, page: page * 10), success: { (resp) in
            if let d = Mapper<PVVideoCommentModel>().mapArray(JSONObject: resp["result"]["fansInfolist"].arrayObject) {
                if page == 0 { self.dataArr = d }
                else {
                    self.dataArr += d
                    if d.count == 0 { self.page -= 1 }
                }
                self.tableView.reloadData()
            }
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
            
        }
    }
    
    @objc func closeAction(sender: UIButton) {
        if commentInputView.inputTV.isFirstResponder {
            endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.ypj.viewAnimateDismissFromBottom(duration: 0.3, completion: { (isFinish) in
                    if isFinish {
                        self.removeFromSuperview()
                    }
                })
            }
            return
        }
        self.ypj.viewAnimateDismissFromBottom(duration: 0.3, completion: { (isFinish) in
            if isFinish {
                self.removeFromSuperview()
            }
        })
    }
    
}



//MARK: - table view delegate
extension PVVideoCommentView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVVideoCommentCell", cacheBy: indexPath, configuration: { (cell) in
            guard let c = cell as? PVVideoCommentCell else { return }
            c.data = self.dataArr[indexPath.row]
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVVideoCommentCell", for: indexPath) as! PVVideoCommentCell
        cell.delegate = self
        guard dataArr.count > indexPath.row else { return cell }
        cell.data = dataArr[indexPath.row]
        return cell
    }
    
}


//MARK: - cell delegate
extension PVVideoCommentView: PVVideoCommentCellDelegate {
    
    func didSelectedHeader(cell: PVVideoCommentCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if dataArr.count > indexPath.row {
                delegate?.didSelectedUser(id: dataArr[indexPath.row].userId)
            }
        }
    }
    
    func didSelectedLike(cell: PVVideoCommentCell, sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let indexPath = tableView.indexPath(for: cell) {
            if dataArr.count > indexPath.row {
                if sender.isSelected {
                    dataArr[indexPath.row].replyThumbCount += 1
                }
                else {
                    dataArr[indexPath.row].replyThumbCount -= 1
                }
                sender.setTitle("\(dataArr[indexPath.row].replyThumbCount)", for: .normal)
                let args: [String: Any] = ["videoId": dataArr[indexPath.row].videoId, "commentId": dataArr[indexPath.row].id, "action": sender.isSelected ? 1 : 2]
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeAction(args:)), object: args)
                self.perform(#selector(likeAction(args:)), with: args, afterDelay: 2)
                
            }
        }
    }
    
    @objc func likeAction(args: [String: Any]) {
        guard let videoId = args["videoId"] as? String else { return }
        guard let commentId = args["commentId"] as? Int else { return }
        guard let action = args["action"] as? Int else { return }
        delegate?.didSelectedLike(videoId: videoId, commentId: commentId, action: action)
    }
    
}

//MARK: - input view delegate
extension PVVideoCommentView: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        if textView.contentSize.height > textView.height && textView.contentSize.height <= 80 {
            let offsetY = textView.contentSize.height - textView.height
            commentInputView.origin.y -= offsetY
            commentInputView.height += offsetY
        }
    }
    
}
extension PVVideoCommentView: PVAttentionDetailCommentInputViewDelegate {
    
    func didSelectedDone(textView: YYTextView) {
        UIView.animate(withDuration: 0.25) {
            self.commentInputView.origin.y = kScreenHeight * 2 - 50 * KScreenRatio_6
            self.commentInputView.height = 50 * KScreenRatio_6
        }
    }
    
}