//
//  PostSecondCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/17.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class PostSecondCell: UITableViewCell {

    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func postSecondCell() -> PostSecondCell {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! PostSecondCell
    }
    
}
