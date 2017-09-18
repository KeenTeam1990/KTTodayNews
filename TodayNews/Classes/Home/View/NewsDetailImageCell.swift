//
//  NewsDetailImageCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/4.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol NewsDetailImageCellDelegate: class {
    func imageViewLongPressGestureRecognizer()
}

class NewsDetailImageCell: UICollectionViewCell {
    
    weak var delegate: NewsDetailImageCellDelegate?
    
    var index: Int?
    var count: Int?
    
    var abstract: String? {
        didSet {
            let size = CGSize(width: screenWidth - 2 * kMargin, height: CGFloat(MAXFLOAT))
            let abstractHeight = abstract?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil).size.height
            abstractLabelHeight.constant = abstractHeight! + 5
            self.layoutIfNeeded()
            
            let abstractAttributeString = NSAttributedString(string: abstract!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
            
            let countAttributeString = NSMutableAttributedString(string: "/\(count!) ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)])
            countAttributeString.append(abstractAttributeString)
            
            let numberAttributeString = NSMutableAttributedString(string: String(index!), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
            numberAttributeString.append(countAttributeString)
            // 方式2 ，和图片详情控制器里在 scrollView 的的代理里设置二者择一
//            abstractLabel.attributedText = numberAttributeString
        }
    }
    
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longRecognizerEvent))
        imageView.addGestureRecognizer(longRecognizer)
    }
    
    func longRecognizerEvent() {
        delegate?.imageViewLongPressGestureRecognizer()
    }
}
