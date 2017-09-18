//
//  DislikePopView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import SVProgressHUD

class DislikePopView: UIView {
    
    var filterWords = [WTTFilterWord]() {
        didSet {
            // 40 + 40 + 1
            self.popViewHeight.constant = 81 + CGFloat(filterWords.count * 40)
            self.layoutIfNeeded()
            tableView.reloadData()
        }
    }

    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var popViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = screenWidth
        self.height = screenHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: DislikeCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DislikeCell.self))
    }
    
    class func popView() -> DislikePopView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! DislikePopView
    }
    
    func show() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.bottomMargin.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.bottomMargin.constant = -self.popViewHeight.constant
            self.layoutIfNeeded()
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    /// 完成按钮点击
    @IBAction func finishButtonClicked(_ sender: UIButton) {
        dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
}

extension DislikePopView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DislikeCell.self), for: indexPath) as! DislikeCell
        let word = filterWords[indexPath.row]
        cell.wordLabel.text = word.name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DislikeCell.self), for: indexPath) as! DislikeCell
        SVProgressHUD.showInfo(withStatus: cell.wordLabel.text!)
        dismiss()
    }
}
