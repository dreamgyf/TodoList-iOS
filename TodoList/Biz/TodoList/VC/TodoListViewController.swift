//
//  TodoListViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/22.
//

import UIKit

class TodoListViewController: NSObject {
    
    enum Style {
        case all
        case today
        case finished
        case unfinished
    }
    
    var style: Style {
        didSet {
            refreshData()
        }
    }
    
    var view: UIView
    
    var presentBottom: ((_ vc: UIViewController) -> Void)?
    
    private let vm = TodoListVM()
    
    private var todoListData: [TodoModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.cellIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    init(frame: CGRect) {
        view = UIView(frame: frame)
        style = .all
        super.init()
        
        setupUI()
        setupNotification()
        refreshData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50 + view.bounds.width / 6, right: 0)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .refreshTodoList, object: nil)
    }
    
    @objc
    func refreshData() {
        switch style {
        case .all:
            todoListData = vm.queryAll()
        case .today:
            todoListData = vm.queryByDate(Date())
        case .finished:
            todoListData = vm.queryByStatus(.finished)
        case .unfinished:
            todoListData = vm.queryByStatus(.unfinished)
        }
        tableView.reloadData()
    }

}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentBottom?(EditTodoViewController(data: todoListData[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "删除", handler: { _,_,_ in 
            let data = self.todoListData[indexPath.row]
            self.vm.deleteData(data)
            self.refreshData()
            if let id = data.id {
                TodoLocalNotifactionUtils.removeNotifaction(id: String(id))
            }
        })
        
        action.backgroundColor = UIColor.systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.cellIdentifier) as? TodoListCell else {
            return UITableViewCell()
        }
        
        var data = todoListData[indexPath.row]
        cell.finishAction = {
            data.status = .finished
            self.vm.updateData(data)
            self.refreshData()
        }
        cell.setData(data)
        return cell
    }
    
}
