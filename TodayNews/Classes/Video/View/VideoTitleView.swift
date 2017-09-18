//
//  YMVideoTitleView.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/17.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit
import SnapKit

protocol VideoTitleViewDelegate: class {
    
    func videoTitle(videoTitle: VideoTitleView, didClickSearchButton searchButton: UIButton)
    /// 点击了标题
    func titleView(_ titleView: VideoTitleView, targetIndex : Int)
}

class VideoTitleView: UIView {
    
    weak var delegate: VideoTitleViewDelegate?
    
    /// 顶部标题数组
    var titles: [TopicTitle]? {
        didSet {
            setupTitleLabels(videoTitles: titles!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate lazy var currentIndex : Int = 0
    
    fileprivate let style = TitleStyle()
    
    /// 设置滚动视图
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    /// 标题数组
    fileprivate lazy var titleLabels = [TitleLabel]()
    /// 顶部搜索按钮
    fileprivate lazy var titleSearchButton: UIButton = {
        let titleSearchButton = UIButton()
        titleSearchButton.addTarget(self, action: #selector(titleSearchButtonClick), for: .touchUpInside)
        titleSearchButton.theme_setImage("images.videoSearchIcon", forState: .normal)
        return titleSearchButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoTitleView {
    
    fileprivate func setupUI() {
        // 添加滚动视图
        addSubview(scrollView)
        // 添加搜索按钮
        addSubview(titleSearchButton)

        scrollView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.right.equalTo(titleSearchButton.snp.left)
        }

        titleSearchButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(40)
        }
    }
    /// 将titleLabel添加到UIScrollView中
    fileprivate func setupTitleLabels(videoTitles: [TopicTitle]) {
        for (index, topTitle) in videoTitles.enumerated() {
            let titleLabel = TitleLabel()
            titleLabel.text = topTitle.name
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.tag = index
            titleLabel.textAlignment = .center
            titleLabel.textColor = index == 0 ? style.selectColor : style.normalColor
            titleLabel.theme_textColor = index == 0 ? "colors.videoNavTitleColorSelect" : "colors.black"
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
        // 设置titleLabel的frame
        setupTitleLabelsFrame(titleLabels: titleLabels, titles: videoTitles)
    }
    /// 调整 label 的 frame
    fileprivate func setupTitleLabelsFrame(titleLabels: [TitleLabel], titles: [TopicTitle]) {
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = bounds.height
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            let topTitle = titles[i]
            
            w = (topTitle.name! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
            if i == 0 {
                x = style.itemMargin * 0.5
            } else {
                let preLabel = titleLabels[i - 1]
                x = preLabel.frame.maxX + style.itemMargin
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + style.itemMargin * 0.5, height: 0)
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            super.frame = newFrame
        }
    }
}

extension VideoTitleView {
    /// 顶部搜索按钮点击
    func titleSearchButtonClick(button: UIButton) {
        delegate?.videoTitle(videoTitle: self, didClickSearchButton: button)
    }
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        // 取出用户点击的View
        let targetLabel = tapGes.view as! TitleLabel
        
        targetLabel.currentScale = 1.1
        
        // 调整title
        adjustTitleLabel(targetIndex: targetLabel.tag)
        // 通知代理
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustTitleLabel(targetIndex : Int) {
        
        if targetIndex == currentIndex { return }
        
        // 1.取出Label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        
        // 2.切换文字的颜色
        targetLabel.textColor = style.selectColor
        sourceLabel.textColor = style.normalColor
        
        // 3.记录下标值
        currentIndex = targetIndex
        
        // 4.调整位置
        var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: true)
    }
}

extension VideoTitleView: VideoViewControllerDelegate {
    func videoViewController(_ videoViewController: VideoViewController, targetIndex: Int) {
        adjustTitleLabel(targetIndex: targetIndex)
    }
}

class TitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
