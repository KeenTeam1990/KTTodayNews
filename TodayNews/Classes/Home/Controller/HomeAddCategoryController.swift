//
//  HomeAddCategoryController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeAddCategoryController: AnimatableModalViewController {
    
    /// 是否编辑
    var isEdit = false
    // 上部 我的频道
    var homeTitles = [TopicTitle]()
    // 下部 频道推荐数据
    var categories = [TopicTitle]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        // 每个 cell 的大小
        layout.itemSize = CGSize(width: (screenWidth - 50) * 0.25, height: 44)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        // 注册 cell 和头部
        collectionView.register(UINib(nibName: String(describing: AddCategoryCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AddCategoryCell.self))
        collectionView.register(UINib(nibName: String(describing: ChannelRecommendCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ChannelRecommendCell.self))
        collectionView.register(UINib(nibName: String(describing: MyChannelReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: MyChannelReusableView.self))
        collectionView.register(UINib(nibName: String(describing: ChannelRecommendReusableView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: ChannelRecommendReusableView.self))
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(longPressRecognizer)
        // 点击首页加号按钮，获取频道推荐数据
        NetworkTool.loadHomeCategoryRecommend { (categories) in
            self.categories = categories
            self.collectionView.reloadData()
        }
    }
    
    lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressTarget))
        return longPress
    }()
    
    @objc fileprivate func longPressTarget(longPress: UILongPressGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "longPressTarget"), object: nil)
        let selectedIndexPath = collectionView.indexPathForItem(at: longPress.location(in: collectionView))
        switch longPress.state {
        case .began:
            if isEdit && selectedIndexPath?.section == 0 { // 选中的是上部的 cell,并且是可编辑状态
                collectionView.beginInteractiveMovementForItem(at: selectedIndexPath!)
            } else { //
                isEdit = true
                collectionView.reloadData()
                if (selectedIndexPath != nil) && (selectedIndexPath?.section == 0) {
                    collectionView.beginInteractiveMovementForItem(at: selectedIndexPath!)
                }
            }
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(longPress.location(in: longPressRecognizer.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    /// 关闭按钮
    @IBAction func closeAddCategoryButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - MyChannelReusableViewDelegate
extension HomeAddCategoryController: MyChannelReusableViewDelegate, AddCategoryCellDelagate {
    /// 删除按钮点击
    func deleteCategoryButtonClicked(of cell: AddCategoryCell) {
        // 上部删除，下部添加
        let indexPath = collectionView.indexPath(for: cell)
        categories.insert(homeTitles[indexPath!.item], at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 1)])
        homeTitles.remove(at: indexPath!.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath!.item, section: 0)])
    }

    /// 编辑按钮点击
    func channelReusableViewEditButtonClicked(_ sender: UIButton) {
        isEdit = sender.isSelected
        collectionView.reloadData()
    }
    
}

extension HomeAddCategoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let myChannelReuseableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: MyChannelReusableView.self), for: indexPath) as! MyChannelReusableView
            myChannelReuseableView.delegate = self
            return myChannelReuseableView
        } else if indexPath.section == 1 {
            let channelreuseableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: ChannelRecommendReusableView.self), for: indexPath) as! ChannelRecommendReusableView
            return channelreuseableView
        }
        return UICollectionReusableView()
    }
    
    
    /// headerView 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 50)
    }
    /// cell 的组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    /// 每组 cell 的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeTitles.count
        } else if section == 1 {
            return categories.count
        }
        return 0
    }
    /// cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  String(describing: AddCategoryCell.self), for: indexPath) as! AddCategoryCell
            let category = homeTitles[indexPath.item]
            cell.isEdit = isEdit
            cell.delegate = self
            cell.titleButton.setTitle(category.name!, for: .normal)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChannelRecommendCell.self), for: indexPath) as! ChannelRecommendCell
            let category = categories[indexPath.item]
            cell.titleButton.setTitle(category.name!, for: .normal)
            return cell
        }
    }
    
    /// 点击了某一个 cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {  // 点击上面一组，不做任何操作，点击下面一组的cell 会添加到上面的组里
            return
        }
        homeTitles.append(categories[indexPath.item]) // 添加
        collectionView.insertItems(at: [IndexPath(item: homeTitles.count - 1, section: 0)])
        categories.remove(at: indexPath.item)
        collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: 1)])
    }
    /// 移动 cell
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard !isEdit || sourceIndexPath.section == 1 else {
            return
        }
        /// 需要移动的 cell
        let tempArray: NSMutableArray = homeTitles as! NSMutableArray
        tempArray.exchangeObject(at: sourceIndexPath.item, withObjectAt: destinationIndexPath.item)
        collectionView.reloadData()
    }
    
    /// 每个 cell 之间的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            dismiss(animated: true, completion: nil)
        }
    }
}
