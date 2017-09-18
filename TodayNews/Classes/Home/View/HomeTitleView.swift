//
//  HomeTitleView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/5.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeTitleViewDelegate: class {
    func titleView(_ titleView: HomeTitleView, targetIndex : Int)
}

class HomeTitleView: UIView {

    weak var delegate: HomeTitleViewDelegate?
    
    var titles: [TopicTitle]? {
        didSet {
            // 将titleLabel添加到UIScrollView中
            setupTitleLabels()
            // 设置titleLabel的frame
            setupTitleLabelsFrame()
        }
    }
    
    fileprivate lazy var currentIndex : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = "colors.cellBackgroundColor"
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 标题数组
    fileprivate lazy var titleLabels = [HomeTitleLabel]()
    /// 滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth - 40, height: 40))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    /// 底部滚动指示器
    fileprivate lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.globalRedColor()
        bottomLine.height = 2
        bottomLine.y = 37
        return bottomLine
    }()
    
    // 懒加载 右侧按钮
    fileprivate lazy var rightButton: UIButton = {
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: screenWidth - 40, y: 0, width: 40, height: 40)
        rightButton.theme_setImage("images.addChannelTitlbar", forState: .normal)
        rightButton.theme_setBackgroundImage("images.shadowAddTitlebar", forState: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        return rightButton
    }()
    /// 底部分割线
    fileprivate lazy var bottomLineView: UIView = {
        let bottomLineView = UIView(frame: CGRect(x: 0, y: 39, width: screenWidth, height: 1))
        bottomLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return bottomLineView
    }()

}

extension HomeTitleView {
    func setupUI() {
        // 将UIScrollVIew添加到view中
        addSubview(scrollView)
        addSubview(rightButton)
        addSubview(bottomLineView)
        // 添加滚动条
        scrollView.addSubview(bottomLine)
    }
    
    /// 将titleLabel添加到UIScrollView中
    fileprivate func setupTitleLabels() {
        for (index, topTitle) in titles!.enumerated() {
            let titleLabel = HomeTitleLabel()
            titleLabel.text = topTitle.name
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.tag = index
            titleLabel.textAlignment = .center
            titleLabel.theme_textColor = index == 0 ? "colors.videoNavTitleColorSelect" : "colors.black"
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func setupTitleLabelsFrame() {
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = 40
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            let topTitle = titles![i]
            
            w = (topTitle.name! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
            if i == 0 {
                x = kMargin * 0.5
                bottomLine.x = x
                bottomLine.width = w
            } else {
                let preLabel = titleLabels[i - 1]
                x = preLabel.frame.maxX + kMargin
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + kMargin * 0.5, height: 0)
    }
    
}

// MARK:- 监听事件
extension HomeTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        // 取出用户点击的View
        let targetLabel = tapGes.view as! HomeTitleLabel
        
        // 调整title
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        // 调整bottomLine
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomLine.width = targetLabel.width
            self.bottomLine.centerX = targetLabel.centerX
        })
        
        // 通知代理
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustTitleLabel(targetIndex : Int) {
        
        if targetIndex == currentIndex { return }
        
        // 1.取出Label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        
        // 2.切换文字的颜色
        targetLabel.textColor = UIColor.globalRedColor()
        sourceLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.7)
        sourceLabel.currentScale = 1.0
        targetLabel.currentScale = 1.1
        
        // 调整bottomLine
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomLine.centerX = targetLabel.centerX
            self.bottomLine.width = targetLabel.width
        })
        
        // 3.记录下标值
        currentIndex = targetIndex
        
        // 4.调整位置
        // 当前偏移量
        var offsetX = targetLabel.centerX - scrollView.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        // 最大偏移量
        var maxOffsetX = scrollView.contentSize.width - scrollView.width
        
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    /// 右侧按钮点击
    @objc fileprivate func rightButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homeTitleAddButtonClicked"), object: titles)
    }
}

// MARK:- 遵守HYContentViewDelegate
extension HomeTitleView : HomePageViewDelegate {
    
    func pageView(_ pageView: HomePageView, targetIndex: Int) {
        
        adjustTitleLabel(targetIndex: targetIndex)

    }
    
}

private class HomeTitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
