//
//  UserCard.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/21.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import Foundation

class UserCard {
    
    var stats_place_holder: String?
    
    var recommend_reason: String?
    
    var recommend_type: Int?
    
    var user: CardUser?
    
    init(dict: [String: AnyObject]) {
        stats_place_holder = dict["stats_place_holder"] as? String
        recommend_reason = dict["recommend_reason"] as? String
        recommend_type = dict["recommend_type"] as? Int
        user = CardUser(dict: dict["user"] as! [String: AnyObject])
    }
}

class CardUser {
    
    var relation: CardUserRelation?
    
    var info: CardUserInfo?
    
    init(dict: [String: AnyObject]) {
        relation = CardUserRelation(dict: dict["relation"] as! [String: AnyObject])
        info = CardUserInfo(dict: dict["info"] as! [String: AnyObject])
    }
}

class CardUserInfo {
    var user_id: Int?
    
    var name: String?
    
    var avatar_url: String?
    
    var desc: String?
    
    var schema: String?
    
    var user_auth_info: CardUserAuthInfo?
    
    init(dict: [String: AnyObject]) {
        user_auth_info = CardUserAuthInfo(dict: dict["user_auth_info"] as! [String: AnyObject])
        user_id = dict["user_id"] as? Int
        name = dict["name"] as? String
        avatar_url = dict["avatar_url"] as? String
        desc = dict["desc"] as? String
        schema = dict["schema"] as? String
        
    }
}

class CardUserAuthInfo {
    var auth_type: String?
    
    var auth_info: String?
    
    init(dict: [String: AnyObject]) {
        auth_type = dict["auth_type"] as? String
        auth_info = dict["auth_info"] as? String
    }
}


class CardUserRelation {
    
    var stats_place_holder: String?
    
    var recommend_reason: String?
    
    var recommend_type: Int?
    
    init(dict: [String: AnyObject]) {
        
        stats_place_holder = dict["stats_place_holder"] as? String
        recommend_reason = dict["recommend_reason"] as? String
        recommend_type = dict["recommend_type"] as? Int
        
    }
}




