//
//  WeiTouTiao.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/15.
//  Copyright © 2017年 hrscy. All rights reserved.
//
//
//  has_image = 1 image_list 可能有值，middle_image 可能有值，media_info
//  image_list 有值，middle_image 有值，large_image_list，没有值，media_info 有值
//  has_image = 0 image_list，large_image_list，media_info 都没有值，middle_image 可能有值
//
//  has_video = 1 large_image_list 有值，media_info 有值，middle_image 有值，video_detail_info 有值
//  has_video = 0
//
//


import UIKit

class WeiTouTiao {
    
    var relateNewsCellHeight: CGFloat? {
        let size = CGSize(width: screenWidth - 30 * 2, height: CGFloat(MAXFLOAT))
        return (title!.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil).size.height) + 30
    }
    
    var girlCellHeight: CGFloat? {
        return contentH! + 75 + screenWidth * 1.4
    }
    var large_image: WTTDetailVideoLargeImage?
    
    var imageCellHeight: CGFloat? {
        // imageHeight + titleH! + 10 + 40
        let imageHeight = screenWidth * 9.0 / 16.0 + titleH!
        return imageHeight + 50
    }
    
    var jokeCellHeight: CGFloat? {
        // 15 + 50 + 10 + contentH!
        return 75 + contentH!
    }
    
    var homeCellHeight: CGFloat? {
        var height: CGFloat = 0
        if titleH != nil {
            height += titleH!
        }
        let imageW = (screenWidth - 2 * kMargin - 2 * 6) / 3
        if let hasImage = has_image  {
            if hasImage { // 说明有图片
                if image_list.count > 0 {
                    if image_list.count == 1 {
                        let imageH = imageW * 0.8
                        return imageH
                    } else {
                        let imageH = imageW * 0.8
                        height += imageH
                    }
                } else {
                    if large_image_list.count > 0 {
                        let largeImageW = screenWidth - 2 * kMargin
                        let largeImageH = largeImageW * 0.8
                        height += largeImageH
                    } else if middle_image != nil { // 只有 middle_image 有值，则显示到右侧
                        let imageH = imageW * 0.8
                        return imageH
                    }
                }
            }
            
        } else if let hasVide = has_video {
            if hasVide { // 说明是视频
                if middle_image != nil { // 右侧小图
                    let imageH = imageW * 0.8
                    return imageH
                } else if video_detail_info != nil { // 相当于有大图
                    let largeImageW = screenWidth - 2 * kMargin
                    let largeImageH = largeImageW * 0.8
                    height += largeImageH
                }
            }
        } else {
            if thumb_image_list.count != 0 {
                // 1 or 2
                let imageWidth1or2 = (screenWidth - kMargin * 2 - 6) * 0.5
                // >= 3
                let imageH = (screenWidth - kMargin * 2 - 12) / 3
                switch thumb_image_list.count {
                case 1, 2:
                    height += imageWidth1or2
                case 3:
                    height += imageH
                case 4...6:
                    height += (imageH * 2 + 3)
                case 7...9:
                    height += (imageH * 3 + 6)
                default:
                    height += 0
                }
            }
        }
        // 12 是标题距离顶部的间距，40 是底部 view 的高度，7 是 标题距离中间 view 的间距
        return height + 12 + 40 + 7
    }
    
    ///  置顶
    var label: String?
    /// 过滤内容
    var filter_words = [WTTFilterWord]()
    
    var level: Int?
    
    var like_count: Int?
    var likeCount: String? {
        guard let count = like_count else {
            return "顶"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    var repin_count: Int? // 转发数量
    var repinCount: String? {
        guard let count = repin_count else {
            return ""
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    var digg_count: Int?
    var diggCount: String? {
        guard let count = digg_count else {
            return "顶"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    
    var bury_count: Int?
    var buryCount: String? {
        guard let count = bury_count else {
            return "踩"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    
    /// 评论数量
    var comment_count: Int?
    var commentCount: String? {
        guard let count = comment_count else {
            return "0"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    /// 阅读量
    var read_count: Int?
    var readCount: String? {
        guard let count = read_count else {
            return "0"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    var behot_time: TimeInterval?
    var create_time: TimeInterval?
    var publish_time: TimeInterval?
    var createTime: String? {
        //创建时间
        var createDate: Date?
        if let publicTime = publish_time {
            createDate = Date(timeIntervalSince1970: publicTime)
        } else if let createTime = create_time {
            createDate = Date(timeIntervalSince1970: createTime)
        } else {
            createDate = Date(timeIntervalSince1970: behot_time!)
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
    
    var cursor: Int?
    
    var default_text_line: Int?
    
    var cell_flag: Int?
    
    var cell_layout_style: Int?
    // 50 = 他们也在用头条
    // 0 = 三张小图，右边一张小图，
    //
    var cell_type: Int?
    
    var cell_ui_type: String?
    
    var follow: Int?
    
    var inner_ui_flag: Int?
    
    var is_stick: Bool?
    
    var image_list = [WTTImageList]()
    var large_image_list = [WTTLargeImageList]()
    var ugc_cut_image_list = [WTTUgcCutImageList]()
    var thumb_image_list = [WTTThumbImageList]()
    
    var ui_type: Int?
    
    var user: WTTUser?
    var user_info: WTTUser?
    
    var user_digg: Int?
    
    var user_repin: Int?
    
    var user_verified: Bool?
    
    var verified_content: String?
    
    var log_pb: LogPB?
    
    var max_text_line: Int?
    
    var rid: String?
    
    var schema: String?
    var share_count: Int?
    var share_url: String?
    
    var stick_style: Int?
    
    var comments: [AnyObject]?
    var content: NSString?
    var contentH: CGFloat? {
        guard let content = content else {
            return 0
        }
        let height = content.getTextHeight(width: screenWidth - kMargin * 2)
        return height
    }
    var contentHeight: CGFloat? { // 用户的 cell
        // 70 + contentHeight + 55  + 20 + 多加10
        guard let content = content else {
            return 0
        }
        let height = content.getTextHeight(width: screenWidth - kMargin * 2)
        return height + 155
    }
    
    var title: NSString?
    var titleH: CGFloat? {
        return title?.getTextHeight(width: screenWidth - kMargin * 2)
    }
    var newDetailTitleHeight: CGFloat? {
        let size = CGSize(width: screenWidth - 2 * kMargin, height: CGFloat(MAXFLOAT))
        return title?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil).size.height
    }
    
    var cellH: CGFloat? {
        var height: CGFloat = 0
        if content != nil {
            height += contentH!
        }
        if let videoDetailInfo = video_detail_info {
            let width = screenWidth - kMargin * 2
            let videoHeight = width * (videoDetailInfo.detail_video_large_image?.height)! / (videoDetailInfo.detail_video_large_image?.width)!
            height += videoHeight
        }
        if thumb_image_list.count != 0 {
            // 1 or 2
            let imageWidth1or2 = (screenWidth - kMargin * 2 - 6) * 0.5
            // >= 3
            let imageH = (screenWidth - kMargin * 2 - 12) / 3
            switch thumb_image_list.count {
            case 1, 2:
                height += imageWidth1or2
            case 3:
                height += imageH
            case 4...6:
                height += (imageH * 2 + 3)
            case 7...9:
                height += (imageH * 3 + 6)
            default:
                height += 0
            }
        }
        return CGFloat(50 + 58 + 30) + height
    }
    
    var position: WTTPosition?
    // -------------------  article  ---------------------
    var abstract: String?
    var actionExtra: WTTActionExtra?
    var aggr_type: Int?
    var article_sub_type: Int?
    var article_type: Int?
    var article_url: String?
    var display_url: String?
    var htmlStrng: String?
    
    var ban_comment: Int?
    
    var impr_id: String?
    var open_page_url: String?
    
    var group_flags: Int?
    var group_id: UInt64?
    var group_source: Int?
    var has_image: Bool?
    var has_video: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var hot: Bool?
    var is_subject: Bool?
    var item_id: UInt64?
    var item_version: Int?

    var middle_image: WTTMiddleImage?
    var media_info: WTTMediaInfo?
    var media_name: String?
    var preload_web: Int?
    var show_portrait: Bool?
    var show_portrait_article: Bool?
    
    var source: String?
    var source_icon_style: Int?
    var source_open_url: String?
    
    var open_url: String? // 如果是问答，会出现这个字段
    var params: [String: AnyObject]? // 问答的参数
    
    var tag: String? // ad=广告，news_car=汽车，video_music=视频，emotion=情感,news_psychology=
    var tag_id: Int?
    var tip: Int?
    var url: String?
    var show_tag: String? // 广告
    
    
    var video_detail_info: WTTVideoDetailInfo?
    var videoDuration: Int?
    var video_duration: String? {
        /// 格式化时间
        guard let duration = videoDuration else {
            return "00:00"
        }
        let hour = duration / 3600
        let minute = (duration / 60) % 60
        let second = duration % 60
        if hour > 0 {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String(format: "%02d:%02d", minute, second)
    }
    var video_id: String?
    var video_proportion_article: String?
    var video_source: String?
    var video_style: Int?
    
    var keywords: String?
    
    var gallery_pic_count: Int?
    var gallary_image_count: Int?
    
    /// 他们也在用
    var user_cards = [UserCard]()
    
    var show_more: String?
    var forward_count: Int?
    var forwardCount: String? {
        guard let count = forward_count else {
            return "转发"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    
    var has_more: Bool?
    
    init(dict: [String: AnyObject]) {
        
        has_more = dict["has_more"] as? Bool
        
        show_more = dict["show_more"] as? String
        
        if let forward_info = dict["forward_info"] {
            let forwardInfo = forward_info as! [String: AnyObject]
            forward_count = forwardInfo["forward_count"] as? Int
        }
        
        if let userCards = dict["user_cards"] {
            for item in userCards as! [AnyObject] {
                let userCard = UserCard(dict: item as! [String: AnyObject])
                user_cards.append(userCard)
            }
        }
 
        
        show_tag = dict["show_tag"] as? String
        
        impr_id = dict["impr_id"] as? String
        open_page_url = dict["open_page_url"] as? String
        
        if let largeImage = dict["large_image"] as? [String: AnyObject] {
            large_image = WTTDetailVideoLargeImage(dict: largeImage )
        }
        gallary_image_count = dict["gallary_image_count"] as? Int
        gallery_pic_count = dict["gallery_pic_count"] as? Int
        is_stick = dict["is_stick"] as? Bool
        label = dict["label"] as? String
        keywords = dict["keywords"] as? String
        
        videoDuration = dict["video_duration"] as? Int
        video_id = dict["video_id"] as? String
        video_proportion_article = dict["video_proportion_article"] as? String
        video_source = dict["video_source"] as? String
        video_style = dict["video_style"] as? Int
        
        url = dict["url"] as? String
        tip = dict["tip"] as? Int
        tag_id = dict["tag_id"] as? Int
        tag = dict["tag"] as? String
        source_open_url = dict["source_open_url"] as? String
        source_icon_style = dict["source_icon_style"] as? Int
        source = dict["source"] as? String
        if let src = source {
            if src == "悟空问答" {
                if let openURL = dict["open_url"] as? String {
                    open_url = openURL.removingPercentEncoding
                    open_url = open_url?.replacingOccurrences(of: "ansid", with: "\"ansid\"")
                    open_url = open_url?.replacingOccurrences(of: "&", with: ",")
                    open_url = open_url?.replacingOccurrences(of: "=", with: ":")
                    open_url = open_url?.replacingOccurrences(of: "api_param", with: "\"api_param\"")
                    open_url = open_url?.replacingOccurrences(of: "gd_ext_json", with: "\"gd_ext_json\"")
                    open_url = open_url?.replacingOccurrences(of: "qid", with: "\"qid\"")
                    open_url = open_url?.replacingOccurrences(of: "\"\"qid\"\"", with: "\"qid\"")
                    open_url = open_url?.replacingOccurrences(of: "\"\"ansid\"\"", with: "\"ansid\"")
                    open_url = open_url?.replacingOccurrences(of: "enter_\"ansid\"", with: "enter_ansid")
                    open_url = "{\(open_url!)"
                    open_url?.append("}")
                    if openURL.contains("sslocal://wenda_list?") {
                        open_url = open_url?.replacingOccurrences(of: "sslocal://wenda_list?", with: "")
                        let contentData: NSData = open_url!.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let param = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                            params = param as? [String: AnyObject]
                        } catch {
                        }
                    } else if openURL.contains("sslocal://wenda_detail?") {
                        open_url = open_url?.replacingOccurrences(of: "sslocal://wenda_detail?", with: "")
                        let contentData: NSData = open_url!.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let param = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                            params = param as? [String: AnyObject]
                            let gd_ext_json = param!["gd_ext_json"] as? [String: AnyObject]
                            params?["qid"] = gd_ext_json!["qid"] as AnyObject
                        } catch {
                        }
                    }
                }
            }
        }
        show_portrait_article = dict["show_portrait_article"] as? Bool
        show_portrait = dict["show_portrait"] as? Bool
        preload_web = dict["preload_web"] as? Int
        media_name = dict["media_name"] as? String
        
        if let mediaInfo = dict["media_info"] as? [String: AnyObject] {
            media_info = WTTMediaInfo(dict: mediaInfo)
        }
        if let imageList = dict["image_list"] as? [AnyObject] {
            for item in imageList {
                let image = WTTImageList(dict: item as! [String: AnyObject])
                image_list.append(image)
            }
        }
        if let middleImage = dict["middle_image"] as? [String: AnyObject] {
            middle_image = WTTMiddleImage(dict: middleImage)
        }
        if let videoDetailInfo = dict["video_detail_info"] as? [String: AnyObject] {
            video_detail_info = WTTVideoDetailInfo(dict: videoDetailInfo)
        }
        if let largeImageList = dict["large_image_list"] as? [AnyObject] {
            for item in largeImageList {
                let largeImage = WTTLargeImageList(dict: item as! [String: AnyObject])
                large_image_list.append(largeImage)
            }
        }
        
        if let thumbImageList = dict["thumb_image_list"] as? [AnyObject] {
            for item in thumbImageList {
                let thumbImage = WTTThumbImageList(dict: item as! [String: AnyObject])
                thumb_image_list.append(thumbImage)
            }
        }
        
        group_flags = dict["group_flags"] as? Int
        group_id = dict["group_id"] as? UInt64
        group_source = dict["group_source"] as? Int
        has_image = dict["has_image"] as? Bool
        has_video = dict["has_video"] as? Bool
        has_m3u8_video = dict["has_m3u8_video"] as? Bool
        has_mp4_video = dict["has_mp4_video"] as? Bool
        hot = dict["hot"] as? Bool
        is_subject = dict["is_subject"] as? Bool
        item_id = dict["item_id"] as? UInt64
        ban_comment = dict["ban_comment"] as? Int
        item_version = dict["item_version"] as? Int
        
        aggr_type = dict["aggr_type"] as? Int
        article_sub_type = dict["article_sub_type"] as? Int
        article_type = dict["article_type"] as? Int
        article_url = dict["article_url"] as? String
        display_url = dict["display_url"] as? String
        ban_comment = dict["ban_comment"] as? Int
        content = dict["content"] as? NSString
        abstract = dict["abstract"] as? String
        if let action_extra = dict["action_extra"] {
            let data = action_extra.data(using: String.Encoding.utf8.rawValue)! as Data
            let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            actionExtra = WTTActionExtra(dict: dict as! [String : AnyObject])
        }
        /// 遍历举报的内容
        if let filterWords = dict["filter_words"] as? [AnyObject] {
            for item in filterWords {
                let filterWord = WTTFilterWord(dict: item as! [String: AnyObject])
                filter_words.append(filterWord)
            }
        }
        level = dict["level"] as? Int
        like_count = dict["like_count"] as? Int
        repin_count = dict["repin_count"] as? Int
        digg_count = dict["digg_count"] as? Int
        bury_count = dict["bury_count"] as? Int
        read_count = dict["read_count"] as? Int
        comment_count = dict["comment_count"] as? Int
        behot_time = dict["behot_time"] as? TimeInterval
        create_time = dict["create_time"] as? TimeInterval
        publish_time = dict["publish_time"] as? TimeInterval
        cursor = dict["cursor"] as? Int
        default_text_line = dict["default_text_line"] as? Int
        cell_flag = dict["cell_flag"] as? Int
        cell_layout_style = dict["cell_layout_style"] as? Int
        cell_ui_type = dict["cell_ui_type"] as? String
        cell_type = dict["cell_type"] as? Int
        follow = dict["follow"] as? Int
        inner_ui_flag = dict["inner_ui_flag"] as? Int
        if let userTemp = dict["user"] as? [String : AnyObject]  {
            user = WTTUser(dict: userTemp)
        } else if let userInfoTemp = dict["user_info"] as? [String : AnyObject]  {
            user_info = WTTUser(dict: userInfoTemp)
        }
        user_digg = dict["user_digg"] as? Int
        user_verified = dict["user_verified"] as? Bool
        user_repin = dict["user_repin"] as? Int
        verified_content = dict["verified_content"] as? String
        if let logPb = dict["log_pb"] {
            log_pb = LogPB(dict: logPb as! [String : AnyObject])
        }
        if let positionDict = dict["position"] as? [String : AnyObject] {
            position = WTTPosition(dict: positionDict)
        }
        max_text_line = dict["max_text_line"] as? Int
        rid = dict["rid"] as? String
        schema = dict["schema"] as? String
        share_url = dict["share_url"] as? String
        share_count = dict["share_count"] as? Int
        stick_style = dict["user_id"] as? Int
        user_verified = dict["user_verified"] as? Bool
        title = dict["title"] as? NSString
        
    }
}

class WTTActionExtra {
    var channel_id: String?
    
    init(dict: [String: AnyObject]) {
        channel_id = dict["channel_id"] as? String
    }
}

class WTTPosition  {
    var position: String?
    
    init(dict: [String: AnyObject]) {
        position = dict["position"] as? String
    }
    
}

class WTTUser {
    
    var avatar_url: String?
    var desc: String?
    var description: String?
    var media_id: Int?
    var create_time: TimeInterval?
    var last_update: String?
    var type: Int?
    
    var is_following: Bool?
    var is_followed: Bool?
    var is_friend: Bool?
    
    var follower_count: Int?
    var follow: Int?
    
    var schema: String?
    var screen_name: String?
    var name: String?
    
    
    var userAuthInfo: WTTUserAuthInfo?
    var user_id: Int?
    var user_verified: Bool?
    
    // 问答
    var user_intro: String?
    var is_verify: Bool?
    var uname: String?
    
    init(dict: [String: AnyObject]) {
        uname = dict["uname"] as? String
        user_intro = dict["user_intro"] as? String
        type = dict["type"] as? Int
        last_update = dict["last_update"] as? String
        media_id = dict["media_id"] as? Int
        create_time = dict["create_time"] as? TimeInterval
        user_id = dict["user_id"] as? Int
        is_verify = dict["is_verify"] as? Bool
        user_verified = dict["user_verified"] as? Bool
        is_following = dict["is_following"] as? Bool
        is_followed = dict["is_followed"] as? Bool
        is_friend = dict["is_friend"] as? Bool
        follower_count = dict["follower_count"] as? Int
        follow = dict["follow"] as? Int
        avatar_url = dict["avatar_url"] as? String
        desc = dict["desc"] as? String
        description = dict["description"] as? String
        schema = dict["schema"] as? String
        screen_name = dict["screen_name"] as? String
        name = dict["name"] as? String
        
        if let user_auth_info = dict["user_auth_info"] {
            if user_auth_info as! String == "" {
                return
            }
            let data = user_auth_info.data(using: String.Encoding.utf8.rawValue)! as Data
            let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            userAuthInfo = WTTUserAuthInfo(dict: dict as! [String : AnyObject])
        }
    }
    
}

class WTTUserAuthInfo {
    
    var auth_type: Int?
    var auth_info: String?
    
    init(dict: [String: AnyObject]) {
        auth_type = dict["auth_type"] as? Int
        auth_info = dict["auth_info"] as? String
    }
}

class WTTMediaInfo {
    
    var avatar_url: String?
    var name: String?
    var media_id: Int?
    var user_verified: Int?
    var follow: Bool?
    
    var is_star_user: Bool?
    var recommend_reason: String?
    var recommend_type: Int?
    var user_id: Int?
    var verified_content: String?
    
    init(dict: [String: AnyObject]) {
        avatar_url = dict["avatar_url"] as? String
        name = dict["name"] as? String
        user_verified = dict["user_verified"] as? Int
        media_id = dict["media_id"] as? Int
        follow = dict["follow"] as? Bool
        is_star_user = dict["is_star_user"] as? Bool
        recommend_reason = dict["recommend_reason"] as? String
        verified_content = dict["verified_content"] as? String
        recommend_type = dict["recommend_type"] as? Int
        user_id = dict["user_id"] as? Int
    }
}

class WTTVideoDetailInfo {
    
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var videoWatchCount: String? {
        guard let count = video_watch_count else {
            return "0"
        }
        guard count >= 10000 else {
            return String(describing: count)
        }
        return String(format: "%.1f万", Float(count) / 10000.0)
    }
    
    var detail_video_large_image: WTTDetailVideoLargeImage?
    
    init(dict: [String: AnyObject]) {
        
        video_watching_count = dict["video_watching_count"] as? Int
        video_watch_count = dict["video_watch_count"] as? Int
        video_type = dict["video_type"] as? Int
        video_preloading_flag = dict["video_preloading_flag"] as? Bool
        video_id = dict["video_id"] as? String
        direct_play = dict["direct_play"] as? Int
        group_flags = dict["group_flags"] as? Int
        show_pgc_subscribe = dict["show_pgc_subscribe"] as? Int
        if let detailVideoLargeImage = dict["detail_video_large_image"] as? [String: AnyObject] {
            detail_video_large_image = WTTDetailVideoLargeImage(dict: detailVideoLargeImage)
        }
    }
}

class WTTDetailVideoLargeImage {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var url: String?
    
    var url_list = [WTTURLList]()
    
    init(dict: [String: AnyObject]) {
        
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}

class WTTMiddleImage {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var url: String?
    
    var url_list = [WTTURLList]()
    
    init(dict: [String: AnyObject]) {
        
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        if let urlString = dict["url"] as? String {
            if urlString.hasSuffix(".webp") {
                let index = urlString.index(urlString.endIndex, offsetBy: -5)
                url = urlString.substring(to: index)
            } else {
                url = urlString as String
            }
        }
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}

class WTTImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var url: String?
    
    var url_list = [WTTURLList]()
    
    init(dict: [String: AnyObject]) {
        type = dict["type"] as? Int
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        if let urlString = dict["url"] as? String {
            if urlString.hasSuffix(".webp") {
                let index = urlString.index(urlString.endIndex, offsetBy: -5)
                url = urlString.substring(to: index)
            } else {
                url = urlString as String
            }
        }
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}

class WTTUgcCutImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var uri: String?
    
    var url: String?
    
    var url_list = [WTTURLList]()
    
    init(dict: [String: AnyObject]) {
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        type = dict["type"] as? Int
        uri = dict["uri"] as? String
        url = dict["url"] as? String
        
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}

class WTTThumbImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var uri: String?
    
    var url: String?
    
    var url_list = [WTTURLList]()
    
    init(dict: [String: AnyObject]) {
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        type = dict["type"] as? Int
        uri = dict["uri"] as? String
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}


class WTTLargeImageList {
    
    var height: CGFloat?
    var width: CGFloat?
    
    var type: Int?
    
    var uri: String?
    
    var url: String?
    
    var url_list = [WTTURLList]()

    init(dict: [String: AnyObject]) {
        height = dict["height"] as? CGFloat
        width = dict["width"] as? CGFloat
        type = dict["type"] as? Int
        uri = dict["uri"] as? String
        url = dict["url"] as? String
        if let urllists = dict["url_list"] as? [AnyObject] {
            for urlDict in urllists {
                let wtrURLList = WTTURLList(dict: urlDict as! [String: AnyObject])
                url_list.append(wtrURLList)
            }
        }
    }
}

class LogPB {
    
    var impr_id: Int?
    
    init(dict: [String: AnyObject]) {
        impr_id = dict["impr_id"] as? Int
    }
}

class WTTURLList {
    
    var url: String?
    
    init(dict: [String: AnyObject]) {
        url = dict["url"]  as? String
    }
}

class WTTFilterWord {
    
    var id: String?
    
    var is_selected: Bool?
    
    var name: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"]  as? String
        is_selected = dict["is_selected"] as? Bool
        name = dict["name"] as? String
    }
}

class RealVideo {
    
    var status: Int?
    
    var user_id: String?
    
    var video_id: String?
    
    var validate: Int?
    
    var enable_ssl: Bool?
    
    var video_duration: Float?
    
    var video_list: [String: AnyObject]?
    
    var video_1: Video?  // 360p
    var video_2: Video?  // 480p
    var video_3: Video?  // 720p
    
    init(dict: [String: AnyObject]) {
        status = dict["status"]  as? Int
        user_id = dict["user_id"] as? String
        video_id = dict["video_id"] as? String
        validate = dict["validate"] as? Int
        enable_ssl = dict["enable_ssl"] as? Bool
        video_duration = dict["video_duration"] as? Float
        video_list = dict["video_list"] as? [String: AnyObject]
        if let viddeo1 = video_list!["video_1"] {
            video_1 = Video(dict: viddeo1 as! [String: AnyObject])
        }
        if let viddeo2 = video_list!["video_2"] {
            video_2 = Video(dict: viddeo2 as! [String: AnyObject])
        }
        if let viddeo3 = video_list!["video_3"] {
            video_3 = Video(dict: viddeo3 as! [String: AnyObject])
        }
    }
    
}

class Video {
    
    var preload_interval: Int?

    var preload_max_step: Int?

    var preload_min_step: Int?
    
    var preload_size: Int?
    
    var socket_buffer: Int?
    
    var user_video_proxy: Int?
    
    var vheight: Int?
    var vwidth: Int?
    
    var size: Int?
    
    var vtype: String?
    
    var main_url: String? /// 用 base 64 加密的视频真实地址
    var backup_url_1: String?
    
    init(dict: [String: AnyObject]) {
        preload_interval = dict["preload_interval"] as? Int
        preload_max_step = dict["preload_max_step"] as? Int
        preload_min_step = dict["preload_min_step"] as? Int
        preload_size = dict["preload_size"] as? Int
        socket_buffer = dict["socket_buffer"] as? Int
        user_video_proxy = dict["user_video_proxy"] as? Int
        socket_buffer = dict["socket_buffer"] as? Int
        vheight = dict["vheight"] as? Int
        vwidth = dict["vwidth"] as? Int
        size = dict["size"] as? Int
        vtype = dict["vtype"] as? String
        
        if let mainURL = dict["main_url"] {
            let decodeData = NSData(base64Encoded:mainURL as! String, options:NSData.Base64DecodingOptions(rawValue: 0))
            main_url = NSString(data: decodeData! as Data, encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}
