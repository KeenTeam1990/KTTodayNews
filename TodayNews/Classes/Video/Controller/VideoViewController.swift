//
//  VideoViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/7.
//  Copyright © 2017年 hsrcy. All rights reserved.
//
// 2.视频 控制器
import UIKit

protocol VideoViewControllerDelegate : class {
    func videoViewController(_ videoViewController : VideoViewController, targetIndex : Int)
}

class VideoViewController: UIViewController {
    
    weak var delegate: VideoViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScroll: Bool = false
    
    var titles = [TopicTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        NetworkTool.loadVideoTitlesData { (videoTitles, videoTopicVCs) in
            self.titles = videoTitles
            self.titleView.titles = videoTitles
            for childVC in videoTopicVCs {
                self.addChildViewController(childVC)
            }
            self.collectionView.reloadData()
        }
    }
    
    fileprivate lazy var titleView: VideoTitleView = {
        let titleView = VideoTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "VideoTopicViewCell")
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - setupUI
extension VideoViewController {
    // 设置 UI
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.globalBackgroundColor()
        // 设置导航栏颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.otherNavBarTintColor"
        navigationController?.navigationBar.shadowImage = UIImage()
        // 不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        // 设置标题view
        navigationItem.titleView = titleView
        delegate = titleView
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(kNavBarHeight)
            make.left.bottom.right.equalTo(view)
        }
        
    }
}

extension VideoViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoTopicViewCell", for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        let childVc = childViewControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK:- UICollectionView的delegate
extension VideoViewController : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        } else {
            scrollView.isScrollEnabled = false
        }
    }
    
    private func contentEndScroll() {
        // 获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        // 通知titleView进行调整
        delegate?.videoViewController(self, targetIndex: currentIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
}

// MARK:- 遵守HYTitleViewDelegate
extension VideoViewController : VideoTitleViewDelegate {
    func titleView(_ titleView: VideoTitleView, targetIndex : Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    /// 顶部搜索按钮点击
    func videoTitle(videoTitle: VideoTitleView, didClickSearchButton searchButton: UIButton) {
        
    }
}
