//
//  ThumbCollectionView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/16.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class ThumbCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func collectionViewWithFrame(frame: CGRect) -> ThumbCollectionView {
        let layout = CollectionViewFlowLayout()
        return ThumbCollectionView(frame: frame, collectionViewLayout: layout)
    }
    

}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        //定义每个UICollectionView 的大小
//        let itemWidth = (screenWidth - kMargin * 2 - 12) / 3
//        itemSize = CGSize(width: itemWidth, height: itemWidth)
        //定义每个UICollectionView 横向的间距
        minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        self.sectionInset = UIEdgeInsetsMake(0, 3, 3, 3);//上左下右
    }
    
    
}
