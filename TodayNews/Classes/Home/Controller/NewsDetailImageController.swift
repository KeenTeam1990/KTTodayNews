//
//  NewsDetailImageController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/4.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class NewsDetailImageController: UIViewController {
    
    var hidden: Bool = false
    
    var images = [NewsDetailImage]()
    var abstracts = [String]()
    
    var isSelectedFirstCell = false
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentLabelWidth: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    /// 加 V
    @IBOutlet weak var vipImageView: UIImageView!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    /// 收藏按钮
    @IBOutlet weak var collectButton: UIButton!
    
    var weitoutiao: WeiTouTiao?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NewsDetailImageController {
    fileprivate func setupUI() {
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        
        collectButton.setImage(UIImage(named: "icon_details_collect_press_24x24_"), for: .selected)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: String(describing: NewsDetailImageCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NewsDetailImageCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        if let userVerified = weitoutiao!.user_verified {
//            avatarButton.isHidden = !userVerified
//            vipImageView.isHidden = !userVerified
//        }
//        if let user = weitoutiao!.user {
//            avatarButton.kf.setImage(with: URL(string: (user.avatar_url)!), for: .normal)
//        } else if let user_info = weitoutiao!.user_info {
//            avatarButton.kf.setImage(with: URL(string: (user_info.avatar_url)!), for: .normal)
//        }
        if let comment_count = weitoutiao!.comment_count {
            if comment_count == 0 {
                commentLabel.isHidden = true
            } else {
                commentLabel.text = String(comment_count)
                switch comment_count {
                case 0...9:
                    commentLabelWidth.constant = 20
                case 10...99:
                    commentLabelWidth.constant = 23
                case 100...999:
                    commentLabelWidth.constant = 28
                default:
                    commentLabelWidth.constant = 20
                }
                if comment_count > 999 {
                    commentLabel.text = "999+"
                }
            }
        }
        if isSelectedFirstCell { // 如果点击的第一个 cell 才去获取数据,其他情况数据从上一控制器传过来
            NetworkTool.loadNewsDetail(articleURL: weitoutiao!.article_url!) { (images, abstracts) in
                self.images = images
                self.abstracts = abstracts
                self.collectionView.reloadData()
                self.setupAttributeString(index: 1) // 先设置好第一张图片的子标题
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - 按钮点击事件
extension NewsDetailImageController {
    
    /// 关闭按钮点击
    @IBAction func closeNewsDetailImageViewControllerButtonClciked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 头像按钮点击
    @IBAction func avatarButtonClciked(_ sender: UIButton) {
        
    }
    
    /// 更多按钮点击
    @IBAction func moreButonClicked(_ sender: UIButton) {
        
    }
    
    /// 写评论
    @IBAction func writeButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 评论按钮点击
    @IBAction func commentButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NewsDetailImageCommentController", bundle: nil)
        let newDetailCommentVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailImageCommentController") as! NewsDetailImageCommentController
        newDetailCommentVC.weitoutiao = weitoutiao
        newDetailCommentVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - 20)))
        present(newDetailCommentVC, animated: true, completion: nil)
    }
    
    /// 收藏按钮点击
    @IBAction func collectButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.15, animations: {
            sender.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.15, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
    }
    
    /// 转发按钮点击
    @IBAction func forwardButtonClicked(_ sender: UIButton) {
        
    }
}

extension NewsDetailImageController: NewsDetailImageCellDelegate {
    
    /// 长按图片事件
    func imageViewLongPressGestureRecognizer() {
        // 暂时先用 actionSheet 吧
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let shareImageAction = UIAlertAction(title: "分享此张图片", style: .default) { (_) in
            
        }
        let saveImageAction = UIAlertAction(title: "保存图片", style: .default) { (_) in
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionSheet.addAction(shareImageAction)
        actionSheet.addAction(saveImageAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

extension NewsDetailImageController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsDetailImageCell.self), for: indexPath) as! NewsDetailImageCell
        cell.delegate = self
        cell.index = indexPath.item + 1
        cell.count = images.count
        let image = images[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: image.url!), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.5))
            SVProgressHUD.setForegroundColor(UIColor.white)
        }) { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        }
        cell.abstract = abstracts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsDetailImageCell.self), for: indexPath)
        if hidden {
            UIView.animate(withDuration: 0.3, animations: { // 隐藏
                cell.isUserInteractionEnabled = false
                self.closeButton.alpha = 1
                self.moreButton.alpha = 1
                self.bottomView.alpha = 1
                self.avatarButton.alpha = 1
//                if let userVerified = self.weitoutiao!.user_verified {
//                    if userVerified {
                        self.vipImageView.alpha = 1
//                    }
//                }
                self.abstractLabel.alpha = 1
            }, completion: { (_) in
                self.hidden = false
                cell.isUserInteractionEnabled = true
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: { // 显示
                cell.isUserInteractionEnabled = false
                self.avatarButton.alpha = 0
                self.closeButton.alpha = 0
                self.moreButton.alpha = 0
                self.bottomView.alpha = 0
//                if let userVerified = self.weitoutiao!.user_verified {
//                    if userVerified {
                        self.vipImageView.alpha = 0
//                    }
//                }
                self.abstractLabel.alpha = 0
            }, completion: { (_) in
                self.hidden = true
                cell.isUserInteractionEnabled = true
            })
        }
    }
    
    // 方式1 ，下面的代码可以和在 cell 中设置的 abstractLabel 对应来写，二者选一种
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / screenWidth) + 1
        setupAttributeString(index: index)
    }
    
    /// 设置子标题
    fileprivate func setupAttributeString(index: Int) {
        let abstract = abstracts[index - 1]
        
        let size = CGSize(width: screenWidth - 2 * kMargin, height: CGFloat(MAXFLOAT))
        let abstractHeight = abstract.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil).size.height
        abstractLabelHeight.constant = abstractHeight + 5
        abstractLabel.layoutIfNeeded()
        
        let abstractAttributeString = NSAttributedString(string: abstract, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
        
        let countAttributeString = NSMutableAttributedString(string: "/\(abstracts.count) ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)])
        countAttributeString.append(abstractAttributeString)
        
        let numberAttributeString = NSMutableAttributedString(string: String(index), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
        numberAttributeString.append(countAttributeString)
        
        abstractLabel.attributedText = numberAttributeString
    }
}






