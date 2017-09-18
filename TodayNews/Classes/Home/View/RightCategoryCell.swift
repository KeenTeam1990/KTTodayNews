//
//  RightCategoryCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class RightCategoryCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var concernButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var subConcern: SubConcern? {
        didSet {
            nameLabel.text = subConcern!.name!
            contentLabel.text = subConcern!.description!
            iconImageView.kf.setImage(with: URL(string: subConcern!.icon!))
            concernButton.isSelected = subConcern!.is_subscribed!
            if subConcern!.is_subscribed! {
                concernButton.layer.borderColor = UIColor.lightGray.cgColor
                concernButton.isSelected = true
                concernButton.setTitle("已关注", for: .selected)
            } else {
                concernButton.setTitle("关注", for: .normal)
                concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
                concernButton.layer.borderWidth = 1
                concernButton.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.globalBackgroundColor().cgColor
        concernButton.setTitleColor(UIColor.lightGray, for: .selected)
        concernButton.setTitleColor(UIColor(r: 42, g: 144, b: 215), for: .normal)
        concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
        concernButton.layer.borderWidth = 1
    }
    
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if !sender.isSelected {
            // 关注
            NetworkTool.loadFollowInfo(user_id: subConcern!.user_id!) { (isFllowing) in
                if isFllowing {
                    self.concernButton.isSelected = true
                    self.concernButton.layer.borderWidth = 1
                    self.concernButton.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
        } else {
            // 取消关注
            NetworkTool.loadUnfollowInfo(user_id: subConcern!.user_id!, completionHandler: { (isFllowing) in
                if !isFllowing {
                    self.concernButton.isSelected = false
                    self.concernButton.layer.borderWidth = 1
                    self.concernButton.layer.borderColor = UIColor(r: 42, g: 144, b: 215).cgColor
                }
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
