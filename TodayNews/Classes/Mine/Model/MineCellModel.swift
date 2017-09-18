//
//  MineCell.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/14.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class MineCellModel {
    
    var grey_text: String?
    var text: String?
    var url: String?
    var key: String?
    var tip_new: Int?
    
    init(dict: [String: AnyObject]) {
        grey_text = dict["grey_text"] as? String
        text = dict["text"] as? String
        url = dict["url"] as? String
        key = dict["key"] as? String
        tip_new = dict["tip_new"] as? Int
        
    }
    
}

class MyConcern {
    
    var name: String?
    var url: String?
    
    var total_count: Int?
    var description: String?
    var time: String?
    var type: String?
    var icon: String?
    var userid: Int?
    var is_verify: Bool?
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as? String
        url = dict["url"] as? String
        total_count = dict["total_count"] as? Int
        description = dict["description"] as? String
        time = dict["time"] as? String
        type = dict["type"] as? String
        icon = dict["icon"] as? String
        is_verify = dict["is_verify"] as? Bool
        userid = dict["userid"] as? Int
    }
}

class FollowDetail {
    
    var common_friends: [AnyObject]?
    var star_chart: [String: AnyObject]?
    
    var is_followed: Bool?
    var article_limit_enable: Int?
    var is_following: Bool?
    var pgc_like_count: Int?
    var user_verified: Bool?
    var current_user_id: Int?
    var verified_agency: String?
    var top_tab = [TopTab]()
    var bottom_tab = [BottomTab]()
    
    var is_blocking: Bool?
    var user_id: Int?
    var area: String?
    var share_url: String?
    var show_private_letter: Int?
    var followers_count: Int?
    var followings_count: Int?
    var followersCount: String? {
        get {
            guard let count = followers_count else {
                return "0"
            }
            guard count >= 10000 else {
                return String(describing: count)
            }
            return String(format: "%.1f万", Float(count) / 10000.0)
        }
    }
    
    var followingsCount: String? {
        get {
            guard let count = followings_count else {
                return "0"
            }
            guard count >= 10000 else {
                return String(describing: count)
            }
            return String(format: "%.1f万", Float(count) / 10000.0)
        }
    }
    
    var status: Int?
    var media_id: Int?
    var description: NSString?
    var descriptionH: CGFloat? {
        get {
            let size = CGSize(width: screenWidth - 2 * kMargin, height: CGFloat(MAXFLOAT))
            return description!.boundingRect(with: size, options: .usesFontLeading, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil
            ).size.height
        }
    }
    
    var apply_auth_url: String?
    var bg_img_url: String?
    var verified_content: String?
    var screen_name: String?
    var visit_count_recent: Int?
    var is_blocked: Bool?
    var user_auth_info: UserAuthInfo?
    var name: String?
    var big_avatar_url: String?
    var gender: Int?
    var industry: String?
    var ugc_publish_media_id: Int?
    var avatar_url: String?
    
    init(dict: [String: AnyObject]) {
        article_limit_enable = dict["article_limit_enable"] as? Int
        is_followed = dict["is_followed"] as? Bool
        pgc_like_count = dict["pgc_like_count"] as? Int
        user_verified = dict["user_verified"] as? Bool
        current_user_id = dict["current_user_id"] as? Int
        is_following = dict["is_following"] as? Bool
        verified_agency = dict["verified_agency"] as? String
        for item in dict["top_tab"] as! [AnyObject] {
            let topTab = TopTab(dict: item as! [String : AnyObject])
            top_tab.append(topTab)
        }
        if let userAuthInfo = dict["user_auth_info"] {
            let data = userAuthInfo.data(using: String.Encoding.utf8.rawValue)! as Data
            let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if dict != nil {
                user_auth_info = UserAuthInfo(dict: dict as! [String : AnyObject])
            }
        }
        if let bottomTab = dict["bottom_tab"] {
            for item in bottomTab as! [AnyObject] {
                let bottomtab = BottomTab(dict: item as! [String : AnyObject])
                bottom_tab.append(bottomtab)
            }
        }
        is_blocking = dict["is_blocking"] as? Bool
        user_id = dict["user_id"] as? Int
        area = dict["area"] as? String
        share_url = dict["share_url"] as? String
        show_private_letter = dict["show_private_letter"] as? Int
        followers_count = dict["followers_count"] as? Int
        status = dict["status"] as? Int
        media_id = dict["media_id"] as? Int
        description = dict["description"] as? NSString
        apply_auth_url = dict["apply_auth_url"] as? String
        bg_img_url = dict["bg_img_url"] as? String
        verified_content = dict["verified_content"] as? String
        show_private_letter = dict["show_private_letter"] as? Int
        screen_name = dict["screen_name"] as? String
        visit_count_recent = dict["visit_count_recent"] as? Int
        is_blocked = dict["is_blocked"] as? Bool
        name = dict["name"] as? String
        bg_img_url = dict["bg_img_url"] as? String
        big_avatar_url = dict["big_avatar_url"] as? String
        gender = dict["gender"] as? Int
        industry = dict["industry"] as? String
        ugc_publish_media_id = dict["ugc_publish_media_id"] as? Int
        avatar_url = dict["avatar_url"] as? String
        followings_count = dict["followings_count"] as? Int
    }
}

class UserAuthInfo {
    var auth_type: Int?
    var auth_info: String?
    
    init(dict: [String: AnyObject]) {
        auth_type = dict["auth_type"] as? Int
        auth_info = dict["auth_info"] as? String
    }
    
    
}

class BottomTab {
    var name: String?
    var value: String?
    var children = [AnyObject]()
    var type: String?
    init(dict: [String: AnyObject]) {
        name = dict["name"] as? String
        type = dict["type"] as? String
        value = dict["value"] as? String
    }
}

class TopTab {
    
    var url: String?
    var is_default: Bool?
    var show_name: String?
    var type: String?
    
    init(dict: [String: AnyObject]) {
        url = dict["url"] as? String
        is_default = dict["is_default"] as? Bool
        show_name = dict["show_name"] as? String
        type = dict["type"] as? String
    }
}
