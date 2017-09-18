//
//  NewsDetail.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/3.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

/// 新闻详情界面中间 有新闻的标签或类别
/// 比如：情感，星座，天文...
class NewsDetailLabel {
    
    var word: String?
    
    var link: String?
    
    init(dict: [String: AnyObject]) {
        word = dict["word"] as? String
        link = dict["link"] as? String
    }
}

/// 用户是否喜欢 / 不喜欢
class UserLike {
    
    var user_like: Int?
    
    var like_num: Int?
    var likeNum: String? {
        get {
            guard let count = like_num else {
                return "喜欢"
            }
            guard count >= 10000 else {
                return String(describing: count)
            }
            return String(format: "%.1f万", Float(count) / 10000.0)
        }
    }
    
    init(dict: [String: AnyObject]) {
        if let userLike = dict["user_like"] {
            user_like = userLike as? Int
        }
        if let likeNum = dict["like_num"] {
            like_num = likeNum as? Int
        }
    }
}

/// 广告一般是 app 下载
/// 广告 app 信息
class NewsDetailAPPInfo {
    
    var log_extra: String?
    
    var open_url: String?
    
    var app_name: String?
    
    var url: String?
    
    /// 可能是 String / 字典
    var image: String?
    var appImage: AppImage?
    
    var rate: Int?
    
    var image_mode: Int?
    
    var appleid: String?
    
    var id: Int?
    
    var click_track_url: String?
    
    var title: String?
    
    var display_subtype: Int?
    
    var download_url: String?
    
    var label: String?
    
    var source: String?
    
    var type: String? // 例如 "web" "app"
    var track_url: String?
    var show_dislike: Int?
    var ad_id: Int?
    var description: String?
    var app_icon: String?
    var button_text: String? // "查看详情" "立即下载"
    var download_count: String?
    var os_type: String?
    var app_size: String?
    var filter_words = [WTTFilterWord]()
    var video_info: VideoInfo?
    
    /// mixed
    var source_name: String? // 例如 "京东 GY"
    var web_title: String?  // 例如 "好物钜惠【京东正品保障】GY 数据线"
    var image_height: Int?
    var image_width: Int?
    /// 可能三张图片
    var image_list = [WTTImageList]()
    
    init(dict: [String: AnyObject]) {
        
        if let imageList = dict["image_list"] as? [AnyObject] {
            for item in imageList {
                let image = WTTImageList(dict: item as! [String: AnyObject])
                image_list.append(image)
            }
        }
        if let webTitle = dict["web_title"] {
            web_title = webTitle as? String
        }
        if let sourceName = dict["source_name"] {
            source_name = sourceName as? String
        }
        if let appName = dict["app_name"] {
            app_name = appName as? String
        }
        if let descrip = dict["description"] {
            description = descrip as? String
        }
        os_type = dict["os_type"] as? String
        app_size = dict["app_size"] as? String
        ad_id = dict["ad_id"] as? Int
        description = dict["description"] as? String
        app_icon = dict["app_icon"] as? String
        button_text = dict["button_text"] as? String
        download_count = dict["download_count"] as? String
        
        /// 遍历举报的内容
        if let filterWords = dict["filter_words"] as? [AnyObject] {
            for item in filterWords {
                let filterWord = WTTFilterWord(dict: item as! [String: AnyObject])
                filter_words.append(filterWord)
            }
        }
        
        show_dislike = dict["show_dislike"] as? Int
        track_url = dict["track_url"] as? String
        type = dict["type"] as? String
        log_extra = dict["log_extra"] as? String
        open_url = dict["open_url"] as? String
        
        /// 对 image 做判断
        if let img = dict["image"] {
            if img is String {
                image = img as? String
            } else {
                appImage = AppImage(dict: img as! [String: AnyObject])
            }
        }
        rate = dict["rate"] as? Int
        image_mode = dict["image_mode"] as? Int
        appleid = dict["appleid"] as? String
        id = dict["id"] as? Int
        title = dict["title"] as? String
        display_subtype = dict["display_subtype"] as? Int
        download_url = dict["download_url"] as? String
        label = dict["label"] as? String
        source = dict["source"] as? String
        if let videoInfo = dict["video_info"] {
            video_info = VideoInfo(dict: videoInfo as! [String: AnyObject])
        }
    }
    
}

class VideoInfo {
    var video_id: String?
    var cover_url: String?
    var cover_uri: String?
    
    var width: Int?
    var height: Int?
    var video_duration: Int?
    var videoDuration: String? {
        /// 格式化时间
        let hour = video_duration! / 3600
        let minute = (video_duration! / 60) % 60
        let second = video_duration! % 60
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d", minute, second)
    }
    
    init(dict: [String: AnyObject]) {
        cover_uri = dict["cover_uri"] as? String
        width = dict["width"] as? Int
        height = dict["height"] as? Int
        video_id = dict["video_id"] as? String
        cover_url = dict["cover_url"] as? String
        video_duration = dict["video_duration"] as? Int
    }
}

class AppImage {
    
    var url: String?
    var uri: String?
    
    var width: Int?
    var height: Int?
    
    init(dict: [String: AnyObject]) {
        uri = dict["uri"] as? String
        width = dict["width"] as? Int
        height = dict["height"] as? Int
        if let url_list = dict["url_list"] as? [AnyObject] {
            let urlDict = url_list.first as! [String: AnyObject]
            url = urlDict["url"] as? String
        }
    }
}


class NewsDetailImage {
    
    var url: String?
    
    var width: Int?
    
    var height: Int?
    
    var rate: CGFloat = 1
    
    init(dict: [String: AnyObject]) {
        url = dict["url"] as? String
        height = dict["height"] as? Int
        width = dict["width"] as? Int
        rate = CGFloat(width!) / CGFloat(height!)
    }
}

class NewsDetailMediaInfo {
    
    var name: String?
    
    var avatarUrl: String?
    
    var openUrl: String?
    
    var id: Int?
    
    var user_id: Int?
    
    var like: Bool?
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as? String
        avatarUrl = dict["avatarUrl"] as? String
        openUrl = dict["openUrl"] as? String
        id = dict["id"] as? Int
        user_id = dict["user_id"] as? Int
        like = dict["like"] as? Bool
        
    }
}

class NewsDetailUserInfo {
    var name: String?
    
    var avatarUrl: String?
    
    var id: Int?
    
    var isPgc: Bool?
    
    var isOwner: Bool?
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as? String
        avatarUrl = dict["avatarUrl"] as? String
        id = dict["id"] as? Int
        isPgc = dict["isPgc"] as? Bool
        isOwner = dict["isOwner"] as? Bool
    }
}

class NewsDetailImageComment {
    
    var id: Int?
    
    var reply_count: Int?
    // 点赞数量
    var digg_count: Int?
    
    var reply_list = [AnyObject]()
    
    var create_time: TimeInterval?
    var createTime: String? {
        //创建时间
        var createDate: Date?
        if let createTime = create_time {
            createDate = Date(timeIntervalSince1970: createTime)
        }
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //当前时间
        let now = Date()
        //日历
        let calender = Calendar.current
        let comps: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: createDate!, to: now)
        guard (createDate?.isThisYear())! else { // 今年
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return fmt.string(from: createDate!)
        }
        if (createDate?.isYesterday())! { // 昨天
            fmt.dateFormat = "昨天 HH:mm";
            return fmt.string(from: createDate!)
        } else if (createDate?.isToday())! {
            if comps.hour! >= 1 {
                return String(format: "%.d小时前", comps.hour!)
            } else if comps.minute! >= 1 {
                return String(format: "%d分钟前", comps.minute!)
            } else {
                return "刚刚";
            }
        } else {
            fmt.dateFormat = "MM-dd HH:mm";
            return fmt.string(from: createDate!)
        }
    }
    
    var user_profile_image_url: String?
    var user_name: String?
    var user_id: Int?
    
    var text: String?
    var reply_to_comment: ReplyToComment?
    var commentText: NSString? {
        if let replaytoComment = reply_to_comment {
            let totalText = (text! as String) + "//@\(replaytoComment.user_name!)：" + (replaytoComment.text! as String)
            return totalText as NSString
        } else {
            return text! as NSString
        }
    }
    var textH: CGFloat? {
        return commentText?.getTextHeight(width: screenWidth - 15 - 57)
    }
    var is_following: Bool?
    
    var cellHeight: CGFloat? {
        /*
         let nameButtonTop: CGFloat = 12
         let nameButtonHeight: CGFloat = 16
         let nameButtonBotom: CGFloat = 10
         
         let replayButtonTop: CGFloat = 10
         let replayButtonHeight: CGFloat = 20
         let replayButtonBottom: CGFloat = 10
         */
        // 上面这些相加
        return textH! + 78
    }
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        reply_count = dict["reply_count"] as? Int
        digg_count = dict["digg_count"] as? Int
        create_time = dict["create_time"] as? TimeInterval
        user_profile_image_url = dict["user_profile_image_url"] as? String
        user_name = dict["user_name"] as? String
        user_id = dict["user_id"] as? Int
        if let replyToComment = dict["reply_to_comment"] {
            reply_to_comment = ReplyToComment(dict: replyToComment as! [String: AnyObject])
        }
        text = dict["text"] as? String
        is_following = dict["is_following"] as? Bool
    }
    /*
     "id": 1574780216208398,
     "text": "还负责解决生理需求，战队队员两天一换！技术好的留下",
     "reply_count": 0,
     "reply_list": [],
     "digg_count": 139,
     "bury_count": 0,
     "create_time": 1501827446,
     "score": 0.232821986079216,
     "user_id": 5498789331,
     "user_name": "憨比朝阳",
     "user_profile_image_url": "http://p1.pstatp.com/thumb/3795/3033762272",
     "user_verified": false,
     "is_following": 0,
     "is_followed": 0,
     "is_blocking": 0,
     "is_blocked": 0,
     "is_pgc_author": 0,
     "author_badge": [],
     "verified_reason": "",
     "user_bury": 0,
     "user_digg": 0,
     "user_relation": 0,
     "user_auth_info": "",
     "media_info": {
     "name": "",
     "avatar_url": ""
     }
     
     如果有回复就会出现下面的字段
     "reply_to_comment": {
         "id": 1574777650675725,
         "text": "跟ruru太后比不是一个档次，太后都是身价几亿的人了",
         "user_id": 51355537640,
         "user_name": "游戏王者玩家",
         "user_profile_image_url": "http://p3.pstatp.com/thumb/2c5d001d538c1c782a05",
         "user_verified": false,
         "is_pgc_author": 0,
         "is_following": 0,
         "is_followed": 0,
         "user_relation": 0
     }
     */
}

class ReplyToComment {
    var id: Int?
    
    var text: NSString?
    
    var user_profile_image_url: String?
    var user_name: String?
    var user_id: Int?
    
    var reply_to_comment: ReplyToComment?
    
    var is_following: Bool?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        text = dict["text"] as? NSString
        is_following = dict["is_following"] as? Bool
        user_profile_image_url = dict["user_profile_image_url"] as? String
        user_name = dict["user_name"] as? String
        user_id = dict["user_id"] as? Int
        
    }
}



