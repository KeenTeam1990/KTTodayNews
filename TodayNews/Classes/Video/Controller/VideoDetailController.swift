//
//  VideoDetailController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/17.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import SnapKit
import BMPlayer
import NVActivityIndicatorView
import SVProgressHUD

class VideoDetailController: UIViewController {
    /// 播放器
    fileprivate lazy var player = BMPlayer()
    var changeButton = UIButton()
    var playTimeDidChange:((TimeInterval, TimeInterval) -> Void)?
    
    fileprivate let disposeBag = DisposeBag()
    
    var videoTopic: WeiTouTiao? {
        didSet {
            NetworkTool.loadNewsDetailRelateNews(fromCategory: "", weitoutiao: videoTopic!) { (relateNews, labels, userLike, appInfo, filter_wrods) in
                self.relateNews = relateNews
                self.relateTableView.reloadData()
            }
        }
    }
    
    var offset: Int = 0
    var realVideo: RealVideo?
    
    var relateNews = [WeiTouTiao]()
    var comments = [NewsDetailImageComment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground,  object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barStyle = .black
        // 使用手势返回的时候，调用下面方法
        player.autoPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .default
        // 使用手势返回的时候，调用下面方法
        player.pause(allowAutoPlay: true)
        player.removeFromSuperview()
    }
    
    deinit {
        // 使用手势返回的时候，调用下面方法手动销毁
        player.prepareToDealloc()
    }
    
    // 相关新闻
    fileprivate lazy var relateTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.green
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.register(UINib(nibName: String( describing: RelateVideoNewsCell.self), bundle: nil), forCellReuseIdentifier: String( describing: RelateVideoNewsCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // 评论
    fileprivate lazy var commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.red
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.register(UINib(nibName: String( describing: NewsDetailImageCommentCell.self), bundle: nil), forCellReuseIdentifier: String( describing: NewsDetailImageCommentCell.self))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    /// 相关新闻头部的容器
    fileprivate lazy var relateHeaderBackView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 172))
    /// 评论的头部
    fileprivate lazy var commentHeaderBackView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 640 + 172))
    /// 相关新闻头部
    fileprivate lazy var relateHeaderView: RelateHeaderView = {
        let headerView = RelateHeaderView.headerView()
        return headerView
    }()
}

extension VideoDetailController {
    
    func applicationWillEnterForeground() {
        
    }
    
    func applicationDidEnterBackground() {
        player.pause(allowAutoPlay: false)
    }
    
    /// 设置 UI
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        // 设置播放器
        setupPlayerManager()
        
        view.addSubview(commentTableView)
        
        relateHeaderView.weitoutiao = videoTopic
        relateTableView.tableHeaderView = relateHeaderView
        commentTableView.tableHeaderView = commentHeaderBackView
        
        commentHeaderBackView.addSubview(relateTableView)
        
        commentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(player.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        relateTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(commentHeaderBackView)
        }
        
        // 获取评论数据
        NetworkTool.loadNewsDetailComments(offset: offset, weitoutiao: videoTopic!) { (comments) in
            self.comments = comments
            self.commentTableView.reloadData()
        }
        
        commentTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            // 获取评论数据
            NetworkTool.loadNewsDetailComments(offset: self!.comments.count, weitoutiao: self!.videoTopic!) { [weak self] (comments) in
                self!.commentTableView.mj_footer.endRefreshing()
                if comments.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.5))
                    SVProgressHUD.showInfo(withStatus: "没有更多评论啦~")
                } else {
                    self!.comments += comments
                }
                self!.commentTableView.reloadData()
            }
        })
    }
    
    // 设置播放器单例，修改属性
    fileprivate func setupPlayerManager() {
        resetPlayerManager()
        
        view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(view.snp.width).multipliedBy(9.0 / 16.0)
        }
        
        player.backBlock = { [weak self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            self!.navigationController?.popViewController(animated: true)
        }
        let asset = self.preparePlayerItem()
        player.setVideo(resource: asset)
    }
    
    
    /**
     准备播放器资源model
     */
    func preparePlayerItem() -> BMPlayerResource {
        
//        let res0 = BMPlayerResourceDefinition(url: URL(string: realVideo!.video_3!.main_url!)!,
//                                              definition: "超清")
//        let res1 = BMPlayerResourceDefinition(url: URL(string: realVideo!.video_2!.main_url!)!,
//                                              definition: "高清")
        let res2 = BMPlayerResourceDefinition(url: URL(string: realVideo!.video_1!.main_url!)!,
                                              definition: "标清")
        
        let asset = BMPlayerResource(name: "",
                                     definitions: [res2])
        return asset
    }
    
    /// 重置播放器
    fileprivate func resetPlayerManager() {
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .always
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension VideoDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == relateTableView ? relateNews.count : comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  tableView == relateTableView  {
            return 80
        } else {
            let comment = comments[indexPath.row]
            return comment.cellHeight!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == relateTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RelateVideoNewsCell.self), for: indexPath) as! RelateVideoNewsCell
            cell.relateNews = relateNews[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: NewsDetailImageCommentCell.self), for: indexPath) as! NewsDetailImageCommentCell
            cell.comment = comments[indexPath.row]
            cellClickedEvent(cell: cell)
            return cell
        }
    }
    
    /// cell 按钮点击事件
    private func cellClickedEvent(cell: NewsDetailImageCommentCell) {
        // 头像按钮点击
        cell.avatarButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPushViewController(cell: cell)
            })
            .addDisposableTo(disposeBag)
        // 用户名点击
        cell.nameLabel.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPushViewController(cell: cell)
            })
            .addDisposableTo(disposeBag)
        // 点击了 评论内容或者回复
        cell.coverReplayButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {
                
            })
            .addDisposableTo(disposeBag)
    }
    
    // push
    fileprivate func setupPushViewController(cell: NewsDetailImageCommentCell) {
        let followDetailVC = FollowDetailViewController()
        followDetailVC.userid = cell.comment!.user_id!
        navigationController?.pushViewController(followDetailVC, animated: true)
    }
}
