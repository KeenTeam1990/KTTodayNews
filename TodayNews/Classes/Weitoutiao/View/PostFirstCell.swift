//
//  PostFirstCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/17.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class PostFirstCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func postFirstCell() -> PostFirstCell {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! PostFirstCell
    }
    
}
