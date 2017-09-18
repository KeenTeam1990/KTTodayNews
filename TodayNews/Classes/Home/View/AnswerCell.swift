//
//  AnswerCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/19.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class AnswerCell: UITableViewCell {
    
    var answer: Answer? {
        didSet {
            avatarButton.kf.setImage(with: URL(string: answer!.user!.avatar_url!), for: .normal)
            nameButton.setTitle(answer!.user!.uname!, for: .normal)
            digButton.setTitle("\(answer!.digg_count!)", for: .normal)
        }
    }
    
    /// 头像
    @IBOutlet weak var avatarButton: UIButton!
    /// 用户名
    @IBOutlet weak var nameButton: UIButton!
    /// 点赞
    @IBOutlet weak var digButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
