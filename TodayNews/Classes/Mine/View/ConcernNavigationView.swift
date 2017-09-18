//
//  ConcernNavigationView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/28.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol ConcernNavigationViewDelegate: class {
    
    func concernHeaderViewReturnButtonClicked()
    
    func concernHeaderViewMoreButtonClicked()
}

class ConcernNavigationView: UIView {
    
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bottomLine: UIView!
    
    weak var delegate: ConcernNavigationViewDelegate?
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    /// 返回按钮
    @IBOutlet weak var returnButton: UIButton!
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    
    class func concernNavView() -> ConcernNavigationView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! ConcernNavigationView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        concernButton.layer.borderColor = UIColor.lightGray.cgColor
        concernButton.layer.borderWidth = 1
        width = screenWidth
        height = 64
    }
    
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        delegate?.concernHeaderViewReturnButtonClicked()
    }
    
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        delegate?.concernHeaderViewMoreButtonClicked()
    }
    
}
