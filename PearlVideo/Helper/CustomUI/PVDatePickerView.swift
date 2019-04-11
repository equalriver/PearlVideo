//
//  PVDatePickerView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/3.
//  Copyright © 2019 equalriver. All rights reserved.
//

import Foundation

class PVDatePickerView: UIView {
    
    typealias callback = (_ date: String) -> Void
    
    var handle: callback
    
    var date = ""
    
    lazy var contentView: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: 250 * KScreenRatio_6))
        v.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer.init(actionBlock: { (ac) in
            
        })
        v.addGestureRecognizer(tap)
        return v
    }()
    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker.init()
        dp.backgroundColor = UIColor.white
        dp.datePickerMode = .dateAndTime
        dp.locale = .init(identifier: "zh")
        dp.setDate(Date(), animated: true)
        dp.addTarget(self, action: #selector(dateChange(sender:)), for: .valueChanged)
        return dp
    }()
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    lazy var cancelBtn: UIButton = {
        let b = UIButton()
        b.setTitle("取消", for: .normal)
        b.setTitleColor(kColor_text, for: .normal)
        b.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        return b
    }()
    lazy var confirmBtn: UIButton = {
        let b = UIButton()
        b.setTitle("确定", for: .normal)
        b.setTitleColor(kColor_text, for: .normal)
        b.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        return b
    }()
    
    //
    required init(frame: CGRect, dateFormat: String?, handle: @escaping callback)  {
        self.handle = handle
        super.init(frame: frame)
        dateFormatter.dateFormat = dateFormat ?? "yyyy-MM-dd"
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        
        addSubview(contentView)
        contentView.addSubview(datePicker)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(confirmBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.top.left.equalTo(contentView)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.right.top.equalTo(contentView)
        }
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.bottom)
            make.width.centerX.bottom.equalTo(contentView)
        }
        
        let tap = UITapGestureRecognizer.init {[weak self] (ac) in
            self?.removeFromSuperview()
        }
        self.addGestureRecognizer(tap)
        
        contentView.ypj.viewAnimateComeFromBottom(duration: 0.3) { (isFinished) in
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //action
    @objc func dateChange(sender: UIDatePicker) {
        date = dateFormatter.string(from: sender.date)
    }
    
    @objc func cancelAction(sender: UIButton){
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.3) { (isFinished) in
            if isFinished { self.removeFromSuperview() }
        }
    }
    
    @objc func confirmAction(sender: UIButton){
        date = dateFormatter.string(from: datePicker.date)
        handle(date)
        contentView.ypj.viewAnimateDismissFromBottom(duration: 0.3) { (isFinished) in
            if isFinished { self.removeFromSuperview() }
        }
    }
    
}














