//
//  HomeTopicCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/2.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol HomeTopicCellDelegate: class {
    /// 用户头像区域点击
    func videoheadTopicCellButtonClick(videoTopic: WeiTouTiao)
}

class HomeTopicCell: UITableViewCell {
    
    weak var delegate: HomeTopicCellDelegate?
    /// 新闻标题
    @IBOutlet weak var newsTitleLabel: UILabel!
    /// 置顶 / 热
    @IBOutlet weak var hotLabel: UILabel!
    @IBOutlet weak var hotLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var hotLabelLeading: NSLayoutConstraint!
    /// 专题
    @IBOutlet weak var specicalLabel: UILabel!
    @IBOutlet weak var specicalLabelLeading: NSLayoutConstraint!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 评论
    @IBOutlet weak var commentLabel: UILabel!
    /// 发布时间
    @IBOutlet weak var createTimeLabel: UILabel!
    /// 发布时间
    @IBOutlet weak var middleView: UIView!
    /// 右侧按钮图片
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    
    let rightButtonW: CGFloat = (screenWidth - 2 * kMargin - 20) / 3
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            if let title = weitoutiao!.title {
                newsTitleLabel.text = String(title)
            }
            if let hot_label = weitoutiao!.label {
                if hot_label == "置顶" {
                    hotLabel.isHidden = false
                    hotLabel.text = hot_label
                } else if hot_label == "广告" {
                    hotLabelWidth.constant = 30
                    hotLabel.text = hot_label
                    hotLabel.textColor = UIColor.globalBlueColor()
                    hotLabel.layer.cornerRadius = 3
                    hotLabel.layer.masksToBounds = true
                    hotLabel.layer.borderColor = UIColor.globalBlueColor().cgColor
                } else {
                    hotLabel.isHidden = true
                    hotLabelWidth.constant = 0
                }
                
            } else if let hot = weitoutiao!.hot {
                if hot {
                    hotLabel.text = "热"
                    hotLabelWidth.constant = 15
                    hotLabel.isHidden = false
                } else {
                    hotLabelWidth.constant = 0
                    hotLabel.isHidden = true
                }
            } else {
                hotLabel.isHidden = true
                hotLabelWidth.constant = 0
            }
            /// 发布者
            if let source = weitoutiao!.source {
                specicalLabelLeading.constant = 3
                specicalLabel.isHidden = false
                specicalLabel.text = source
            } else if let user = weitoutiao!.user {
                specicalLabelLeading.constant = 3
                specicalLabel.isHidden = false
                specicalLabel.text = user.screen_name!
            } else if let userInfo = weitoutiao!.user_info {
                specicalLabelLeading.constant = 3
                specicalLabel.isHidden = false
                specicalLabel.text = userInfo.screen_name!
            } else if let mediaInfo = weitoutiao!.media_info {
                specicalLabelLeading.constant = 3
                specicalLabel.isHidden = false
                specicalLabel.text = mediaInfo.name!
            } else {
                specicalLabelLeading.constant = 0
                specicalLabel.isHidden = true
            }
            // 评论
            if let comment_count = weitoutiao!.comment_count {
                commentLabel.text = "\(comment_count)" + "评论"
            }
            // 发布时间
            createTimeLabel.text = weitoutiao!.createTime
            /// 是否有图片
            if let hasImage = weitoutiao!.has_image {
                if hasImage {
                    if weitoutiao!.image_list.count > 0 {
                        if weitoutiao!.image_list.count == 1 {
                            rightButton.kf.setImage(with: URL(string: weitoutiao!.image_list.first!.url!), for: .normal)
                            rightButtonWidth.constant = rightButtonW
                        } else {
                            middleView.addSubview(thumbCollectionView)
                            thumbCollectionView.snp.makeConstraints({ (make) in
                                make.top.left.bottom.right.equalTo(middleView)
                            })
                        }
                    } else {
                        if weitoutiao!.large_image_list.count > 0 {
                            let largeImageView = UIImageView()
                            middleView.addSubview(largeImageView)
                            largeImageView.kf.setImage(with: URL(string: weitoutiao!.large_image_list.first!.url!))
                            largeImageView.snp.makeConstraints({ (make) in
                                make.top.left.bottom.right.equalTo(self.middleView)
                            })
                        } else if let middleImage = weitoutiao!.middle_image {
                            rightButton.kf.setImage(with: URL(string: middleImage.url!), for: .normal)
                            rightButtonWidth.constant = rightButtonW
                            rightButton.layoutIfNeeded()
                        }
                    }
                }
            } else if let hasVideo = weitoutiao!.has_video {
                if hasVideo {
                    if let middleImage = weitoutiao!.middle_image { // 右侧小图
                        rightButton.kf.setImage(with: URL(string: middleImage.url!), for: .normal)
                        rightButtonWidth.constant = rightButtonW
                    } else if let videoDetailInfo = weitoutiao!.video_detail_info { // 相当于有大图
                        videoView.imageButton.kf.setBackgroundImage(with: URL(string: videoDetailInfo.detail_video_large_image!.url!), for: .normal)
                        self.middleView.addSubview(videoView)
                        videoView.snp.makeConstraints({ (make) in
                            make.top.left.bottom.right.equalTo(self.middleView)
                        })
                    }
                }
            } else {
                if weitoutiao!.thumb_image_list.count != 0 {
                    self.middleView.addSubview(thumbCollectionView)
                    thumbCollectionView.snp.makeConstraints({ (make) in
                        make.top.left.bottom.right.equalTo(self.middleView)
                    })
                    // 1 or 2
                    let imageHeight1or2 = (screenWidth - kMargin * 2 - 6) * 0.5
                    // >= 3
                    let imageH = (screenWidth - kMargin * 2 - 12) / 3
                    switch weitoutiao!.thumb_image_list.count {
                    case 1:
                        thumbCollectionView.snp.remakeConstraints({ (make) in
                            make.width.equalTo(screenWidth * 0.7)
                            make.top.left.equalTo(self.middleView)
                            make.height.equalTo(imageHeight1or2)
                        })
                    case 2:
                        thumbCollectionView.height = imageHeight1or2
                    case 3:
                        thumbCollectionView.height = imageH
                    case 4...6:
                        thumbCollectionView.height = imageH * 2 + 3 + 20
                    case 7...9:
                        thumbCollectionView.height = imageH * 3 + 6 + 20
                    default:
                        height += 0
                    }
                }
            }
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hotLabel.layer.borderColor = UIColor(r: 212, g: 61, b: 61).cgColor
        hotLabel.layer.borderWidth = 0.5
        newsTitleLabel.theme_textColor = "colors.black"
        dislikeButton.theme_setImage("images.dislikeicon", forState: .normal)
        createTimeLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        specicalLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        bottomLineView.theme_backgroundColor = "colors.separatorColor"
        commentLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        contentView.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: 视频图片
    lazy var videoView: CellVideoView = {
        let videoView = CellVideoView.cellVideoView()
        return videoView
    }()
    
    // MARK: 缩略图
    private lazy var thumbCollectionView: ThumbCollectionView = {
        let thumbCollectionView = ThumbCollectionView.collectionViewWithFrame(frame: CGRect.zero)
        thumbCollectionView.register(UINib(nibName: String(describing: ThumbCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ThumbCollectionViewCell.self))
        thumbCollectionView.isScrollEnabled = false
        thumbCollectionView.delegate = self
        thumbCollectionView.dataSource = self
        return thumbCollectionView
    }()
}

// MARK: - UICollectionViewDelegate
extension HomeTopicCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weitoutiao!.image_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ThumbCollectionViewCell.self), for: indexPath) as! ThumbCollectionViewCell
        let thumbImage = weitoutiao!.image_list[indexPath.item]
        cell.thumbImageURL = (thumbImage.url)!
        if let galleryCount = weitoutiao!.gallery_pic_count {
            if indexPath.row == 2 {
                cell.galleryCountLabel.text = String(describing: galleryCount)
                cell.galleryCountLabel.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageW = (screenWidth - 2 * kMargin - 2 * 6) / 3
        let imageH = imageW * 0.8
        return CGSize(width: imageW, height: imageH)
    }
}



