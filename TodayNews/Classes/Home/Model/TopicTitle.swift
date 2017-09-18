//
//  HomeTopTitle.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/17.
//  Copyright © 2017年 hrscy. All rights reserved.

import Foundation

class TopicTitle {

    var category: String?
    
    var tip_new: Int?
    
    var concern_id: String?
    
    var web_url: String?
    
    var icon_url: String?
    
    var flags: Int?
    
    var type: Int?
    
    var name: String?
    
    init(dict: [String: AnyObject]) {
        concern_id = dict["concern_id"] as? String
        category = dict["category"] as? String
        tip_new = dict["tip_new"] as? Int
        web_url = dict["web_url"] as? String
        icon_url = dict["icon_url"] as? String
        flags = dict["flags"] as? Int
        type = dict["type"] as? Int
        name = dict["name"] as? String
    }
}
