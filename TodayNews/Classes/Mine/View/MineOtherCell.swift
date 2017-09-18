//
//  YMMineOtherCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/22.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class MineOtherCell: UITableViewCell {
    /// 标题
    @IBOutlet weak var leftlabel: UILabel!
    /// 右侧标签
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var rightTipImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    
    var mineCellModel: MineCellModel? {
        didSet {            
            leftlabel.text = mineCellModel?.text!
            rightLabel.text = mineCellModel?.grey_text!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 设置主题
        separatorView.theme_backgroundColor = "colors.separatorColor"
        rightTipImageView.theme_image = "images.arrowMoreLogin"
        leftlabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        contentView.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
