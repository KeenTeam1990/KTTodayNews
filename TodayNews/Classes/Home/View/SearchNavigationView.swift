//
//  SearchNavigationView.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/11.
//  Copyright © 2017年 hrscy. All rights reserved.
//
// 搜索界面导航栏
//

import UIKit

protocol SearchNavigationViewDelegate: class {
    func cancelButtonClicked()
}

/// 搜索界面导航栏
class SearchNavigationView: UIView {
    
    weak var delegate: SearchNavigationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    /// 搜索框
    lazy var searchBar: HomeSearchBar = {
        let searchBar = HomeSearchBar.searchBar()
        searchBar.placeholder = "请输入关键字"
        searchBar.theme_tintColor = "colors.black"
        searchBar.background = UIImage(named: UserDefaults.standard.bool(forKey: isNight) ? "searchbox_search_night_20x28_" : "searchbox_search_20x28_")
        return searchBar
    }()
    
    /// 取消按钮
    fileprivate lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor(r: 40, g: 141, b: 206), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return cancelButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchNavigationView {
    
    fileprivate func setupUI() {
        
        // 添加搜索框
        addSubview(searchBar)
        // 添加取消按钮
        addSubview(cancelButton)
        // 搜索框
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.right.equalTo(cancelButton.snp.left).offset(-kMargin)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
        }
        // 取消按钮
        cancelButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-kMargin)
            make.height.equalTo(searchBar)
        }
        searchBar.becomeFirstResponder()
    }
    
    /// 取消按钮点击
    @objc fileprivate func cancelButtonClick() {
        delegate?.cancelButtonClicked()
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            super.frame = newFrame
        }
    }
}

