//
//  FollowDetailViewController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/25.
//  Copyright © 2017年 hrscy. All rights reserved.
//
//  关注详情
//

import UIKit
import IBAnimatable

class FollowDetailViewController: AnimatableModalViewController {
    
    var followDetail: FollowDetail?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    var userid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NetworkTool.loadOneFollowDetail(userId: userid) { (followDetail) in
            self.followDetail = followDetail
            self.headerView.follewDetail = followDetail
            self.navView.titleLabel.text = followDetail.screen_name!
            for toptab in followDetail.top_tab {
                let topTabVC = TopTabViewController()
                topTabVC.topTab = toptab
                self.addChildViewController(topTabVC)
            }
            self.scrollView.addSubview(self.pageContentView)
            
            self.pageContentView.snp.makeConstraints { (make) in
                make.top.equalTo(self.headerView.snp.bottom)
                make.left.right.bottom.equalTo(self.scrollView)
            }
        }
    }
    
    /// 导航条
    fileprivate lazy var navView: ConcernNavigationView = {
        let navView = ConcernNavigationView.concernNavView()
        navView.delegate = self
        return navView
    }()
    
    /// 头部
    fileprivate lazy var headerView: ConcernHeaderView = {
        let headerView = ConcernHeaderView.headerView()
        return headerView
    }()
    
    /// scrolView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 设置分页
    fileprivate lazy var pageContentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)//上左下右
        //定义每个UICollectionView 横向的间距
        layout.minimumLineSpacing = 0
        //定义每个UICollectionView 纵向的间距
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - kTabBarHeight)
        let pageContentView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        pageContentView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FollowDetailTopTabCell")
        pageContentView.delegate = self
        pageContentView.dataSource = self
        return pageContentView
    }()
}

extension FollowDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followDetail!.top_tab.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowDetailTopTabCell", for: indexPath)
        let topTabVC = childViewControllers[indexPath.row] as! TopTabViewController
        cell.contentView.addSubview(topTabVC.view)
        topTabVC.view.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(cell)
        }
        return cell
    }
}

extension FollowDetailViewController {
    
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 200)
        
        view.addSubview(navView)
    }
}

// MARK: - ConcernNavigationViewDelegate
extension FollowDetailViewController: ConcernNavigationViewDelegate {
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

// MARK: - UIScrollViewDelagate
extension FollowDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY < 0 {
            let totalOffset = kConcernHeaderViewHieght + abs(offsetY)
            let f = totalOffset / kConcernHeaderViewHieght
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
            navView.backgroundColor = UIColor.clear
        }
        if offsetY > 0 && offsetY <= kConcernHeaderViewHieght * 0.24 {
            var alpha = offsetY / kNavBarHeight
            alpha = min(alpha, 1)
            navView.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            if alpha >= 1 {
                navView.returnButton.setImage(UIImage(named: "lefterbackicon_titlebar_24x24_"), for: .normal)
                navView.moreButton.setImage(UIImage(named: "More_24x24_"), for: .normal)
            } else {
                navView.returnButton.setImage(UIImage(named: "leftbackicon_white_titlebar_24x24_"), for: .normal)
                navView.moreButton.setImage(UIImage(named: "more_titlebar_24x24_"), for: .normal)
            }
            headerView.concernButton.isHidden = false
            navView.concernButton.isHidden = true
            navView.titleLabel.isHidden = true
        } else if offsetY > kConcernHeaderViewHieght * 0.24 {
            headerView.concernButton.isHidden = true
            navView.concernButton.isHidden = false
            navView.titleLabel.isHidden = false
        }
    }
}


