//
//  MenuViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    private lazy var itemAll: MenuItemView = {
        let item = MenuItemView()
        item.label.text = "全部"
        item.action = {
            self.doAction(style: .all)
        }
        return item
    }()
    
    private lazy var itemToday: MenuItemView = {
        let item = MenuItemView()
        item.label.text = "今日"
        item.action = {
            self.doAction(style: .today)
        }
        return item
    }()
    
    private lazy var itemFinished: MenuItemView = {
        let item = MenuItemView()
        item.label.text = "已完成"
        item.action = {
            self.doAction(style: .finished)
        }
        return item
    }()
    
    private lazy var itemUnfinished: MenuItemView = {
        let item = MenuItemView()
        item.label.text = "未完成"
        item.action = {
            self.doAction(style: .unfinished)
        }
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        edgesForExtendedLayout = [.left, .right]
        view.backgroundColor = UIColor.white
        
        view.addSubview(itemAll)
        itemAll.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalToSuperview()
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor(hexString: "#E6E6E7")
        view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(itemAll.snp.bottom)
        }
        
        view.addSubview(itemToday)
        itemToday.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(line1.snp.bottom)
        }
        
        let line2 = UIView()
        line2.backgroundColor = UIColor(hexString: "#E6E6E7")
        view.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(itemToday.snp.bottom)
        }
        
        view.addSubview(itemFinished)
        itemFinished.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(line2.snp.bottom)
        }
        
        let line3 = UIView()
        line3.backgroundColor = UIColor(hexString: "#E6E6E7")
        view.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(itemFinished.snp.bottom)
        }
        
        view.addSubview(itemUnfinished)
        itemUnfinished.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(line3.snp.bottom)
        }
    }
    
    var action: ((_ style: TodoListViewController.Style) -> Void)?
    
    private func doAction(style: TodoListViewController.Style) {
        if let action = action {
            action(style)
        }
        dismiss(animated: true, completion: nil)
    }
}
