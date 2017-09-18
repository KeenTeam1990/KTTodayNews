//
//  MyChannelRecommendView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol MyChannelReusableViewDelegate: class {
    /// 编辑按钮点击
    func channelReusableViewEditButtonClicked(_ sender: UIButton)
}

/// 我的频道推荐
class MyChannelReusableView: UICollectionReusableView {

    weak var delegate: MyChannelReusableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editChannelButton.layer.borderColor = UIColor.globalRedColor().cgColor
        editChannelButton.layer.borderWidth = 1
        editChannelButton.setTitle("完成", for: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(longPressTarget), name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
    }
    
    @objc private func longPressTarget() {
        editChannelButton.isSelected = true
    }
    
    @IBOutlet weak var editChannelButton: UIButton!
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.channelReusableViewEditButtonClicked(sender)
    }
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
