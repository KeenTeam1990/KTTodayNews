//
//  LoginPopViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/14.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import IBAnimatable

class LoginPopViewController: AnimatableModalViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 更多登录方式
    @IBAction func moreLoginButtonClicked() {
        let storyboard = UIStoryboard(name: "MoreLoginViewController", bundle: nil)
        let moreLoginVC = storyboard.instantiateViewController(withIdentifier: "MoreLoginViewController") as! MoreLoginViewController
        moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - 40)))
        present(moreLoginVC, animated: true, completion: nil)
    }
    
    /// 关闭按钮点击
    @IBAction func closeLoginPopViewButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}
