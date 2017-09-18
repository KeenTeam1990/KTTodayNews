//
//  VerticalButton.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/15.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.textAlignment = .center
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.centerX = self.width * 0.5
        imageView?.y = 10
        imageView?.width = 24
        imageView?.height = imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + 8
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }
    
}
