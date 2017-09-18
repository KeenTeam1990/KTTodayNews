//
//  ConcernHeaderView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/27.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class ConcernHeaderView: UIView {
    
    /// 背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    /// 头像
    @IBOutlet weak var avaterImageView: UIImageView!
    /// V
    @IBOutlet weak var allVAvatarImageView: UIImageView!
    /// 头条认证
    @IBOutlet weak var verfiedLabel: UILabel!
    /// 认证内容
    @IBOutlet weak var verifiedContenLabel: UILabel!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    /// 描述
    @IBOutlet weak var descriptionLabel: UILabel!
    /// 描述高度
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    /// 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 关注数量
    @IBOutlet weak var concernCountLabel: UILabel!
    /// 粉丝数量
    @IBOutlet weak var fansCountLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    /// 指示器
    @IBOutlet weak var indicatorView: UIView!
    /// 指示器的约束
    @IBOutlet weak var indicatorConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaterImageView.layer.borderColor = UIColor.white.cgColor
        avaterImageView.layer.borderWidth = 1
        concernButton.layer.borderColor = UIColor.lightGray.cgColor
        concernButton.layer.borderWidth = 1
        self.width = screenWidth
        self.height = kConcernHeaderViewHieght
    }
    
    var follewDetail: FollowDetail? {
        didSet {
            avaterImageView.kf.setImage(with: URL(string: (follewDetail?.avatar_url!)!))
            if let isFollowing = follewDetail!.is_following {
                if isFollowing {
                    concernButton.layer.borderColor = UIColor.lightGray.cgColor
                    concernButton.layer.borderWidth = 1
                    concernButton.isSelected = true
                    concernButton.setTitleColor(UIColor.lightGray, for: .selected)
                    concernButton.setTitle("已关注", for: .selected)
                } else {
                    concernButton.setTitle("关注", for: .normal)
                    concernButton.setTitleColor(UIColor(r: 42, g: 144, b: 215), for: .normal)
                    concernButton.layer.borderWidth = 0
                    concernButton.isSelected = false
                }
            }
            if let screen_name = follewDetail?.screen_name {
                nameLabel.text = screen_name
            } else if let name = follewDetail?.name {
                nameLabel.text = name
            }
            if let description = follewDetail!.description {
                descriptionLabel.text = String(describing: description)
            }
            concernCountLabel.text = follewDetail!.followingsCount!
            fansCountLabel.text = follewDetail!.followersCount!
            let buttonW: CGFloat = 60
            for (index, topTab) in follewDetail!.top_tab.enumerated() {
                let button = UIButton(frame: CGRect(x: CGFloat(index) * buttonW, y: 0, width: buttonW, height: 40))
                button.setTitle(topTab.show_name, for: .normal)
                button.addTarget(self, action: #selector(bottomViewButtonClicked(_:)), for: .touchUpInside)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.tag = index
                bottomView.addSubview(button)
            }
            allVAvatarImageView.isHidden = !follewDetail!.user_verified!
            if follewDetail!.user_verified! {
                verfiedLabel.isHidden = false
                verifiedContenLabel.isHidden = false
                verfiedLabel.text = "头条认证："
                verifiedContenLabel.text = follewDetail!.user_auth_info!.auth_info!
            } else {
                verfiedLabel.isHidden = true
                verifiedContenLabel.isHidden = true
            }
        }
    }
    
    /// 展开按钮点击了
    @IBAction func unfoldButtonClicked() {
        unfoldButtonWidth.constant = 0
        /// 更新描述的高度
        if isIPhone5 {
            descriptionLabelHeight.constant = follewDetail!.descriptionH! * 2
            self.height = kConcernHeaderViewHieght + follewDetail!.descriptionH!
        } else if isIPhone6 {
            descriptionLabelHeight.constant = follewDetail!.descriptionH! * 2.5
            self.height = kConcernHeaderViewHieght + follewDetail!.descriptionH! + 10
        } else if isIPhone6P {
            descriptionLabelHeight.constant = follewDetail!.descriptionH! * 3
            self.height = kConcernHeaderViewHieght + follewDetail!.descriptionH! + 10
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        }, completion: { (_) in
            self.unfoldButton.isHidden = true
        })
    }
    
    func bottomViewButtonClicked(_ sender: UIButton) {
        switch sender.tag {
            case 0:  /// 动态按钮点击
                self.indicatorConstraint.constant = 14
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
            case 1: /// 文章按钮点击
                self.indicatorConstraint.constant = sender.width + 14
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
            case 2: /// 视频/问答按钮点击
                self.indicatorConstraint.constant = 2 * sender.width + 14
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
            default: break
        }
    }
    
    class func headerView() -> ConcernHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! ConcernHeaderView
    }
}
