//
//  SearchDefaultBackgroundView.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class SearchDefaultBackgroundView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func defaultBackgroundView() -> SearchDefaultBackgroundView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! SearchDefaultBackgroundView
    }

}
