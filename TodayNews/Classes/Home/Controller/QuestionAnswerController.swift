//
//  QuestionAnswerController.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class QuestionAnswerController: UIViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moreAnswerButton: UIButton!
    @IBOutlet weak var moreImageView: UIImageView!
    
    var topicTitle: TopicTitle?
    
    var weitoutiao: WeiTouTiao?
    
    var answers = [Answer]()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置 UI
        setupUI()
        /// 获取悟空问答数据
        NetworkTool.loadQuestionAnswerList(topicTitle: topicTitle!, weitoutiao: weitoutiao!) { (questionAnswer) in
            let module = questionAnswer.module_list.first
            self.moreImageView.kf.setImage(with: URL(string: module!.day_icon_url!))
            self.moreAnswerButton.setTitle(module!.text!, for: .normal)
            self.headerView.question = questionAnswer.question
            self.answers = questionAnswer.ans_list
            self.tableView.reloadData()
        }
        /// 上拉获取悟空问答更多数据
        
    }
    
    // 懒加载 头部
    fileprivate lazy var headerView : QuestionHeaderView = {
        let headerView = QuestionHeaderView.headerView()
        return headerView
    }()
    
}

extension QuestionAnswerController {
    /// 设置 UI
    fileprivate func setupUI() {
        // 悟空问答图标
        let navImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 20))
        navImageView.theme_image = "images.wukongwenda"
        navigationItem.titleView = navImageView
        /// 右上角更多按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "More_24x24_"), style: .plain, target: self, action: #selector(moreBarButtonItemClicked))
        /// 设置导航栏样式
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.theme_barTintColor = "colors.otherNavBarTintColor"
        /// 设置 tableView
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.rowHeight = 60 // 暂时设为 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: AnswerCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AnswerCell.self))
        
        headerView.concernQuestionButton.rx.controlEvent(.touchUpInside)
                                            .subscribe (onNext: { [weak self] in
                                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                let moreLoginVC = storyboard.instantiateViewController(withIdentifier: "LoginPopViewController") as! LoginPopViewController
                                                moreLoginVC.modalSize = (width: .custom(size: Float(screenWidth - 76)), height: .custom(size: Float(screenHeight - 262)))
                                                self!.present(moreLoginVC, animated: true, completion: nil)
                                            })
                                            .addDisposableTo(disposeBag)
    }
}

extension QuestionAnswerController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AnswerCell.self), for: indexPath) as! AnswerCell
        cell.answer = answers[indexPath.row]
        return cell
    }
}

// MARK: - 按钮点击事件
extension QuestionAnswerController {
    /// 更多按钮点击
    @objc fileprivate func moreBarButtonItemClicked() {
        
    }
    
    /// 左侧按钮点击
    @IBAction func moreAnswerButtonClicked(_ sender: UIButton) {
        
    }
    /// 底部回答按钮点击
    @IBAction func answerButtonClicked(_ sender: UIButton) {
        
    }
}


