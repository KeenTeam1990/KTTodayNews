//
//  SettingViewController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/15.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UITableViewController {

    var settings = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        // 从沙盒读取缓存数据的大小
        calcuateCacheSizeFromSandBox()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension SettingViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let setting = settings[section] as! [SettingModel]
        return setting.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self), for: indexPath) as! SettingCell
        let cellArray = settings[indexPath.section] as! [SettingModel]
        cell.setting = cellArray[indexPath.row]
        if indexPath.section == 0 {
            if indexPath.row == 0 { // 清理缓存
                NotificationCenter.default.addObserver(self, selector: #selector(loadCacheSize), name: NSNotification.Name(rawValue: "cacheSizeM"), object: nil)
            } else if indexPath.row == 1 { // 字体大小
                NotificationCenter.default.addObserver(self, selector: #selector(changeFontSize), name: NSNotification.Name(rawValue: "fontSize"), object: nil)
            } else if indexPath.row == 3 { //  非 WiFi 网络流量
                NotificationCenter.default.addObserver(self, selector: #selector(changeNeworkMode), name: NSNotification.Name(rawValue: "networkMode"), object: nil)
            } else if indexPath.row == 4 { //  非 WiFi 播放提醒
                NotificationCenter.default.addObserver(self, selector: #selector(changePlayNotice), name: NSNotification.Name(rawValue: "playNotice"), object: nil)
            } else if indexPath.row == 5 { // 推送
                cell.selectionStyle = .none
            }
        } else if indexPath.section == 1 {
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // 清除缓存
                clearCacheAlertController()
            } else if indexPath.row == 1 {
                // 设置字体大小
                setupFontAlertController()
            } else if indexPath.row == 3 {
                // 网络流量
                setupNetworkAlertController()
            } else if indexPath.row == 4 { // 播放提醒
                // 设置播放提醒
                setupPlayNoticeAlertController()
            } else if indexPath.row == 5 { // 推送通知
                let url = URL(string: UIApplicationOpenSettingsURLString)
                UIApplication.shared.openURL(url!)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                navigationController?.pushViewController(OfflineDownloadController(), animated: true)
            }
        }
    }
}

extension SettingViewController {
    
    fileprivate func setupUI() {
        navigationItem.title = "设置"
        tableView.rowHeight = 44
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.tableFooterView = UIView()
        // 从 plist 加载数据
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!)! as [AnyObject]
        for arrayDict in cellPlist {
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let cell = SettingModel(dict: dict as! [String: AnyObject])
                sections.append(cell)
            }
            settings.append(sections as AnyObject)
        }
        tableView.register(UINib(nibName: String(describing: SettingCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SettingCell.self))
    }
    /// 从沙盒读取缓存数据的大小
    fileprivate func calcuateCacheSizeFromSandBox() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            // 转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.2fM", sizeM)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        }
    }
    /// 获取缓存大小
    @objc fileprivate func loadCacheSize(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["cacheSize"] as? String
    }
    /// 改变字体大小
    @objc fileprivate func changeFontSize(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["fontSize"] as? String
    }
    /// 改变非 wifi 网络流量
    @objc fileprivate func changeNeworkMode(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["networkMode"] as? String
    }
    /// 改变非 wifi 播放提醒
    @objc fileprivate func changePlayNotice(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 4, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["playNotice"] as? String
    }
    /// 清除缓存
    fileprivate func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线内容及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            let sizeString = "0.00M"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 设置字体大小
    fileprivate func setupFontAlertController() {
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "小"])
        })
        let middleAction = UIAlertAction(title: "中", style: .default, handler: { (_) in
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "中"])
        })
        let bigAction = UIAlertAction(title: "大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "大"])
        })
        let largeAction = UIAlertAction(title: "特大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "特大"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        alertController.addAction(bigAction)
        alertController.addAction(largeAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 非 wifi 网络流量
    fileprivate func setupNetworkAlertController() {
        let alertController = UIAlertController(title: "非Wifi网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestFlowAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "最佳效果（下载大图）"])
        })
        let betterFlowAction = UIAlertAction(title: "较省流量（智能下图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "较省流量（智能下图）"])
        })
        let leastFlowAction = UIAlertAction(title: "极省流量（不下载图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "极省流量（不下载图）"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(bestFlowAction)
        alertController.addAction(betterFlowAction)
        alertController.addAction(leastFlowAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 设置播放提醒
    fileprivate func setupPlayNoticeAlertController() {
        let alertController = UIAlertController(title: "非Wifi网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestFlowAction = UIAlertAction(title: "提醒一次", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playNotice"), object: self, userInfo: ["playNotice": "提醒一次"])
        })
        let betterFlowAction = UIAlertAction(title: "每次提醒", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playNotice"), object: self, userInfo: ["playNotice": "每次提醒"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(betterFlowAction)
        alertController.addAction(bestFlowAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
