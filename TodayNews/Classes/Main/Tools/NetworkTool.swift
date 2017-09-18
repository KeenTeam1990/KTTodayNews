//
//  NetworkTool.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/16.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol NetworkToolProtocol {
    /// -------------------------- 首 页 home -------------------------
    /// 获取首页顶部标题内容
    static func loadHomeTitlesData(fromViewController: String, completionHandler:@escaping (_ topTitles: [TopicTitle], _ homeTopicVCs: [TopicViewController])->())
    /// 获取首页顶部标题内容
    static func loadHomeTitlesData(completionHandler:@escaping (_ topTitles: [TopicTitle])->())
    /// 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ topTitles: [TopicTitle]) -> ())
    /// 搜索
    static func loadSearchResult(keyword: String, offset: Int, completionHandler:@escaping (_ weitoutiao: [WeiTouTiao]) -> ())
    /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
    static func loadHomeCategoryNewsFeed(category: String, completionHandler:@escaping (_ nowTime: TimeInterval,_ newsTopics: [WeiTouTiao])->())
    /// 获取一般新闻详情数据
    static func loadCommenNewsDetail(articleURL: String, completionHandler:@escaping (_ htmlString: String, _ images: [NewsDetailImage], _ abstracts: [String])->())
    /// 获取图片新闻详情数据
    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->())
    /// 获取图片新闻详情评论
    static func loadNewsDetailImageComments(offset: Int, item_id: UInt64, group_id: UInt64, completionHandler:@escaping (_ comments: [NewsDetailImageComment])->())
    /// 获取新闻详情评论
    static func loadNewsDetailComments(offset: Int, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ comments: [NewsDetailImageComment])->())
    /// 获取新闻详情相关新闻
    static func loadNewsDetailRelateNews(fromCategory: String, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ relateNews: [WeiTouTiao], _ labels: [NewsDetailLabel], _ userLike: UserLike?, _ appInfo: NewsDetailAPPInfo?, _ filter_wrods: [WTTFilterWord]) -> ())
    /// 解析视频的真实链接
    static func parseVideoRealURL(video_id: String, completionHandler:@escaping (_ realVideo: RealVideo)->())
    /// 获取头条号 关注
    static func loadEntryList(completionHandler:@escaping (_ concerns: [ConcernToutiaohao])->())
    /// 悟空问答
    static func loadQuestionAnswerList(topicTitle: TopicTitle, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ questionAnswer: QuestionAnswer)->())
    /// -------------------------- 视 频 video --------------------------
    /// 获取视频顶部标题内容
    static func loadVideoTitlesData(completionHandler:@escaping (_ videoTitles: [TopicTitle], _ videoTopicVCs: [VideoTopicController])->())
    // --------------------------  微  头  条  --------------------------
    /// 获取微头条数据
    static func loadWeiTouTiaoData(completionHandler: @escaping (_ weitoutiaos: [WeiTouTiao]) -> ())
    // --------------------------------- 我的 mine  ---------------------------------
    /// 我的界面 cell 数据
    static func loadMineCellData(completionHandler: @escaping (_ sectionsArray: [AnyObject])->())
    /// 我的关注
    static func loadMyFollow(completionHandler: @escaping (_ concerns: [MyConcern])->())
    /// 关注详情
    static func loadOneFollowDetail(userId: Int, completionHandler: @escaping (_ follewDetail: FollowDetail)->())
}

class NetworkTool: NetworkToolProtocol {

    /// -------------------------- 首 页 home -------------------------
    // MARK: - 获取首页顶部标题内容
    /// 获取首页顶部标题内容
    class func loadHomeTitlesData(fromViewController: String, completionHandler:@escaping (_ topTitles: [TopicTitle], _ homeTopicVCs: [TopicViewController])->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id as AnyObject ,
                      "aid": 13 as AnyObject,
                      "iid": IID as AnyObject] as [String : AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    var titles = [TopicTitle]()
                    var homeTopicVCs = [TopicViewController]()
                    // 添加推荐标题
                    let recommendDict = ["category": "", "name": "推荐"]
                    let recommend = TopicTitle(dict: recommendDict as [String : AnyObject])
                    titles.append(recommend)
                    // 添加控制器
                    let firstVC = TopicViewController()
                    firstVC.topicTitle = recommend
                    homeTopicVCs.append(firstVC)
                    for dict in data {
                        let topicTitle = TopicTitle(dict: dict as! [String: AnyObject])
                        titles.append(topicTitle)
                        let homeTopicVC = TopicViewController()
                        homeTopicVC.topicTitle = topicTitle
                        homeTopicVCs.append(homeTopicVC)
                    }
                    completionHandler(titles, homeTopicVCs)
                }
            }
        }
    }
    /// 获取首页顶部标题内容
    class func loadHomeTitlesData(completionHandler:@escaping (_ topTitles: [TopicTitle])->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id as AnyObject ,
                      "aid": 13 as AnyObject,
                      "iid": IID as AnyObject] as [String : AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    var titles = [TopicTitle]()
                    // 添加推荐标题
                    let recommendDict = ["category": "", "name": "推荐"]
                    let recommend = TopicTitle(dict: recommendDict as [String : AnyObject])
                    titles.append(recommend)
                    for dict in data {
                        let topicTitle = TopicTitle(dict: dict as! [String: AnyObject])
                        titles.append(topicTitle)
                        let homeTopicVC = TopicViewController()
                        homeTopicVC.topicTitle = topicTitle
                    }
                    completionHandler(titles)
                }
            }
        }
    }
    
    /// 点击首页加号按钮，获取频道推荐数据
    class func loadHomeCategoryRecommend(completionHandler:@escaping (_ topTitles: [TopicTitle]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.white)
        let url = BASE_URL + "article/category/get_extra/v1/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            SVProgressHUD.dismiss()
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    var titles = [TopicTitle]()
                    for dict in data {
                        let topicTitle = TopicTitle(dict: dict as! [String: AnyObject])
                        titles.append(topicTitle)
                    }
                    completionHandler(titles)
                }
            }
        }
    }
    
    /// 搜索
    class func loadSearchResult(keyword: String, offset: Int, completionHandler:@escaping (_ weitoutiao: [WeiTouTiao]) -> ()) {
        let url = BASE_URL + "api/2/wap/search_content/?"
        let params = ["device_id": device_id as AnyObject,
                      "keyword": keyword as AnyObject,
                      "from": "search_tab" as AnyObject,
                      "count": "10" as AnyObject,
                      "cur_tab": "1" as AnyObject,
                      "format": "json" as AnyObject,
                      "offset": offset as AnyObject,
                      "search_text": keyword as AnyObject] as [String: AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var weitoutiaos = [WeiTouTiao]()
                    for dict in data {
                        let weitoutiao = WeiTouTiao(dict: dict as! [String: AnyObject])
                        weitoutiaos.append(weitoutiao)
                    }
                    completionHandler(weitoutiaos)
                }
            }
        }
    }
    
    /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
    class func loadHomeCategoryNewsFeed(category: String, completionHandler:@escaping (_ nowTime: TimeInterval,_ newsTopics: [WeiTouTiao])->()) {
        let url = BASE_URL + "api/news/feed/v58/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "device_platform": "iphone",
                      "version_code": versionCode]
        let nowTime = NSDate().timeIntervalSince1970
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard let dataJSONs = json["data"].array else {
                    return
                }
                var topics = [WeiTouTiao]()
                for data in dataJSONs {
                    if let content = data["content"].string {
                        let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic = WeiTouTiao(dict: dict as! [String : AnyObject])
                            topics.append(topic)
                            print(dict)
                            print("-----------------------------")
                        } catch {
                            
                        }
                    }
                }
                completionHandler(nowTime, topics)
            }
        }
    }
    
    /// 获取一般新闻详情数据
    class func loadCommenNewsDetail(articleURL: String, completionHandler:@escaping (_ htmlString: String, _ images: [NewsDetailImage], _ abstracts: [String])->()) {
        // 测试数据
        Alamofire.request(articleURL).responseString { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                var images = [NewsDetailImage]()
                var abstracts = [String]()
                var htmlString = String()
                if value.contains("BASE_DATA.galleryInfo =") { // 则是图文详情
                    // 获取 图片链接数组
                    let startIndex = value.range(of: "\"sub_images\":")!.upperBound
                    let endIndex = value.range(of: ",\"max_img_width\"")!.lowerBound
                    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                    let BASE_DATA = value.substring(with: range)
                    let data = BASE_DATA.data(using: String.Encoding.utf8)! as Data
                    let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [AnyObject]
                    for image in dict! {
                        let img = NewsDetailImage(dict: image as! [String: AnyObject])
                        images.append(img)
                    }
                    // 获取 子标题
                    let titleStartIndex = value.range(of: "\"sub_abstracts\":")!.upperBound
                    let titlEndIndex = value.range(of: ",\"sub_titles\"")!.lowerBound
                    let titleRange = Range(uncheckedBounds: (lower: titleStartIndex, upper: titlEndIndex))
                    let sub_abstracts = value.substring(with: titleRange)
                    let titleData = sub_abstracts.data(using: String.Encoding.utf8)! as Data
                    let subAbstracts = try? JSONSerialization.jsonObject(with: titleData, options: .mutableContainers) as! [String]
                    for string in subAbstracts! {
                        abstracts.append(string)
                    }
                } else if value.contains("articleInfo: ") { // 一般的新闻
                    // 获取 新闻内容
                    let startIndex = value.range(of: "content: '")!.upperBound
                    let endIndex = value.range(of: "'.replace")!.lowerBound
                    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                    let content = value.substring(with: range)
                    let contentDecode = NetworkTool.htmlDecode(content: content)
                    /// 创建 html
                    var html = "<!DOCTYPE html>"
                        html += "<html>"
                        html += "<head>"
                        html += "<meta charset=utf-8>"
                        html += "<link rel=\"stylesheet\" type=\"text/css\" href=\"news.css\" />\n"
                        html += "</head>"
                        html += "<body>"
                        html += contentDecode
                        html += "</body>"
                        html += "</html>"
                    htmlString = html
                } else { // 第三方的新闻内容
                    /// 这部分显示还有问题
                    htmlString = value
                }
                completionHandler(htmlString, images, abstracts)
            }
        }
    }
    /// 转义字符
    class func htmlDecode(content: String) -> String {
        var s = String()
        s = content.replacingOccurrences(of: "&amp;", with: "&")
        s = s.replacingOccurrences(of: "&lt;", with: "<")
        s = s.replacingOccurrences(of: "&gt;", with: ">")
        s = s.replacingOccurrences(of: "&nbsp;", with: " ")
        s = s.replacingOccurrences(of: "&#39;", with: "\'")
        s = s.replacingOccurrences(of: "&quot;", with: "\"")
        s = s.replacingOccurrences(of: "<br>", with: "\n")
        return s
    }
    
    /// 获取图片新闻详情数据
    class func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->()) {
        // 测试数据
//        http://toutiao.com/item/6450211121520443918/
        let url = "http://www.toutiao.com/a6450237670911852814/#p=1"
        
        Alamofire.request(url).responseString { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                if value.contains("BASE_DATA.galleryInfo =") {
                    // 获取 图片链接数组
                    let startIndex = value.range(of: "\"sub_images\":")!.upperBound
                    let endIndex = value.range(of: ",\"max_img_width\"")!.lowerBound
                    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                    let BASE_DATA = value.substring(with: range)
                    let data = BASE_DATA.data(using: String.Encoding.utf8)! as Data
                    let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [AnyObject]
                    var images = [NewsDetailImage]()
                    for image in dict! {
                        let img = NewsDetailImage(dict: image as! [String: AnyObject])
                        images.append(img)
                    }
                    // 获取 子标题
                    let titleStartIndex = value.range(of: "\"sub_abstracts\":")!.upperBound
                    let titlEndIndex = value.range(of: ",\"sub_titles\"")!.lowerBound
                    let titleRange = Range(uncheckedBounds: (lower: titleStartIndex, upper: titlEndIndex))
                    let sub_abstracts = value.substring(with: titleRange)
                    let titleData = sub_abstracts.data(using: String.Encoding.utf8)! as Data
                    let subAbstracts = try? JSONSerialization.jsonObject(with: titleData, options: .mutableContainers) as! [String]
                    var abstracts = [String]()
                    for string in subAbstracts! {
                        abstracts.append(string)
                    }
                    completionHandler(images, abstracts)
                }
            }
        }
    }
    
    /// 获取图片新闻详情评论
    class func loadNewsDetailImageComments(offset: Int, item_id: UInt64, group_id: UInt64, completionHandler:@escaping (_ comments: [NewsDetailImageComment])->()) {
        let url = BASE_URL + "article/v2/tab_comments/?"
        let params = ["offset": offset as AnyObject,
                      "item_id": item_id as AnyObject,
                      "group_id": group_id as AnyObject] as [String : AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var comments = [NewsDetailImageComment]()
                    for dict in data {
                        let commentDict = dict as! [String: AnyObject]
                        let comment = NewsDetailImageComment(dict: commentDict["comment"] as! [String : AnyObject])
                        comments.append(comment)
                    }
                    completionHandler(comments)
                }
            }
        }
    }
    
    /// 获取新闻详情评论
    class func loadNewsDetailComments(offset: Int, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ comments: [NewsDetailImageComment])->()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = BASE_URL + "article/v2/tab_comments/?"
        var item_id = ""
        var group_id = ""
        if let itemId = weitoutiao.item_id {
            item_id = "\(itemId)"
        }
        if let groupId = weitoutiao.group_id {
            group_id = "\(groupId)"
        }
        let params = ["offset": offset as AnyObject,
                      "item_id": item_id as AnyObject,
                      "group_id": group_id as AnyObject] as [String : AnyObject]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var comments = [NewsDetailImageComment]()
                    for dict in data {
                        let commentDict = dict as! [String: AnyObject]
                        let comment = NewsDetailImageComment(dict: commentDict["comment"] as! [String : AnyObject])
                        comments.append(comment)
                        
                    }
                    completionHandler(comments)
                }
            }
        }
    }
    
    /// 获取新闻详情相关新闻
    class func loadNewsDetailRelateNews(fromCategory: String, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ relateNews: [WeiTouTiao], _ labels: [NewsDetailLabel], _ userLike: UserLike?, _ appInfo: NewsDetailAPPInfo?, _ filter_wrods: [WTTFilterWord]) -> ()) {
        let url = BASE_URL + "2/article/information/v21/?"
        // version_code=6.2.6
        let article_page = weitoutiao.has_video! ? 1 : 0
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let params = ["device_id": device_id as AnyObject,
                      "version_code": version as AnyObject,
                      "article_page": article_page as AnyObject,
                      "aggr_type": weitoutiao.aggr_type! as AnyObject,
                      "latitude": "" as AnyObject,
                      "longitude": "" as AnyObject,
                      "iid": IID as AnyObject,
                      "item_id": weitoutiao.item_id! as AnyObject,
                      "group_id": weitoutiao.group_id! as AnyObject,
                      "device_platform": "iphone" as AnyObject,
                      "from_category": fromCategory as AnyObject] as [String : AnyObject]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].dictionary {
                    var relateNews = [WeiTouTiao]()
                    var labels = [NewsDetailLabel]()
                    var userLike: UserLike?
                    var appInfo: NewsDetailAPPInfo?
                    var filter_words = [WTTFilterWord]()
                    if let relatedVideoToutiao = data["related_video_toutiao"] {
                        for dict in relatedVideoToutiao.arrayObject! {
                            let news = WeiTouTiao(dict: dict as! [String: AnyObject])
                            relateNews.append(news)
                        }
                    } else if let ordered_info = data["ordered_info"] {
                        // ordered_info 对应新闻详情顶部的 新闻类别按钮，新欢，不喜欢按钮，app 广告， 相关新闻
                        // ordered_info是一个数组，数组内容不定，根据其中的 name 来判断对应的字典
                        if ordered_info.count > 0 { // 说明 ordered_info 有数据
                            for orderInfo in ordered_info.arrayObject! { // 遍历，根据 name 来判断
                                let ordered = orderInfo as! [String: AnyObject]
                                let name = ordered["name"]! as! String
                                if name == "labels" { // 新闻相关类别,数组
                                    if let orders = ordered["data"] as? [AnyObject] {
                                        for dict in orders {
                                            let label = NewsDetailLabel(dict: dict as! [String: AnyObject])
                                            labels.append(label)
                                        }
                                    }
                                } else if name == "like_and_rewards" { // 喜欢 / 不喜欢  字典
                                    userLike = UserLike(dict: ordered["data"] as! [String: AnyObject])
                                } else if name == "ad" { // 广告， 字典
                                    let appData = ordered["data"] as! [String: AnyObject]
                                    // 有两种情况，一种 app，一种 mixed
                                    if let app = appData["app"] {
                                        appInfo = NewsDetailAPPInfo(dict: app as! [String: AnyObject])
                                    } else if let mixed = appData["mixed"] {
                                        appInfo = NewsDetailAPPInfo(dict: mixed as! [String: AnyObject])
                                    }
                                } else if name == "related_news" { // 相关新闻  数组
                                    if let orders = ordered["data"] as? [AnyObject] {
                                        for dict in orders {
                                            let relatenews = WeiTouTiao(dict: dict as! [String: AnyObject])
                                            relateNews.append(relatenews)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    if let filterWords = data["filter_words"]?.arrayObject {
                        for item in filterWords {
                            let filterWord = WTTFilterWord(dict: item as! [String: AnyObject])
                            filter_words.append(filterWord)
                        }
                    }
                    completionHandler(relateNews, labels, userLike, appInfo, filter_words)
                }
            }
        }
    }
    
    // 获取今日头条的视频真实链接可参考下面的博客
    // http://blog.csdn.net/dianliang01/article/details/73163086
    /// 解析视频的真实链接
    class func parseVideoRealURL(video_id: String, completionHandler:@escaping (_ realVideo: RealVideo)->()) {
        let r = arc4random() // 随机数
        let url: NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
        let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        var crc32: UInt64 = UInt64(data.getCRC32()) // 使用 crc32 校验
        if crc32 < 0 { // crc32 的值可能为负数
            crc32 += 0x100000000
        }
        // 拼接
        let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
        Alamofire.request(realURL).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dict = json["data"].dictionaryObject
                let video = RealVideo(dict: dict! as [String : AnyObject])
                completionHandler(video)
            }
        }
    }
    
    /// 获取头条号 关注
    class func loadEntryList(completionHandler:@escaping (_ concerns: [ConcernToutiaohao])->()) {
        let url = BASE_URL + "entry/list/v1/?"
        let params = ["device_id": device_id,
                      "iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var concerns = [ConcernToutiaohao]()
                    for item in data {
                        let concern = ConcernToutiaohao(dict: item as! [String : AnyObject])
                        concerns.append(concern)
                    }
                    completionHandler(concerns)
                }
            }
        }
    }
    
    /// 悟空问答
    class func loadQuestionAnswerList(topicTitle: TopicTitle, weitoutiao: WeiTouTiao, completionHandler:@escaping (_ questionAnswer: QuestionAnswer)->()) {
        let url = BASE_URL + "wenda/v1/question/brow/"
        Alamofire.request(url, method: .post, parameters: weitoutiao.params!).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let question = QuestionAnswer(dict: json.dictionaryObject! as [String : AnyObject])
                completionHandler(question)
            }
        }
    }
    
    /// -------------------------- 视 频 video --------------------------
    
    /// 获取视频顶部标题内容
    class func loadVideoTitlesData(completionHandler:@escaping (_ videoTitles: [TopicTitle], _ videoTopicVCs: [VideoTopicController])->()) {
        let url = BASE_URL + "video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var titles = [TopicTitle]()
                    var videoTopicVCs = [VideoTopicController]()
                    // 添加推荐标题
                    let recommendDict = ["category": "video", "name": "推荐"]
                    let recommend = TopicTitle(dict: recommendDict as [String : AnyObject])
                    titles.append(recommend)
                    // 添加控制器
                    let firstVC = VideoTopicController()
                    firstVC.videoTitle = recommend
                    videoTopicVCs.append(firstVC)
                    for dict in data {
                        let title = TopicTitle(dict: dict as! [String: AnyObject])
                        let videoTopicVC = VideoTopicController()
                        videoTopicVC.videoTitle = title
                        videoTopicVCs.append(videoTopicVC)
                        titles.append(title)
                    }
                    completionHandler(titles, videoTopicVCs)
                }
            }
        }
    }
    
    // --------------------------  微  头  条  --------------------------
    
    /// 获取微头条数据
    class func loadWeiTouTiaoData(completionHandler: @escaping (_ weitoutiaos: [WeiTouTiao]) -> ()) {
        let url = BASE_URL + "api/news/feed/v54/?"
        let params = ["iid": IID,
                      "category": "weitoutiao",
                      "count": 20,
                      "device_id": device_id] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                guard let dataJSONs = json["data"].array else {
                    return
                }
                var weitoutiaos = [WeiTouTiao]()
                for dataJSON in dataJSONs {
                    if let content = dataJSON["content"].string {
                        let data = content.data(using: String.Encoding.utf8)! as Data
                        let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        let weitoutiao = WeiTouTiao(dict: dict as! [String : AnyObject])
                        weitoutiaos.append(weitoutiao)
                    }
                }
                completionHandler(weitoutiaos)
            }
        }
    }
    
    /// 点击了关注按钮
    class func loadFollowInfo(user_id: Int, completionHandler: @escaping (_ isFllowing: Bool)->()) {
        let url = BASE_URL + "2/relation/follow/v2/?"
        let params = ["iid": IID,
                      "user_id": user_id,
                      "device_id": device_id] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                guard let data = json["data"].dictionary else {
                    return
                }
                guard data["description"]?.string == "关注成功" else {
                    return
                }
                if let user = data["user"]?.dictionaryObject {
                    let user_info = WTTUser(dict: user as [String : AnyObject])
                    completionHandler(user_info.is_following!)
                }
            }
        }
        
    }
    
    /// 点击了取消关注按钮
    class func loadUnfollowInfo(user_id: Int, completionHandler: @escaping (_ isFllowing: Bool)->()) {
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["iid": IID,
                      "user_id": user_id,
                      "device_id": device_id] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                guard let data = json["data"].dictionary else {
                    return
                }
                if let user = data["user"]?.dictionaryObject {
                    let user_info = WTTUser(dict: user as [String : AnyObject])
                    completionHandler(user_info.is_following!)
                }
            }
        }
        
    }
    
    // --------------------------------- 我的 mine  ---------------------------------
    /// 我的界面 cell 数据
    class func loadMineCellData(completionHandler: @escaping (_ sectionsArray: [AnyObject])->()) {
        let url = BASE_URL + "user/tab/tabs/?"
        let params = ["iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.arrayObject {
                        var sectionArray = [AnyObject]()
                        for section in sections {
                            var rows = [MineCellModel]()
                            for row in section as! [AnyObject] {
                                let mineCell = MineCellModel(dict: row as! [String : AnyObject])
                                rows.append(mineCell)
                            }
                            sectionArray.append(rows as AnyObject)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    
    /// 我的关注 
    class func loadMyFollow(completionHandler: @escaping (_ concerns: [MyConcern])->()) {
        let url = BASE_URL + "concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    var concerns = [MyConcern]()
                    for data in datas {
                        let myConcern = MyConcern(dict: data as! [String: AnyObject])
                        concerns.append(myConcern)
                    }
                    
                    completionHandler(concerns)
                }
            }
        }
    }
    
    /// 关注详情
    class func loadOneFollowDetail(userId: Int, completionHandler: @escaping (_ follewDetail: FollowDetail)->()) {
        let url = BASE_URL + "user/profile/homepage/v3/?"
        let params = ["user_id": userId] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                let followDetail = FollowDetail(dict: json["data"].dictionaryObject! as [String : AnyObject])
                completionHandler(followDetail)
            }
        }
    }
}
