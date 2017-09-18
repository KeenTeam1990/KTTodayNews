//
//  NewsDetailImageCommentController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/5.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import IBAnimatable
import RxSwift
import RxCocoa
import MJRefresh
import SVProgressHUD

class NewsDetailImageCommentController: AnimatableModalViewController {

    fileprivate let disposeBag = DisposeBag()
    
    var comments = [NewsDetailImageComment]()
    
    var weitoutiao: WeiTouTiao? {
        didSet {
            NetworkTool.loadNewsDetailImageComments(offset: 0, item_id: weitoutiao!.item_id!, group_id: weitoutiao!.group_id!) { (comments) in
                self.comments = comments
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NewsDetailImageCommentController {
    
    fileprivate func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String( describing: NewsDetailImageCommentCell.self), bundle: nil), forCellReuseIdentifier: String( describing: NewsDetailImageCommentCell.self))
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            // 获取评论数据
            NetworkTool.loadNewsDetailImageComments(offset: self!.comments.count, item_id: self!.weitoutiao!.item_id!, group_id: self!.weitoutiao!.group_id!) { (comments) in
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
    }
    
    /// 关闭评论按钮点击
    @IBAction func closeCommentButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 写评论按钮点击
    @IBAction func writeNewCommentButtonClicked(_ sender: UIButton) {
        
    }
}

extension NewsDetailImageCommentController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let comment = comments[indexPath.row]
        
        return comment.cellHeight!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: NewsDetailImageCommentCell.self), for: indexPath) as! NewsDetailImageCommentCell
        cell.comment = comments[indexPath.row]
        
        cellClickedEvent(cell: cell)
        return cell
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
