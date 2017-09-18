//
//  RelateNewsCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class RelateVideoNewsCell: UITableViewCell {
    
    var relateNews: WeiTouTiao? {
        didSet {
            newTitleLabel.text = relateNews!.title! as String
            if let mediaName = relateNews!.media_name {
                usernameLabel.text = mediaName
            }
            if let middleImage = relateNews!.middle_image {
                thumbImageView.kf.setImage(with: URL(string: middleImage.url!)!)
            }
            if let videoDetail = relateNews!.video_detail_info {
                playCountLabel.text = videoDetail.videoWatchCount! + "次播放"
            }
            videoTimeLabel.text = relateNews!.video_duration!
            if let showTag = relateNews!.show_tag {
                if showTag == "广告" {
                    usernameLabel.text = relateNews!.source!
                    adLabel.text = showTag
                    adLabel.layer.cornerRadius = 2
                    adLabel.layer.borderColor = UIColor(r: 72, g: 107, b: 157).cgColor
                    adLabel.layer.borderWidth = 0.5
                    playCountLabel.isHidden = true
                    videoTimeLabel.isHidden = true
                }
            }
        }
    }
    /// 广告
    @IBOutlet weak var adLabel: UILabel!
    
    @IBOutlet weak var newTitleLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var playCountLabel: UILabel!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var videoTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
