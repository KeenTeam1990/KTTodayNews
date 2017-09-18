//
//  TellFriendsViewController.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/12.
//  Copyright © 2017年 杨蒙. All rights reserved.
//
//  告诉朋友 控制器
//

import UIKit

class TellFriendsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TellFriendsViewCell")
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TellFriendsViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.textLabel?.text = "微信告诉朋友"
            cell.imageView?.image = UIImage(named: "weixinicon_invite_26x26_")
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "短信告诉朋友"
            cell.imageView?.image = UIImage(named: "messagesicon_invite_26x26_")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
