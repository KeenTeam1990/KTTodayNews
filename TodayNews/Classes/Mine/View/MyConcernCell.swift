//
//  MyConcernCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/23.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher


class MyConcernCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarVImageView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    var myConcern: MyConcern? {
        didSet {
            imageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name!
            if let isVerify = myConcern!.is_verify {
                avatarVImageView.isHidden = !isVerify
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.theme_textColor = "colors.black"
        
    }

}
