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


//MARK: - fonts

///18, black
public let kFont_navi_weight = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)

///17, black
public let kFont_naviBtn_weight = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.black)

///18, semibold
public let kFont_btn_weight = UIFont.systemFont(ofSize: 18, weight: .semibold)

///15
public let kFont_text = UIFont.systemFont(ofSize: 15)

///15, semibold
public let kFont_text_weight = UIFont.systemFont(ofSize: 15, weight: .semibold)

///13
public let kFont_text_2 = UIFont.systemFont(ofSize: 13)

///13, semibold
public let kFont_text_2_weight = UIFont.systemFont(ofSize: 13, weight: .semibold)

///11
public let kFont_text_3 = UIFont.systemFont(ofSize: 11)

///11, semibold
public let kFont_text_3_weight = UIFont.systemFont(ofSize: 11, weight: .semibold)

///10
public let kFont_text_4 = UIFont.systemFont(ofSize: 10)

///10, semibold
public let kFont_text_4_weight = UIFont.systemFont(ofSize: 10, weight: .semibold)


//MARK: - colors
public var kColor_theme = UIColor.init(hexString: "#15151D") {
    willSet{
        NotificationCenter.default.post(.init(name: .kNotiName_themeColorChange))
    }
}

public let kColor_border = UIColor.init(hexString: "#dddddd")

public let kColor_dark = UIColor.init(hexString: "#000000")

public let kColor_text = UIColor.init(hexString: "#CCCCCC")

public let kColor_subText = UIColor.init(hexString: "#999999")

public let kColor_background = UIColor.init(hexString: "#15151D")

public let kColor_deepBackground = UIColor.init(hexString: "#0F0F17")

public let kColor_pink = UIColor.init(hexString: "#F43C60")

public let kColor_yellow = UIColor.init(hexString: "#FFC525")

public let kColor_blue = UIColor.init(hexString: "#55b6ed")

public let kColor_naviText = UIColor.init(hexString: "#ffffff")

public let kColor_naviBottomSepView = UIColor.init(hexString: "#dddddd")

public let kColor_separatorView = UIColor.init(hexString: "#dddddd")

public let kColor_emptyButton_border = UIColor.init(hexString: "#49a3f8")

public let kColor_analyze_orange = UIColor.init(hexString: "#ee7b5c")



//MARK: - text limit count
///签名字数限制
public let kSigningLimitCount = 32

///举报字数限制
public let kReportLimitCount = 100

///意见反馈图片限制
public let kFeedbackImageLimitCount = 6

///意见反馈内容限制
public let kFeedbackContentLimitCount = 30


//MARK: - 短视频相关
public let kPreviousCount = 2 //当前播放界面（player实例）之前的界面（player实例）保留个数，应对用户下滑秒开
public let kNextCount = 2 //当前播放界面（player实例）之后的界面（player实例）预加载的个数，应对用户上滑秒开
public let kMinPanSpeed: CGFloat = 30.0 //判断滑动的最小速度，小于这个数值，认定用户取消滑动
public let kPageCount = 10 //分页查询每次查询的个数
public let kCountLess_mustQurryMoreData = 3 //当前播放的视频，播放资源列表剩余的个数，如果小于这个数，则后台去请求最新的播放资源列表数据

public let defaultVidString = "6e783360c811449d8692b2117acc9212"
public let kCateID = "872354889"

public let kAnimationTime = 0.26 //滑动一个完整的视频需要的时间 - 秒

