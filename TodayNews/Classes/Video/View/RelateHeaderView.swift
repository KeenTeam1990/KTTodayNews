//
//  RelateHeaderView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/10.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class RelateHeaderView: UIView {
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            titleLabel.text = weitoutiao!.title! as String
            playCountLabel.text = weitoutiao!.readCount! + "次播放"
//            timeLabel.text = weitoutiao!.createTime!
            if let likeCount = weitoutiao!.like_count {
                likeButton.setTitle(String(likeCount), for: .normal)
            }
            if let digCount = weitoutiao!.digg_count {
                digButton.setTitle(String(digCount), for: .normal)
            }
            
            if let user_info = weitoutiao!.user_info {
                avatarButton.kf.setImage(with: URL(string: user_info.avatar_url!)!, for: .normal)
                usernameButton.setTitle(user_info.name!, for: .normal)
                if let isFollowing = user_info.is_following {
                    if isFollowing {
                        concernButton.layer.borderColor = UIColor.lightGray.cgColor
                        concernButton.layer.borderWidth = 1
                        concernButton.isSelected = true
                        concernButton.setTitleColor(UIColor.lightGray, for: .selected)
                        concernButton.setTitle("已关注", for: .selected)
                    } else {
                        concernButton.setTitle("+ 关注", for: .normal)
                        concernButton.setTitleColor(UIColor(r: 42, g: 144, b: 215), for: .normal)
                        concernButton.layer.borderWidth = 0
                        concernButton.isSelected = false
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    // 原创
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sanjiaoButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var digButton: UIButton!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sanjiaoButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    class func headerView() -> RelateHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! RelateHeaderView
    }
    
    @IBAction func sanjiaoButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.duration = 0.15
            rotation.repeatCount = 1
            rotation.fromValue = 0
            rotation.toValue = Double.pi
            sender.layer.add(rotation, forKey: "rotation")
            sanjiaoButton.transform = CGAffineTransform(rotationAngle: 0)
        } else {
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.duration = 0.15
            rotation.repeatCount = 1
            rotation.fromValue = Double.pi
            rotation.toValue = 2 * Double.pi
            sender.layer.add(rotation, forKey: "rotation")
            sanjiaoButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.height = 171
    }
}
