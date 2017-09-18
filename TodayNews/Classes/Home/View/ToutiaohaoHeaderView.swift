//
//  ToutiaohaoHeaderView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/7/8.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import SnapKit

protocol ToutiaohaoHeaderViewDelegate {
    func toutiaohaoHeaderViewMoreConcernButtonClicked()
}

class ToutiaohaoHeaderView: UIView {

    var delegate: ToutiaohaoHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(moreButton)
        
    }
    
    fileprivate lazy var moreButton: UIButton = {
        let moreButton = UIButton(frame: CGRect(x: 10, y: 10, width: screenWidth - 20, height: 36))
        moreButton.addTarget(self, action: #selector(moreConcernButtonClicked), for: .touchUpInside)
        moreButton.setTitle(" 关注更多头条号", for: .normal)
        moreButton.setTitleColor(UIColor(r: 230, g: 7, b: 20), for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreButton.setImage(UIImage(named: "addpgc_subscribe_16x16_"), for: .normal)
        moreButton.layer.borderColor = UIColor(r: 235, g: 235, b: 235).cgColor
        moreButton.layer.borderWidth = 1
        moreButton.layer.cornerRadius = 5;
        moreButton.layer.masksToBounds = true
        return moreButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moreConcernButtonClicked() {
        delegate?.toutiaohaoHeaderViewMoreConcernButtonClicked()
    }

}
