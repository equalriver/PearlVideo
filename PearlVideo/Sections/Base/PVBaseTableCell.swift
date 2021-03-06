//
//  PVBaseTableCell.swift


import UIKit

class PVBaseTableCell: UITableViewCell {
    
    public var isNeedSeparatorView = true {
        willSet{
            separatorView.isHidden = !newValue
        }
    }
    
    lazy var separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = kColor_deepBackground
        return v
    }()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = kColor_deepBackground
        contentView.backgroundColor = kColor_deepBackground
        selectionStyle = .none
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.width.bottom.centerX.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
