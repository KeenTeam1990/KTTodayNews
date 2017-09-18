//
//  QuestionHeaderView.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/19.
//  Copyright © 2017年 hrscy. All rights reserved.
//
// 当没有图片的时候高度为 155
// 如果相关标签没有数据，scrollView 的高度设置为 0，否则 45
// 底部 view 高度 85

import UIKit

class QuestionHeaderView: UIView {
    
    var question: Question? {
        didSet {
            /// 设置顶部标签数据
            if question?.concern_tag_list.count == 0 {
                scrollViewHeight.constant = 0
            } else { // > 0
                scrollViewHeight.constant = 45
                for (index, concernTag) in question!.concern_tag_list.enumerated() {
                    let button = UIButton(type: .custom)
                    button.setTitle(concernTag.name, for: .normal)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//                    button.addTarget(self, action: #selector(labelButtonClciked), for: .touchUpInside)
                    button.backgroundColor = UIColor.globalBackgroundColor()
                    button.layer.cornerRadius = 5
                    button.layer.masksToBounds = true
                    let width: CGFloat = 65
                    let height:CGFloat = 30
                    button.frame = CGRect(x: CGFloat(index) * (width + 5), y: 0, width: width, height: height)
                    scrollView.addSubview(button)
                    if index == question!.concern_tag_list.count - 1 {
                        scrollView.contentSize = CGSize(width: button.frame.maxX, height: scrollView.height)
                    }
                }
            }
            /// 设置问题的标题
            titleLabel.text = question?.title!
            /// 设置问题的内容
            if question!.content!.text! == "" {
                contentLabelHeight.constant = 0
                unfoldButtonWidth.constant = 0
            } else {
                contentLabel.text = question!.content!.text! as String
                let size = CGSize(width: CGFloat(MAXFLOAT), height: 35)
                let width = question!.content!.text!.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil).size.width
                // 74 = 2X间距 + 展开按钮的宽度
                if width >= screenHeight - 74 {
                    contentLabel.width = screenWidth - 30
                    unfoldButtonWidth.constant = 0
                }
            }
            layoutIfNeeded()
            answerCountLabel.text = "\(question!.answer_count!)"
            concernCountLabel.text = "\(question!.follow_count!)"
        }
    }
    
    /// 相关标签
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    /// 顶部 View
    @IBOutlet weak var topView: UIView!
    /// 中间的 View
    @IBOutlet weak var middleView: UIView!
    /// 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    /// 回答数量
    @IBOutlet weak var answerCountLabel: UILabel!
    /// 关注数量
    @IBOutlet weak var concernCountLabel: UILabel!
    /// 关注问题按钮
    @IBOutlet weak var concernQuestionButton: UIButton!
    /// 邀请回答按钮
    @IBOutlet weak var inviteAnswerButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// 展开按钮点击
    @IBAction func unfoldButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
        contentLabelHeight.constant = question!.content!.textH!
        unfoldButtonWidth.constant = 0
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.height = topView.height + middleView.height + 85
    }
    
    class func headerView() -> QuestionHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! QuestionHeaderView
    }
}
