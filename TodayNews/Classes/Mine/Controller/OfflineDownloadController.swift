//
//  OfflineDownloadController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/16.
//  Copyright © 2017年 hrscy. All rights reserved.
//
//  离线下载
//

import UIKit

class OfflineDownloadController: UITableViewController {
    
    var titles = [TopicTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "离线下载"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下载", style: .plain, target: self, action: #selector(downloadBarButtonItem))
        
        tableView.register(UINib(nibName: String(describing: OfflineDownloadCell.self), bundle: nil), forCellReuseIdentifier: String(describing: OfflineDownloadCell.self))
        NetworkTool.loadHomeTitlesData { (titles) in
            self.titles = titles
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? titles.count : 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OfflineDownloadCell.self), for: indexPath) as! OfflineDownloadCell
        if indexPath.section == 0 {
            cell.topTitle = titles[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

extension OfflineDownloadController {
    @objc fileprivate func downloadBarButtonItem() {
        
    }
}
