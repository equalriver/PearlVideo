//
//  PVAttentionCommentDetailPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/10.
//  Copyright © 2019 equalriver. All rights reserved.
//
import UITableView_FDTemplateLayoutCell

//MARK: - aciton
extension PVAttentionCommentDetailVC {
    
    @objc func dismissAction(sender: UIButton) {
        if commentInputView.inputTV.isFirstResponder {
            view.endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
}



//MARK: - table view delegate
extension PVAttentionCommentDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "PVAttentionCommentDetailCell", cacheBy: indexPath, configuration: { (cell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PVAttentionCommentDetailCell", for: indexPath) as! PVAttentionCommentDetailCell
        cell.delegate = self
        
        return cell
    }
    
}

//MARK: - header delegate
extension PVAttentionCommentDetailVC: PVAttentionCommentDetailHeaderDelegate {
    
    func didSelectedLike(sender: UIButton) {
        
    }
    
}

//MARK: - cell delegate
extension PVAttentionCommentDetailVC: PVAttentionCommentDetailDelegate {
    
    func didSelectedHeader(cell: PVAttentionCommentDetailCell) {
        
    }
    
    func didSelectedLike(cell: PVAttentionCommentDetailCell, sender: UIButton) {
        
    }
    
}

//MARK: - input view delegate
extension PVAttentionCommentDetailVC: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        if textView.contentSize.height > textView.height && textView.contentSize.height <= 80 {
            let offsetY = textView.contentSize.height - textView.height
            commentInputView.origin.y -= offsetY
            commentInputView.height += offsetY
        }
    }
    
}
extension PVAttentionCommentDetailVC: PVAttentionDetailCommentInputViewDelegate {
    
    func didSelectedDone(textView: YYTextView) {
        UIView.animate(withDuration: 0.25) {
            self.commentInputView.origin.y = kScreenHeight * 2 - 50 * KScreenRatio_6
            self.commentInputView.height = 50 * KScreenRatio_6
        }
    }
    
}
