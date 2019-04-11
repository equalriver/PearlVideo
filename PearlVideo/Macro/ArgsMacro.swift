//
//  ArgsMacro.swift


import Foundation
import UIKit

///导航返回按钮tag
public let naviBackButtonTag = 9123

//table view states
public let loadingImageViewTag = 9201
public let emptyButtonTag = 9202
public let errorButtonTag = 9203
public let unloginButtonTag = 9204

//语音
public let speechViewTag = 9300



//corner raidus
public let kCornerRadius: CGFloat = 6


//fonts

///18, black
public let kFont_navi_weight = UIFont.systemFont(ofSize: 18 * KScreenRatio_6, weight: UIFont.Weight.black)

///17, black
public let kFont_naviBtn_weight = UIFont.systemFont(ofSize: 17 * KScreenRatio_6, weight: UIFont.Weight.black)

///18, semibold
public let kFont_btn_weight = UIFont.systemFont(ofSize: 18 * KScreenRatio_6, weight: .semibold)

///16
public let kFont_text = UIFont.systemFont(ofSize: 16 * KScreenRatio_6)

///16, semibold
public let kFont_text_weight = UIFont.systemFont(ofSize: 16 * KScreenRatio_6, weight: .semibold)

///14
public let kFont_text_2 = UIFont.systemFont(ofSize: 14 * KScreenRatio_6)

///14, semibold
public let kFont_text_2_weight = UIFont.systemFont(ofSize: 14 * KScreenRatio_6, weight: .semibold)

///12
public let kFont_text_3 = UIFont.systemFont(ofSize: 12 * KScreenRatio_6)

///12, semibold
public let kFont_text_3_weight = UIFont.systemFont(ofSize: 12 * KScreenRatio_6, weight: .semibold)

///10
public let kFont_text_4 = UIFont.systemFont(ofSize: 10 * KScreenRatio_6)

///10, semibold
public let kFont_text_4_weight = UIFont.systemFont(ofSize: 10 * KScreenRatio_6, weight: .semibold)


//colors
public var kColor_theme = UIColor.init(hexString: "#ffffff") {
    willSet{
        NotificationCenter.default.post(.init(name: .kNotiName_themeColorChange))
    }
}

public let kColor_border = UIColor.init(hexString: "#dddddd")

public let kColor_dark = UIColor.init(hexString: "#000000")

public let kColor_text = UIColor.init(hexString: "#333333")

public let kColor_subText = UIColor.init(hexString: "#666666")

public let kColor_background = UIColor.init(hexString: "#efefef")

public let kColor_highBackground = UIColor.init(hexString: "#dddddd")

public let kColor_pink = UIColor.init(hexString: "#e11379")

public let kColor_blue = UIColor.init(hexString: "#55b6ed")

public let kColor_naviText = UIColor.init(hexString: "#ffffff")

public let kColor_naviBottomSepView = UIColor.init(hexString: "#dddddd")

public let kColor_separatorView = UIColor.init(hexString: "#dddddd")

public let kColor_emptyButton_border = UIColor.init(hexString: "#49a3f8")

public let kColor_analyze_orange = UIColor.init(hexString: "#ee7b5c")



//text limit count
///签名字数限制
public let kSigningLimitCount = 32

///举报字数限制
public let kReportLimitCount = 100

///意见反馈图片限制
public let kFeedbackImageLimitCount = 6


///feedback image count
public let kFeedBackImageLimitCount = 3
