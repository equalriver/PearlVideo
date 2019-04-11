//
//  PVMeTeamVCChildView.swift
//  PearlVideo
//
//  Created by equalriver on 2019/4/9.
//  Copyright © 2019 equalriver. All rights reserved.
//

//MARK: -
class PVMeTeamCell: PVBaseTableCell {
    
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text_2
        l.textColor = kColor_text
        return l
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconIV)
        contentView.addSubview(nameLabel)
        iconIV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20 * KScreenRatio_6)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconIV.snp.right).offset(15 * KScreenRatio_6)
            make.right.equalToSuperview().offset(-20 * KScreenRatio_6)
        }
        //addShape
        let rect = CGRect.init(x: 0, y: 0, width: 40 * KScreenRatio_6, height: 40 * KScreenRatio_6)
        iconIV.ypj.addCornerShape(rect: rect, cornerRadius: 20 * KScreenRatio_6, fillColor: UIColor.white)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconIV.image = nil
        nameLabel.text = nil
    }
    
    
}


//MARK: - 认证popover
class PVMeTeamAuthPopoverCell: PVBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = kFont_text
        l.textColor = kColor_subText
        l.textAlignment = .center
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        selectionStyle = .default
        titleLabel.snp.makeConstraints { (make) in
            make.size.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.textColor = selected == true ? kColor_text : kColor_subText
    }
    
}
