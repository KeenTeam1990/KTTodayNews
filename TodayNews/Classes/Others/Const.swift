//
//  Const.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import AdSupport // 广告

enum CellType: Int {
    case normalCell = 0     // 一般的 cell
    case userCell = 32      // 带有用户的 cell
    case relationCell = 50  // 他们也在用头条
}

/// 屏幕的宽
let screenWidth = UIScreen.main.bounds.width
/// 屏幕的高
let screenHeight = UIScreen.main.bounds.height

/// iid 未登录用户 id，只要安装了今日头条就会生成一个 iid
/// 可以在自己的手机上安装一个今日头条，然后通过 charles 抓取一下这个 iid，
/// 替换成自己的，再进行测试
let IID: String = "5034850950"
/// iid 和 device_id 好像是绑定到一起的，不对应的话获取不到数据
let device_id: String = "6096495334"

let app_name = "news_article"

let channel = "App%20Store"

let device_platform = "iphone"
/// 当前时间
let date = Date()
let currentTimeInterval = UInt64(date.timeIntervalSince1970 * 1000)

let resolution = "\(screenWidth * 2)*\(screenHeight * 2)"
/// idfv
let idfv = UIDevice.current.identifierForVendor?.uuidString
/// 版本号
let versionCode = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
/// 系统版本号
let systemVersion = UIDevice.current.systemVersion
/// idfa
let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString


/// 服务器地址
//let BASE_URL = "http://lf.snssdk.com/"
//let BASE_URL = "http://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com/"

// 左右间距
let kMargin:CGFloat = 15.0
// 导航栏高度
let kNavBarHeight: CGFloat = 64.0
// 导航栏高度
let kTabBarHeight: CGFloat = 49.0
/// 首页新闻间距
let khomePageTitleHeight: CGFloat = 40.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0
/// 微头条界面 头部视图 的高度
let kWeiTouTiaoHeaderHieght: CGFloat = 45
/// 我的界面 头部视图 的高度
let kMineHeaderViewHieght: CGFloat = screenHeight * 0.4
/// 关注详情界面 头部视图 的高度
var kConcernHeaderViewHieght: CGFloat = 330


/// iPhone 5
let isIPhone5 = screenHeight == 568 ? true : false
/// iPhone 6
let isIPhone6 = screenHeight == 667 ? true : false
/// iPhone 6P
let isIPhone6P = screenHeight == 736 ? true : false

let isNight = "isNight"

let TabBarDidSelectedNotification = "TabBarDidSelectedNotification"






