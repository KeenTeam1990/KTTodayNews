//
//  Question.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/19.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class QuestionAnswer {
    
    var question: Question? // 问题的内容
    
    var ans_list = [Answer]() // 回答的列表
    
    var offset: Int?
    
    var module_list = [ModuleList]() // 左下角的图标的内容

    var has_more: Bool?
    
    init(dict: [String: AnyObject]) {
        has_more = dict["has_more"] as? Bool
        offset = dict["offset"] as? Int
        if let moduleList = dict["module_list"] as? [AnyObject] {
            for item in moduleList {
                let module = ModuleList(dict: item as! [String: AnyObject])
                module_list.append(module)
            }
        }
        if let answerList = dict["ans_list"] as? [AnyObject] {
            for item in answerList {
                let answer = Answer(dict: item as! [String: AnyObject])
                ans_list.append(answer)
            }
        }
        if let question_ = dict["question"] as? [String: AnyObject] {
            question = Question(dict: question_)
        }
    }
}

class ModuleList {
    var day_icon_url: String?
    
    var text: String?
    
    var night_icon_url: String?
    
    var schema: String?
    
    
    init(dict: [String: AnyObject]) {
        text = dict["text"] as? String
        day_icon_url = dict["day_icon_url"] as? String
        night_icon_url = dict["night_icon_url"] as? String
        schema = dict["schema"] as? String
    }
}

class Question {
    var concern_tag_list = [ConcernTag]() // concern_tag_list
    
    var nice_ans_count: Int?
    var normal_ans_count: Int?
    var answer_count: Int? {
        return nice_ans_count! + normal_ans_count!
    }
    
    var follow_count: Int?
    var title: String?
    var is_follow: Bool?
    var create_time: TimeInterval?
    var can_edit: Bool?
    var show_delete: Bool?
    var has_more: Bool?
    var share_data: ShareData?
    var qid: Int?
    var ans_list = [Answer]()
    var user: WTTUser?
    var content: ContentAbstract?
    
    init(dict: [String: AnyObject]) {
        nice_ans_count = dict["nice_ans_count"] as? Int
        normal_ans_count = dict["normal_ans_count"] as? Int
        follow_count = dict["follow_count"] as? Int
        title = dict["title"] as? String
        is_follow = dict["is_follow"] as? Bool
        can_edit = dict["can_edit"] as? Bool
        show_delete = dict["show_delete"] as? Bool
        has_more = dict["has_more"] as? Bool
        create_time = dict["create_time"] as? TimeInterval
        qid = dict["qid"] as? Int
        if let shareData = dict["share_data"] as? [String: AnyObject] {
            share_data = ShareData(dict: shareData)
        }
        if let concernTagList = dict["concern_tag_list"] as? [AnyObject] {
            for item in concernTagList {
                let concernTag = ConcernTag(dict: item as! [String: AnyObject])
                concern_tag_list.append(concernTag)
            }
        }
        if let answerList = dict["ans_list"] as? [AnyObject] {
            for item in answerList {
                let answer = Answer(dict: item as! [String: AnyObject])
                ans_list.append(answer)
            }
        }
        if let userinfo = dict["user"] as? [String: AnyObject] {
            user = WTTUser(dict: userinfo)
        }
        if let contentD = dict["content"] as? [String: AnyObject] {
            content = ContentAbstract(dict: contentD)
        }
    }
}

class Answer {
    var text: String?
    
    var thumb_image_list = [WTTThumbImageList]()
    
    var share_url: String?
    
    var title: String?
    var digg_count: Int?
    var is_digg: Bool?
    var bury_count: Int?
    var is_buryed: Bool?
    var is_show_bury: Bool?
    
    var create_time: TimeInterval?
    var content_abstract: ContentAbstract?
    var user: WTTUser?
    var share_data: ShareData?
    
    var ans_url: String?
    var ansid: Int?
    
    init(dict: [String: AnyObject]) {
        ansid = dict["ansid"] as? Int
        ans_url = dict["ans_url"] as? String
        bury_count = dict["bury_count"] as? Int
        is_buryed = dict["is_buryed"] as? Bool
        is_show_bury = dict["is_show_bury"] as? Bool
        is_digg = dict["is_digg"] as? Bool
        digg_count = dict["digg_count"] as? Int
        create_time = dict["create_time"] as? TimeInterval
        if let contentAbstract = dict["content_abstract"] as? [String: AnyObject] {
            content_abstract = ContentAbstract(dict: contentAbstract)
        }
        if let userinfo = dict["user"] as? [String: AnyObject] {
            user = WTTUser(dict: userinfo)
        }
        if let shareData = dict["share_data"] as? [String: AnyObject] {
            share_data = ShareData(dict: shareData)
        }
    }
}

class ContentAbstract {
    var text: NSString?
    var textH: CGFloat? {
        return text!.getTextHeight(width: screenWidth - 30)
    }
    
    var thumb_image_list = [WTTThumbImageList]()
    
    init(dict: [String: AnyObject]) {
        text = dict["text"] as? NSString
        if let thumbImageList = dict["thumb_image_list"] as? [AnyObject] {
            for item in thumbImageList {
                let thumbImage = WTTThumbImageList(dict: item as! [String: AnyObject])
                thumb_image_list.append(thumbImage)
            }
        }
    }
}

class ShareData {
    
    var content: String?
    
    var image_url: String?
    
    var share_url: String?
    
    var title: String?
    
    init(dict: [String: AnyObject]) {
        content = dict["content"] as? String
        image_url = dict["image_url"] as? String
        share_url = dict["share_url"] as? String
        title = dict["title"] as? String
    }

}

class ConcernTag {
    
    var concern_id: Int?
    
    var name: String?
    
    var schema: String?
    
    init(dict: [String: AnyObject]) {
        concern_id = dict["concern_id"] as? Int
        name = dict["name"] as? String
        schema = dict["schema"] as? String
    }
}

