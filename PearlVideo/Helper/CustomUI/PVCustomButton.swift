//


import Foundation

class TitleFrontButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard titleLabel != nil && imageView != nil else { return }
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (titleLabel?.width)!, bottom: 0, right: 0 - (titleLabel?.width)!)
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0 - (imageView?.width)!, bottom: 0, right: (imageView?.width)!)
        layoutIfNeeded()
    }
    
    
}


class ImageTopButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard titleLabel != nil && imageView != nil else { return }
        
        let totalHeight = titleLabel!.height + imageView!.height
        
        imageEdgeInsets = UIEdgeInsets.init(top: -(totalHeight - imageView!.height) - 1, left: 0, bottom: 0, right: -titleLabel!.width)
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView!.width, bottom: -(totalHeight - titleLabel!.height) - 1, right: 0)
        layoutIfNeeded()
    }
    
    
}
