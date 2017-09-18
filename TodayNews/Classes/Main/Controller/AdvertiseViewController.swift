//
//  AdvertiseViewController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/26.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class AdvertiseViewController: UIViewController {
    /// 延迟 2 秒
    private var time: TimeInterval = 4.0
    
    private var countdownTimer: Timer?
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        if time == 0 {
            countdownTimer?.invalidate()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = sb.instantiateViewController(withIdentifier: String(describing: MyTabBarController.self)) as! MyTabBarController
            tabBarVC.delegate = self
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        } else {
            time -= 1
            timeButton.setTitle(String(format: "%.0f s 跳过", time), for: .normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeButtonClicked(_ sender: Any) {
        countdownTimer?.invalidate() // 移除计时器
        /// 从 sb 创建的 tabbarController 设置代理无效...
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = sb.instantiateViewController(withIdentifier: String(describing: MyTabBarController.self))as! MyTabBarController
        tabBarVC.delegate = self
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
    }
}

// MARK: - 监听 tabbar 点击
extension AdvertiseViewController: UITabBarControllerDelegate {
    /// 点击了哪个 tabbar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TabBarDidSelectedNotification"), object: nil)
    }
    
}
