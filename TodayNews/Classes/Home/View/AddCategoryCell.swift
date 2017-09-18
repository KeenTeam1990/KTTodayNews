//
//  AddCategoryCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol AddCategoryCellDelagate: class {
    func deleteCategoryButtonClicked(of cell: AddCategoryCell)
}

class AddCategoryCell: UICollectionViewCell {

    weak var delegate: AddCategoryCellDelagate?
    
    var isEdit = false {
        didSet {
            deleteCategoryButton.isHidden = !isEdit
        }
    }
    
    @IBOutlet weak var titleButton: UIButton!
    
    @IBOutlet weak var deleteCategoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteCategoryButtonClicked(_ sender: UIButton) {
        delegate?.deleteCategoryButtonClicked(of: self)
    }
}
