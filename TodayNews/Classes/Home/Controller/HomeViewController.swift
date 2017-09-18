//
//  HomeViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/7.
//  Copyright © 2017年 hrscy. All rights reserved.
//
// 1.首页 控制器

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置导航栏颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.homeNavBarTintColor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.globalBackgroundColor()
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        // 自定义导航栏
        navigationItem.titleView = homeNavigationBar
        
        automaticallyAdjustsScrollViewInsets = false
        
        /// 获取标题数据
        NetworkTool.loadHomeTitlesData(fromViewController: String(describing: HomeViewController.self)) { (topTitles, homeTopicVCs) in
            // 将所有子控制器添加到父控制器中
            for childVc in homeTopicVCs {
                self.addChildViewController(childVc)
            }
            self.setupUI()
            
            self.pageView.titles = topTitles
            self.pageView.childVcs = self.childViewControllers as? [TopicViewController]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate lazy var pageView: HomePageView = {
        let pageView = HomePageView()
        return pageView
    }()
    
    // 自定义导航栏
    fileprivate lazy var homeNavigationBar: HomeNavigationBar = {
        let homeNavigationBar = HomeNavigationBar()
        homeNavigationBar.searchBar.delegate = self
        return homeNavigationBar
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(pageView)
        
        pageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view).offset(kNavBarHeight)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeTitleAddButtonClicked(notification:)), name: NSNotification.Name(rawValue: "homeTitleAddButtonClicked"), object: nil)
    }
    
    /// 点击了加号按钮
    func homeTitleAddButtonClicked(notification: Notification) {
        let titles = notification.object as! [TopicTitle]
        
        let storyboard = UIStoryboard(name: "HomeAddCategoryController", bundle: nil)
        let homeAddCategoryVC = storyboard.instantiateViewController(withIdentifier: "HomeAddCategoryController") as! HomeAddCategoryController
        homeAddCategoryVC.homeTitles = titles
        homeAddCategoryVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - 20)))
        present(homeAddCategoryVC, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    /// UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationController?.pushViewController(HomeSearchViewController(), animated: false)
        return true
    }
}
