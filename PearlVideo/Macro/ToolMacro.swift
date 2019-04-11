//
//  ToolMacro.swift


import Foundation
import UIKit

public let kNavigationBarAndStatusHeight: CGFloat = UINavigationController().navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height

public let isIphoneXLatter = UIScreen.main.bounds.size.height >= 812 ? true : false

public let kIphoneXBottomInsetHeight: CGFloat = UIScreen.main.bounds.size.height >= 812 ? 20 : 0

public let kScreenWidth = UIScreen.main.bounds.size.width

public let kScreenHeight = UIScreen.main.bounds.size.height

public let KScreenRatio_6 = UIScreen.main.bounds.size.width/375.0

public let KScreenRatio_containX = UIScreen.main.bounds.size.height >= 812 ? 1.1 : UIScreen.main.bounds.size.width/375.0

public let kTabBarHeight: CGFloat = UIScreen.main.bounds.height >= 812 ? 83 : 49


public let navigationBarButtonHeight = 30 * KScreenRatio_6

public let navigationBarButtonWidth = 30 * KScreenRatio_6
