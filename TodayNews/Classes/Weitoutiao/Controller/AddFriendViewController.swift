//
//  AddFriendViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/12.
//  Copyright © 2017年 杨蒙. All rights reserved.
//
//  添加朋友 控制器

import UIKit
import SnapKit

class AddFriendViewController: UIViewController, UIWebViewDelegate {
    
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request)
        return true
    }
    
}

extension AddFriendViewController {
    
    /// 马上登录按钮点击
    @IBAction func loginButtonClicked() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moreLoginVC = storyboard.instantiateViewController(withIdentifier: "LoginPopViewController") as! LoginPopViewController
        moreLoginVC.modalSize = (width: .custom(size: Float(screenWidth - 76)), height: .custom(size: Float(screenHeight - 262)))
        present(moreLoginVC, animated: true, completion: nil)
    }
}
