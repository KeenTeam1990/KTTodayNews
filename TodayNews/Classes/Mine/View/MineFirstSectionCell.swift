//
//  MineFirstSectionCell.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/6/22.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

protocol MineFirstSectionCellDelegate: class {
    /// 点击了 第一个 cell 的标题
    func mineFirstSectionCellTitleButtonClicked()
    /// 点击了第几个关注
    func mineFirstSectionCellDidSelected(myConcern: MyConcern)
}

class MineFirstSectionCell: UITableViewCell {

    weak var delegate: MineFirstSectionCellDelegate?
    
    /// 标题
    @IBOutlet weak var leftlabel: UILabel!
    /// 如果有一个关注，头像显示在右边
    @IBOutlet weak var concernImageView: UIImageView!
    /// 右侧标签
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var rightTipImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var separatorView: UIView!
    
    var mineCellModel: MineCellModel? {
        didSet {
            leftlabel.text = mineCellModel?.text!
        }
    }
    
    var myConcern: MyConcern? {
        didSet {
            rightLabel.text = myConcern?.name!
            concernImageView.kf.setImage(with: URL(string: (myConcern?.icon!)!))
        }
    }
    
    var concerns = [MyConcern]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 设置主题
        separatorView.theme_backgroundColor = "colors.separatorColor"
        leftlabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        rightTipImageView.theme_image = "images.arrowMoreLogin"
        contentView.theme_backgroundColor = "colors.cellBackgroundColor"
        
        self.collectionView.collectionViewLayout = MyConcernFlowLayout()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: MyConcernCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MyConcernCell.self))
        self.collectionView.collectionViewLayout = MyConcernFlowLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func titleButtonClicked() {
        delegate?.mineFirstSectionCellTitleButtonClicked()
    }
}

extension MineFirstSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return concerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyConcernCell.self), for: indexPath) as! MyConcernCell
        cell.myConcern = concerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myConcern = concerns[indexPath.row]
        delegate?.mineFirstSectionCellDidSelected(myConcern: myConcern)
    }
    
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        itemSize = CGSize(width: 58, height: 73)
        //定义每个UICollectionView 横向的间距
        minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        scrollDirection = .horizontal
    }
}


