//
//  PVHomeCommentPro.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/11.
//  Copyright © 2019 equalriver. All rights reserved.
//

extension PVHomeCommentView {
    
    @objc func closeAction(sender: UIButton) {
        if commentInputView.inputTV.isFirstResponder {
            endEditing(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.ypj.viewAnimateDismissFromBottom(duration: 0.3, completion: { (isFinish) in
                    if isFinish {
                        self.isHidden = true
                        self.delegate?.didSelectedClose()
                    }
                })
            }
            return
        }
        self.ypj.viewAnimateDismissFromBottom(duration: 0.3, completion: { (isFinish) in
            if isFinish {
                self.isHidden = true
                self.delegate?.didSelectedClose()
            }
        })
    }
    
}



//MARK: - table view delegate
extension PVHomeCommentView: UITableViewDataSource, UITableViewDelegate {
    
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
extension PVHomeCommentView: PVAttentionCommentDetailHeaderDelegate {
    
    func didSelectedLike(sender: UIButton) {
        
    }
    
}

//MARK: - cell delegate
extension PVHomeCommentView: PVAttentionCommentDetailDelegate {
    
    func didSelectedHeader(cell: PVAttentionCommentDetailCell) {
        
    }
    
    func didSelectedLike(cell: PVAttentionCommentDetailCell, sender: UIButton) {
        
    }
    
}

//MARK: - input view delegate
extension PVHomeCommentView: YYTextViewDelegate {
    
    func textViewDidChange(_ textView: YYTextView) {
        if textView.contentSize.height > textView.height && textView.contentSize.height <= 80 {
            let offsetY = textView.contentSize.height - textView.height
            commentInputView.origin.y -= offsetY
            commentInputView.height += offsetY
        }
    }
    
}
extension PVHomeCommentView: PVAttentionDetailCommentInputViewDelegate {
    
    func didSelectedDone(textView: YYTextView) {
        UIView.animate(withDuration: 0.25) {
            self.commentInputView.origin.y = kScreenHeight * 2 - 50 * KScreenRatio_6
            self.commentInputView.height = 50 * KScreenRatio_6
        }
    }
    
}
