//
//  ConcernToutiaohao.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import Foundation

class ConcernToutiaohao {
    
    var id: Int?
    var name: String?
    var list = [SubConcern]()
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        for item in dict["list"] as! [AnyObject] {
            let subConcern = SubConcern(dict: item as! [String: AnyObject])
            list.append(subConcern)
        }
    }
}

class SubConcern {
    
    var subscribe_count: Int?
    var id: Int?
    var user_id: Int?
    var vip_level: Int?
    var media_id: Int?
    var name: String?
    var description: String?
    var auth_info: String?
    var is_subscribed: Bool?
    var icon: String?
    var type: String?
    var share_url: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        subscribe_count = dict["subscribe_count"] as? Int
        description = dict["description"] as? String
        user_id = dict["user_id"] as? Int
        vip_level = dict["vip_level"] as? Int
        media_id = dict["media_id"] as? Int
        is_subscribed = dict["is_subscribed"] as? Bool
        auth_info = dict["auth_info"] as? String
        icon = dict["icon"] as? String
        type = dict["type"] as? String
        share_url = dict["share_url"] as? String
    }
    
}
