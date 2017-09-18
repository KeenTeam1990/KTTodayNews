//
//  VideoTopicControllerViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/17.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import BMPlayer
import MJRefresh
import SVProgressHUD
import NVActivityIndicatorView

class VideoTopicController: UIViewController {
    /// 播放器
    fileprivate lazy var player = BMPlayer()
    
    fileprivate let disposeBag = DisposeBag()
    /// 上一次点击的 cell
    var lastCell = VideoTopicCell()
    
    // 记录点击的顶部标题
    var videoTitle: TopicTitle?
    // 存放新闻主题的数组
    fileprivate var newsTopics = [WeiTouTiao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        let header = RefreshHeder(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.videoTitle!.category!) { (nowTime, newsTopics) in
                self!.tableView.mj_header.endRefreshing()
                self!.newsTopics = newsTopics
                self!.tableView.reloadData()
            }
        })
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.videoTitle!.category!) { (nowTime, newsTopics) in
                if newsTopics.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多视频啦~")
                    self!.tableView.mj_footer.endRefreshing()
                    return
                }
                self!.newsTopics += newsTopics
                self!.tableView.reloadData()
            }
        })
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.rowHeight = screenHeight * 0.4
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - kTabBarHeight)
        tableView.register(UINib(nibName: String(describing: VideoTopicCell.self), bundle: nil), forCellReuseIdentifier: String(describing: VideoTopicCell.self))
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return tableView
    }()
}

extension VideoTopicController {
    
    fileprivate func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view)
        }
    }
}

// MARK: - Table view data source
extension VideoTopicController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoTopicCell.self)) as! VideoTopicCell
        cell.videoTopic = newsTopics[indexPath.row]
        // 头像区域点击
        cell.headCoverButton.rx.controlEvent(.touchUpInside)
                               .subscribe(onNext: { [weak self] in
                                    let userVC = FollowDetailViewController()
                                    userVC.userid = cell.videoTopic!.media_info!.user_id!
                                    self!.navigationController!.pushViewController(userVC, animated: true)
                               })
                               .addDisposableTo(disposeBag)
        // 评论按钮点击
        cell.commentButton.rx.controlEvent(.touchUpInside)
                            .subscribe(onNext: { [weak self] in
                                let videoDetailVC = VideoDetailController()
                                videoDetailVC.videoTopic = cell.videoTopic
                                self!.navigationController!.pushViewController(videoDetailVC, animated: true)
                            })
                            .addDisposableTo(disposeBag)
        // 播放按钮点击
        cell.bgImageButton.rx.controlEvent(.touchUpInside)
                            .subscribe(onNext: { (_) in
                                if self.lastCell != cell {
                                    if self.player.isPlaying {
                                        self.player.removeFromSuperview()
                                        self.lastCell.titleLabel.isHidden = false
                                        self.lastCell.playCountLabel.isHidden = false
                                        self.lastCell.timeLabel.isHidden = false
                                    }
                                }
                                cell.titleLabel.isHidden = true
                                cell.playCountLabel.isHidden = true
                                cell.timeLabel.isHidden = true
                                self.player = BMPlayer(customControlView: BMPlayerCustomControlView())
                                cell.bgImageButton.addSubview(self.player)
                                BMPlayerConf.allowLog = false
                                BMPlayerConf.tintColor = UIColor.white
                                BMPlayerConf.topBarShowInCase = .none
                                BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
                                self.player.snp.makeConstraints { (make) in
                                    make.edges.equalTo(cell.bgImageButton)
                                }
                                /// 获取视频的真实链接
                                NetworkTool.parseVideoRealURL(video_id: cell.videoTopic!.video_id!) { (realVideo) in
                                    let asset = BMPlayerResource(url: URL(string: realVideo.video_1!.main_url!)!, name: cell.titleLabel.text!)
                                    self.player.setVideo(resource: asset)
                                    self.lastCell = cell
                                }
                            })
                            .addDisposableTo(disposeBag)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoTopic = newsTopics[indexPath.row]
        /// 获取视频的真实链接
        NetworkTool.parseVideoRealURL(video_id: videoTopic.video_id!) { (realVideo) in
            let videoDetailVC = VideoDetailController()
            videoDetailVC.videoTopic = videoTopic
            videoDetailVC.realVideo = realVideo
            self.navigationController?.pushViewController(videoDetailVC, animated: true)
            if self.player.isPlaying { // 说明有正在播放的视频
                self.player.removeFromSuperview()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if player.isPlaying { // 说明有正在播放的视频
            let imageButton = player.superview
            let contentView = imageButton?.superview
            let cell = contentView?.superview as! VideoTopicCell
            let rect = tableView.convert(cell.frame, to: view)
            if (rect.origin.y <= -cell.height) || (rect.origin.y >= screenHeight - kTabBarHeight) {
                player.pause()
                player.removeFromSuperview()
            }
        }
    }
}
