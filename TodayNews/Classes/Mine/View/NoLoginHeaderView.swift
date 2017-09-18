//
//  NoLoginView.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/13.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit
import IBAnimatable

class NoLoginHeaderView: UIView {
    /// 更多登录方式按钮点击
    @IBOutlet weak var moreLoginButton: AnimatableButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var bgImageView: UIImageView!
    /// 手机按钮
    @IBOutlet weak var mobileButton: UIButton!
    /// 微信按钮
    @IBOutlet weak var wechatButton: UIButton!
    /// QQ 按钮
    @IBOutlet weak var qqButton: UIButton!
    /// 新浪按钮
    @IBOutlet weak var sinaButton: UIButton!
    /// 收藏按钮
    @IBOutlet weak var favoriteButton: UIButton!
    /// 收藏按钮
    @IBOutlet weak var historyButton: UIButton!
    /// 日间/夜间按钮
    @IBOutlet weak var dayOrNightButton: VerticalButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.height = screenHeight * 0.4
        /// 设置主题
        moreLoginButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreLoginButton.theme_setTitleColor("colors.moreLoginColor", forState: .normal)
        favoriteButton.theme_setImage("images.collectionButton", forState: .normal)
        favoriteButton.theme_setTitleColor("colors.black", forState: .normal)
        favoriteButton.theme_backgroundColor = "colors.cellBackgroundColor"
        historyButton.theme_setImage("images.historyButton", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_backgroundColor = "colors.cellBackgroundColor"
        dayOrNightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        dayOrNightButton.theme_setTitleColor("colors.black", forState: .normal)
        dayOrNightButton.theme_backgroundColor = "colors.cellBackgroundColor"
        dayOrNightButton.setTitle("夜间", for: .normal)
        dayOrNightButton.setTitle("日间", for: .selected)
        mobileButton.theme_setImage("images.mobileButton", forState: .normal)
        wechatButton.theme_setImage("images.wechatButton", forState: .normal)
        qqButton.theme_setImage("images.qqButton", forState: .normal)
        sinaButton.theme_setImage("images.sinaButton", forState: .normal)
        dayOrNightButton.isSelected = UserDefaults.standard.bool(forKey: isNight)
        // 设置在x轴的偏移范围
        let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        effectX.maximumRelativeValue = 20
        effectX.minimumRelativeValue = -20
        // 为 stackView 添加运动效果
        stackView.addMotionEffect(effectX)
    }
    
    class func headerView() -> NoLoginHeaderView {
        let headerView = Bundle.main.loadNibNamed(String(describing: self), owner: nil
            , options: nil)?.last as! NoLoginHeaderView
        return headerView
    }
    
    
    @IBAction func dayOrNightButtonClciked(_ sender: VerticalButton) {
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: isNight)
        /// 选中为夜间，默认为日间
        MyTheme.switchNight(sender.isSelected)
    }
    
}
