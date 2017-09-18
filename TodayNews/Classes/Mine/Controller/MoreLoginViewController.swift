//
//  MoreLoginViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/14.
//  Copyright © 2017年 杨蒙. All rights reserved.
//
//  更多登录方式 控制器
//

import UIKit
import IBAnimatable

class MoreLoginViewController: AnimatableModalViewController {
    
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var passwordView: UIView!
    /// 顶部标题
    @IBOutlet weak var topLabel: UILabel!
    /// 发送验证码 View
    @IBOutlet weak var verifyCodeView: UIView!
    /// 找回密码 View
    @IBOutlet weak var findPasswordView: UIView!
    /// 手机号
    @IBOutlet weak var mobileTextField: UITextField!
    /// 密码 / 验证码
    @IBOutlet weak var passwordTextField: UITextField!
    /// 发送验证码 按钮
    @IBOutlet weak var sendVerifyCodeButton: AnimatableButton!
    /// 找回密码 按钮
    @IBOutlet weak var findPasswordButton: AnimatableButton!
    /// 未注册手机验证后自动登录
    @IBOutlet weak var middleTipLabel: UILabel!
    /// 登录方式按钮
    @IBOutlet weak var loginModeButton: UIButton!
    /// 进入头条
    @IBOutlet weak var inTouTiaoButton: AnimatableButton!
    /// 阅读按钮
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var readLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置主题
        loginModeButton.setTitle("免密码登录", for: .selected)
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        topLabel.theme_textColor = "colors.black"
        middleTipLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        readLabel.theme_textColor = "colors.black"
        inTouTiaoButton.theme_backgroundColor = "colors.inTouTiaoButtonBackgroundColor"
        readButton.theme_setImage("images.loginReadButton", forState: .normal)
        readButton.theme_setImage("images.loginReadButtonSelected", forState: .selected)
        mobileView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        passwordView.theme_backgroundColor = "colors.loginMobileViewBackgroundColor"
        inTouTiaoButton.theme_setTitleColor("colors.inTouTiaoButtonTextColor", forState: .normal)
    }
    /// 阅读按钮点击
    @IBAction func readButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

extension MoreLoginViewController {
    /// 关闭按钮点击
    @IBAction func closeLoginViewButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 进入头条按钮点击
    @IBAction func goInTouTiaoButtonClicked() {
        
    }
    
    /// 登录方式按钮点击
    @IBAction func loginModeButonClicked(_ sender: UIButton) {
        loginModeButton.isSelected = !sender.isSelected
        verifyCodeView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordTextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "帐号密码登录" : "登录你的头条，精彩永不消失"
    }
}

extension MoreLoginViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
