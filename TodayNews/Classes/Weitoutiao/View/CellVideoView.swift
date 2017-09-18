//
//  CellVideoView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/17.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class CellVideoView: UIView {

    @IBOutlet weak var imageButton: UIButton!
    
    class func cellVideoView() -> CellVideoView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! CellVideoView
    }

}
