//
//  NotNetworkView.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/6/14.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class NotNetworkView: UIView {

    class func noNetworkView() -> NotNetworkView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! NotNetworkView
    }

}
