//
//  NewCareViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/7.
//  Copyright © 2017年 hrscy. All rights reserved.
//
// 3.微头条 控制器

import UIKit
import SnapKit
import MJRefresh
import SVProgressHUD

class WeiTouTiaoViewController: UIViewController {
    /// 微头条数据
    fileprivate var microNews = [WeiTouTiao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        /// 获取微头条数据
        let header = RefreshHeder(refreshingBlock: { [weak self] in
            NetworkTool.loadWeiTouTiaoData { (weitoutiaos) in
                self!.tableView.mj_header.endRefreshing()
//                self!.notNetworkView.isHidden = weitoutiaos.count != 0 ? true : false
                self!.microNews = weitoutiaos
                self!.tableView.reloadData()
            }
        })
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            // 加载更多
            NetworkTool.loadWeiTouTiaoData { (weitoutiaos) in
                self!.tableView.mj_footer.endRefreshing()
                if weitoutiaos.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多新闻啦~")
                    return
                }
                self!.microNews += weitoutiaos
                self!.tableView.reloadData()
            }
        })
    }

    fileprivate lazy var headerView: WeitoutiaoHeaderView = {
        let headerView = WeitoutiaoHeaderView.headerView()
        headerView.delegate = self
        return headerView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.register(UINib(nibName: String(describing: WeiTouTiaoCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeiTouTiaoCell.self))
        return tableView
    }()
    
    /// 没有数据时显示
    fileprivate lazy var notNetworkView: NotNetworkView = {
        let notNetworkView = NotNetworkView.noNetworkView()
        return notNetworkView
    }()
    
    fileprivate lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WeiTouTiaoViewController {
    
    fileprivate func setupUI() {
        // 设置导航栏颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.otherNavBarTintColor"
        view.backgroundColor = UIColor.globalBackgroundColor()
        navigationItem.rightBarButtonItem?.theme_tintColor = "colors.black"
        view.addSubview(bgView)
        bgView.addSubview(headerView)
        bgView.addSubview(tableView)
//        bgView.addSubview(notNetworkView)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(kNavBarHeight)
            make.bottom.equalTo(view).offset(-kTabBarHeight)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bgView)
            make.height.equalTo(kWeiTouTiaoHeaderHieght)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.bottom.right.equalTo(bgView)
        }
        
//        notNetworkView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalTo(bgView)
//            make.top.equalTo(headerView.snp.bottom)
//        }
    }
}

// MARK: - 顶部 头部 WeitoutiaoHeaderViewDelegate
extension WeiTouTiaoViewController: WeitoutiaoHeaderViewDelegate {
    // 文字按钮点击了
    func headerViewTextButtonClicked() {
        let storyboard = UIStoryboard(name: "WeiTouTiaoHeader", bundle: nil)
        let textVC = storyboard.instantiateViewController(withIdentifier: "TextNavigationController") as! MyNavigationController
        present(textVC, animated: true, completion: nil)
    }
    
    // 图片按钮点击了
    func headerViewImageButtonClicked() {
        
    }
    
    // 视频按钮点击了
    func headerViewVideoButtonClicked() {
        
    }
}

// MARK: - UITableViewDelegate
extension WeiTouTiaoViewController: UITableViewDelegate, UITableViewDataSource {
    /// UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return microNews.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let weitoutiao = microNews[indexPath.row]
        return weitoutiao.cellH!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(String(describing: WeiTouTiaoCell.self), owner: nil, options: nil)?.last as! WeiTouTiaoCell
        cell.weitoutiao = microNews[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    /// UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if case 0...kWeiTouTiaoHeaderHieght = offsetY { // 向上滑动
            bgView.snp.updateConstraints({ (make) in
                make.top.equalTo(view).offset(kNavBarHeight - offsetY)
            })
        } else if offsetY > kWeiTouTiaoHeaderHieght {
            bgView.snp.updateConstraints({ (make) in
                make.top.equalTo(view).offset(-kWeiTouTiaoHeaderHieght)
            })
        }
    }
}

// MARK: - WeitoutiaoCellDelegate cell
extension WeiTouTiaoViewController: WeitoutiaoCellDelegate {
    
    /// cell 顶部用户名区域点击
    func weiTouTiaoCellofHeaderButtonClicked(weitoutiao: WeiTouTiao) {
        let userVC = FollowDetailViewController()
        if let user = weitoutiao.user {
            userVC.userid = user.user_id!
        } else if let user_info = weitoutiao.user_info {
            userVC.userid = user_info.user_id!
        }
        navigationController?.pushViewController(userVC, animated: true)
    }
    
    /// 转发按钮点击
    func weiTouTiaoCelloffeedShareButtonClicked(weitoutiaoCell: WeiTouTiaoCell) {
        let storyboard = UIStoryboard(name: "WeiTouTiaoHeader", bundle: nil)
        let feedShareVC = storyboard.instantiateViewController(withIdentifier: "FeedShareViewController") as! FeedShareViewController
        let weitoutiao = weitoutiaoCell.weitoutiao
        if weitoutiao!.title!.isEqual(to: "") {
            feedShareVC.content = String(describing: weitoutiao!.content!)
        } else {
            feedShareVC.content = String(describing: weitoutiao!.title!)
        }
        if let video_detail_info = weitoutiao?.video_detail_info {
            let detail_video_large_image = video_detail_info.detail_video_large_image
            feedShareVC.thumbImageURL = detail_video_large_image?.url
        }
        let navigationVC = MyNavigationController(rootViewController: feedShareVC)
        present(navigationVC, animated: true, completion: nil)
    }
}
