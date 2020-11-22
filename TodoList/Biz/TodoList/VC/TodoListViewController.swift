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
    
    var style: Style
    
    var view: UIView
    
    private let vm = TodoListVM()
    
    private var todoListData: [TodoModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.cellIdentifier)
        return tableView
    }()

    init(frame: CGRect) {
        view = UIView(frame: frame)
        style = .all
        super.init()
        
        setupUI()
        refreshData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50 + view.bounds.width / 6, right: 0)
    }
    
    func refreshData() {
        todoListData = vm.fetchTodoListData()
    }

}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //todo click event
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
        cell.setData(todoListData[indexPath.row])
        return cell
    }
    
}
