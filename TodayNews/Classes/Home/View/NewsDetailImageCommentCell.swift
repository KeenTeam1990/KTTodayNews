//
//  NewsDetailImageCommentCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/5.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class NewsDetailImageCommentCell: UITableViewCell {
    
    var isAuthor: Bool? {
        didSet {
            authorLabel.isHidden = !isAuthor!
        }
    }
    
    var comment: NewsDetailImageComment? {
        didSet {
            if let userProfileImageUrl = comment!.user_profile_image_url {
                avatarButton.kf.setImage(with: URL(string: userProfileImageUrl), for: .normal)
            }
            if let userName = comment!.user_name {
                nameLabel.setTitle(userName, for: .normal)
            }
            if comment!.is_following! {
                likeButton.setTitle(String(comment!.digg_count!), for: .selected)
            } else {
                likeButton.setTitle(String(comment!.digg_count!), for: .normal)
            }
            if let replayToComment = comment!.reply_to_comment {
                let replayCommentAttributeString = NSAttributedString(string: replayToComment.text! as String, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
                
                let nameAttributeString = NSMutableAttributedString(string: "@\(replayToComment.user_name!)：", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor(r: 42, g: 144, b: 215)])
                nameAttributeString.append(replayCommentAttributeString)
                
                let commentAttributeString = NSMutableAttributedString(string: "\(comment!.text!)//", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
                commentAttributeString.append(nameAttributeString)
                
                commentLabel.attributedText = commentAttributeString
                
                
            } else {
                commentLabel.text = comment!.commentText! as String
            }
            if let replayCount = comment!.reply_count {
                if replayCount > 0 {
                    replayCountButton.setTitle("\(replayCount)回复", for: .normal)
                    replayButton.setTitle(String(describing: comment!.createTime!) + "・", for: .normal)
                } else {
                    replayCountButton.isHidden = true
                    replayButton.setTitle(String(describing: comment!.createTime!) + "・回复", for: .normal)
                }
            } else {
                replayCountButton.isHidden = true
                replayButton.setTitle(String(describing: comment!.createTime!) + "・回复", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var replayCountButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var coverReplayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(UIImage(named: "comment_like_icon_press_16x16_"), for: .selected)
        authorLabel.layer.borderColor = UIColor.globalBlueColor().cgColor
        authorLabel.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
}
