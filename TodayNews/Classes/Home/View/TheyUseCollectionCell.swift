//
//  TheyUseCollectionCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/21.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class TheyUseCollectionCell: UICollectionViewCell {
    
    var userCard: UserCard? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: userCard!.user!.info!.avatar_url!))
            nameLabel.text = userCard!.user!.info!.name!
            subtitleLabel.text = userCard!.recommend_reason!
        }
    }
    
    @IBOutlet weak var vipImageView: UIImageView!
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 子标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 关注
    @IBOutlet weak var concernButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        closeButton.theme_setImage("images.iconPopupClose", forState: .normal)
    }

}
