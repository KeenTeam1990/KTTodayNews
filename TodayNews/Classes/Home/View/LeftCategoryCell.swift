//
//  LeftCategoryCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class LeftCategoryCell: UITableViewCell {
    /// 选中时显示的指示器View
    @IBOutlet weak var selectedIndicater: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var concern: ConcernToutiaohao? {
        didSet {
            nameLabel.text = concern!.name!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.globalBackgroundColor()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedIndicater.backgroundColor = selected ? UIColor.globalRedColor() : UIColor.clear
        selectedIndicater.isHidden = !selected
        contentView.backgroundColor = selected ? UIColor.white : UIColor.globalBackgroundColor()
        nameLabel.textColor = selected ? UIColor.globalRedColor() : UIColor.black
    }
    
}
