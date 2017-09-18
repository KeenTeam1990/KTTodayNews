//
//  HomeDetailController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import MJRefresh
import SVProgressHUD
import Kingfisher
import IBAnimatable

class TopicDetailController: UIViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    var comments = [NewsDetailImageComment]()
    var relateNews = [WeiTouTiao]()
    var labels = [NewsDetailLabel]()
    var userLike: UserLike?
    var appInfo: NewsDetailAPPInfo?
    
    @IBOutlet weak var tableView: UITableView!
    
    var htmlString: String? {
        didSet {
            // 需要加载 css 文件，所以 baseURL 不能为 nil
            webView.loadHTMLString(htmlString!, baseURL: Bundle.main.bundleURL)
        }
    }
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            if let user = weitoutiao!.user {
                navView.usernameLabel.text = user.name
                navView.avatarImageView.kf.setImage(with: URL(string: user.avatar_url!))
            } else if let userInfo = weitoutiao!.user_info {
                navView.usernameLabel.text = userInfo.name
                navView.avatarImageView.kf.setImage(with: URL(string: userInfo.avatar_url!))
            } else if let mediaInfo = weitoutiao!.media_info {
                navView.usernameLabel.text = mediaInfo.name
                navView.avatarImageView.kf.setImage(with: URL(string: mediaInfo.avatar_url!))
            }
            /// 设置属性
            headerView.weitoutiao = weitoutiao!
            headerView.height = 45 + 2 * kMargin + weitoutiao!.newDetailTitleHeight!
            /// 获取评论
            NetworkTool.loadNewsDetailComments(offset: 0, weitoutiao: weitoutiao!) { (comments) in
                self.comments = comments
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    /// 标签，广告 作为头部
    fileprivate lazy var relateHeaderView: HomeRelateNewsHeaderView = {
        let relateHeaderView = HomeRelateNewsHeaderView.relateNewHeaderView()
        relateHeaderView.x = 0
        relateHeaderView.y = 0
        return relateHeaderView
    }()
    
    /// 相关新闻列表的头部，添加
    fileprivate lazy var relateBackHeaderView: UIView = {
        let relateBackHeaderView = UIView()
        return relateBackHeaderView
    }()
    
    /// 头部 标题，用户名，关注按钮,添加到 commentBackHeaderView
    fileprivate lazy var headerView: NewsDetailHeaderView = {
        let headerView = NewsDetailHeaderView.headerView()
        headerView.x = 0
        headerView.y = 0
        return headerView
    }()
    
    /// 相关新闻的 tableView， 添加到 commentBackHeaderView
    fileprivate lazy var relateNewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false  // 设置不能滚动
        tableView.estimatedRowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: String(describing: DetailRelateNewsCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DetailRelateNewsCell.self))
        return tableView
    }()
    
    /// 评论的头部,作为相关新闻列表的容器
    fileprivate lazy var commentBackHeaderView: UIView = {
        let commentBackHeaderView = UIView()
        return commentBackHeaderView
    }()
    
    /// 导航条
    fileprivate lazy var navView: ConcernNavigationView = {
        let navView = ConcernNavigationView.concernNavView()
        navView.returnButton.setImage(UIImage(named: "lefterbackicon_titlebar_24x24_"), for: .normal)
        navView.moreButton.setImage(UIImage(named: "More_24x24_"), for: .normal)
        navView.delegate = self
        navView.bottomLine.isHidden = false // 显示分割线
        return navView
    }()
    
    fileprivate lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self as WKNavigationDelegate
        return webView
    }()
}

extension TopicDetailController: WKNavigationDelegate {
    /// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        /// 方法一 ：根据 js 来获取高度，可以获取到高度
        webView.evaluateJavaScript("document.body.offsetHeight;") { (result, error) in
//            let height: CGFloat = result as! CGFloat // 获取的高度不准确
            /// 方法二 ：根据 webview 内嵌的 scrollView 的 contentSize.height 去计算高度
            /// 但是这种方法获取的高度是 0
            let height = webView.scrollView.contentSize.height
            // 设置 webview 的 frame
            webView.frame = CGRect(x: 0, y: self.headerView.frame.maxY, width: screenWidth, height: height)
            /// 获取相关新闻
            NetworkTool.loadNewsDetailRelateNews(fromCategory: "", weitoutiao: self.weitoutiao!) { (relateNews, labels, userLike, appInfo , filter_wrods) in
                /// 设置相关属性
                self.relateHeaderView.filter_wrods = filter_wrods
                self.relateHeaderView.userLike = userLike
                var relateHeaderViewHeight: CGFloat = 125 // 105 顶部留白 + 中间留白X2 + 喜欢按钮
                if labels.count > 0 { // 说明标签数组有对象
                    self.relateHeaderView.labels = labels
                    relateHeaderViewHeight += 30
                } else {
                    self.relateHeaderView.scrollViewHeight.constant = 0
                }
                if let app_info = appInfo { // 广告存在
                    self.relateHeaderView.appInfo = app_info
                    relateHeaderViewHeight += screenWidth * 0.65
                    self.relateHeaderView.adViewHeight.constant = screenWidth * 0.65
                } else {
                    self.relateHeaderView.adViewHeight.constant = 0
                    self.relateHeaderView.appNameViewHeight.constant = 0
                    self.relateHeaderView.bottomViewHeight.constant = 0
                    self.relateHeaderView.adView.isHidden = true
                }
                /// 设置 relateHeaderView 高度
                self.relateHeaderView.height = relateHeaderViewHeight
                self.relateHeaderView.layoutIfNeeded()
                /// 设置相关新闻 table 的高度
                var relateTableHeight: CGFloat = relateHeaderViewHeight
                for relatenews in relateNews {
                    relateTableHeight += relatenews.relateNewsCellHeight!
                }
                
                /// 添加
                self.relateNewsTableView.tableHeaderView = self.relateHeaderView
                self.relateNewsTableView.frame = CGRect(x: 0, y: self.webView.frame.maxY, width: screenWidth, height: relateTableHeight)
                self.relateNews = relateNews
                self.relateNewsTableView.reloadData()
                self.commentBackHeaderView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: self.relateNewsTableView.frame.maxY)
                self.commentBackHeaderView.addSubview(self.headerView)
                self.commentBackHeaderView.addSubview(self.webView)
                self.commentBackHeaderView.addSubview(self.relateNewsTableView)
                // 设置头部
                self.tableView.tableHeaderView = self.commentBackHeaderView
            }
        }
    }
    /// 当开始请求时，会调用此方法
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// 响应的内容到达主页面的时候响应,刚准备开始渲染页面应用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    /// 启动时加载数据发生错误就会调用这个方法
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("网页加载发生错误-----\(error)")
    }
}

extension TopicDetailController: UITableViewDelegate, UITableViewDataSource {
    /// cell 的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == relateNewsTableView {
            let relateNew = relateNews[indexPath.row]
            return relateNew.relateNewsCellHeight!
        } else {
            let comment = comments[indexPath.row]
            return comment.cellHeight!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == relateNewsTableView ? relateNews.count : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == relateNewsTableView {
            let cell = relateNewsTableView.dequeueReusableCell(withIdentifier: String(describing: DetailRelateNewsCell.self), for: indexPath) as! DetailRelateNewsCell
            let relatenews = relateNews[indexPath.row]
            cell.contenLabel.text = relatenews.title! as String
            return cell
        } else {
            let comment = comments[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDetailImageCommentCell.self), for: indexPath) as! NewsDetailImageCommentCell
            /// 判断评论是不是作者
            if let user = weitoutiao!.user {
                if comment.user_id! == user.user_id! {
                    cell.isAuthor = true
                }
            } else if let userInfo = weitoutiao!.user_info {
                if comment.user_id! == userInfo.user_id! {
                    cell.isAuthor = true
                }
            } else if let mediaInfo = weitoutiao!.media_info {
                if comment.user_id! == mediaInfo.user_id! {
                    cell.isAuthor = true
                }
            }
            cell.comment = comments[indexPath.row]
            cellClickedEvent(cell: cell)
            return cell
        }
    }
    
    /// 设置 presnet 出来的控制器
    private func setupPresentationController(cell: NewsDetailImageCommentCell) {
        let followDetailVC = FollowDetailViewController()
        followDetailVC.userid = cell.comment!.user_id!
        followDetailVC.dismissalAnimationType = .cover(from: .right)
        followDetailVC.presentationAnimationType = .cover(from: .right)
        followDetailVC.modalSize = (width: .full, height: .full)
        self.present(followDetailVC, animated: true, completion: nil)
    }
    
    /// cell 按钮点击事件
    private func cellClickedEvent(cell: NewsDetailImageCommentCell) {
        // 头像按钮点击
        cell.avatarButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPresentationController(cell: cell)
            })
            .addDisposableTo(disposeBag)
        // 用户名点击
        cell.nameLabel.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self!.setupPresentationController(cell: cell)
            })
            .addDisposableTo(disposeBag)
        // 点击了 评论内容或者回复
        cell.coverReplayButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {
                
            })
            .addDisposableTo(disposeBag)
    }
    /// scrollView 代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY > 0 {
            // 把 头部的用户图片的 frame 转换到 view 的坐标
            let rect = headerView.convert(headerView.avatarImageView.frame, to: view)
            if rect.origin.y <= 0 {
                navView.vipImageView.isHidden = false
                navView.avatarImageView.isHidden = false
                navView.usernameLabel.isHidden = false
                navView.concernButton.isHidden = false
                if let userVerified = weitoutiao!.user_verified {
                    navView.vipImageView.isHidden = !userVerified
                }
            } else {
                navView.vipImageView.isHidden = true
                navView.avatarImageView.isHidden = true
                navView.usernameLabel.isHidden = true
                navView.concernButton.isHidden = true
            }
        }
    }
}

extension TopicDetailController {
    
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String( describing: NewsDetailImageCommentCell.self), bundle: nil), forCellReuseIdentifier: String( describing: NewsDetailImageCommentCell.self))
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            // 获取评论数据
            NetworkTool.loadNewsDetailComments(offset: self!.comments.count, weitoutiao: self!.weitoutiao!) { (comments) in
                self!.tableView.mj_footer.endRefreshing()
                if comments.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多评论啦~")
                    return
                }
                self!.comments += comments
                self!.tableView.reloadData()
            }
        })
        
//        view.addSubview(headerView)
        view.addSubview(navView)
    }
}

// MARK: - ConcernNavigationViewDelegate
extension TopicDetailController: ConcernNavigationViewDelegate {
    /// 返回按钮点击
    func concernHeaderViewReturnButtonClicked() {
        if (navigationController != nil) {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    /// 更多按钮点击
    func concernHeaderViewMoreButtonClicked() {
        
    }
}
