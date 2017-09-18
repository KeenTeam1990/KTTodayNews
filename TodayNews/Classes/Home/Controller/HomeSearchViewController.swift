//
//  HomeSearchViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//
//  首页顶部搜索框

import UIKit
import SnapKit

class HomeSearchViewController: UITableViewController {
    
    var weitoutiaos = [WeiTouTiao]()
    
    var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    // 导航栏
    fileprivate lazy var searchNavigationView: SearchNavigationView = {
        let searchNavigationView = SearchNavigationView()
        searchNavigationView.delegate = self
        return searchNavigationView
    }()
    
    // 搜索界面默认的背景
    fileprivate lazy var searchDefaultBGView: SearchDefaultBackgroundView = {
        let searchDefaultBGView = SearchDefaultBackgroundView.defaultBackgroundView()
        searchDefaultBGView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 180)
        return searchDefaultBGView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
    }
}

extension HomeSearchViewController {
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        // 隐藏返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        // 设置自定义导航视图
        navigationItem.titleView = searchNavigationView
        // 添加背景 View
        tableView.addSubview(searchDefaultBGView)
        tableView.tableFooterView = UIView()
        
        NetworkTool.loadSearchResult(keyword: "", offset: offset) { (weitoutiaos) in
            self.weitoutiaos = weitoutiaos
            self.tableView.reloadData()
        }
    }
}

// MARK: - SearchNavigationViewDelegate
extension HomeSearchViewController: SearchNavigationViewDelegate, UITextFieldDelegate {
    /// 导航栏取消按钮点击
    func cancelButtonClicked() {
        navigationController?.popViewController(animated: false)
    }
    
}

