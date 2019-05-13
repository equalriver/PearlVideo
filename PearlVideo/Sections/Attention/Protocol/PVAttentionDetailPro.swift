//
//  PVAttentionDetailPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//
import MJRefresh

//MARK: - action
extension PVAttentionDetailVC {
    
    func setRefresh() {
        let footerRef = MJRefreshBackNormalFooter.init { [weak self] in
            self?.mainView.mj_footer.endRefreshing()
            self?.gotoCommentPage()
        }
        footerRef?.backgroundColor = kColor_background
        footerRef?.tintColor = kColor_subText
        footerRef?.setTitle("上拉加载评论", for: .idle)
        footerRef?.setTitle("上拉加载评论", for: .refreshing)
        mainView.mj_footer = footerRef
        
        let headerRef = MJRefreshNormalHeader.init { [weak self] in
            self?.commentTableView.mj_header.endRefreshing()
            self?.backToMainPage()
        }
        headerRef?.lastUpdatedTimeLabel.isHidden = true
        headerRef?.tintColor = kColor_subText
        headerRef?.setTitle("下拉返回详情", for: .idle)
        headerRef?.setTitle("下拉返回详情", for: .pulling)
        //        headerRef?.setTitle("加载中...", for: .refreshing)
        
        commentTableView.mj_header = headerRef
    }
    
    //上拉至评论页
    func gotoCommentPage() {
        UIView.animate(withDuration: 0.3) {
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: kScreenHeight), animated: true)
            self.naviBarView.backgroundColor = UIColor.white
        }
    }
    
    //下拉返回详情
    func backToMainPage() {
        UIView.animate(withDuration: 0.3) {
            self.contentScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            self.naviBarView.backgroundColor = UIColor.clear
        }
    }
}


//MARK: - 导航事件
extension PVAttentionDetailVC: PVAttentionDetailNaviDelegate {
    
    func didSelectedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectedLike(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
    func didSelectedShare() {
        
    }
    
    func didSelectedReport() {
        
    }
    
}

//MARK: - 主页
extension PVAttentionDetailVC: PVAttentionDetailMainViewDelegate {
    //点击头像
    func didClickHeader() {
        
    }
    
}


//MARK: - 评论 table view delegate
extension PVAttentionDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVAttentionDetailCommentCell", cacheBy: indexPath, configuration: { (cell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVAttentionDetailCommentCell", for: indexPath) as! PVAttentionDetailCommentCell
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - comment cell delegate
extension PVAttentionDetailVC: PVAttentionDetailCommentDelegate {
    
    func didSelectedLike(cell: PVAttentionDetailCommentCell, sender: UIButton) {
        guard let indexPath = commentTableView.indexPath(for: cell) else { return }
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            
        }
    }
    
    func didSelectedMoreComment(cell: PVAttentionDetailCommentCell) {
        guard let indexPath = commentTableView.indexPath(for: cell) else { return }
        let vc = PVAttentionCommentDetailVC()
        present(vc, animated: true, completion: nil)
    }
    
}


//MARK: - comment input view
extension PVAttentionDetailVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        if textView.contentSize.height > textView.height && textView.contentSize.height <= 80 {
            let offsetY = textView.contentSize.height - textView.height
            commentInputView.origin.y -= offsetY
            commentInputView.height += offsetY
        }
    }
 
}
extension PVAttentionDetailVC: PVAttentionDetailCommentInputViewDelegate {
    
    func didSelectedDone(textView: YYTextView) {
        UIView.animate(withDuration: 0.25) {
            self.commentInputView.origin.y = kScreenHeight * 2 - 50 * KScreenRatio_6
            self.commentInputView.height = 50 * KScreenRatio_6
        }
    }
    
}
