//
//  ViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let vm = MainViewVM()
    
    private var todoListData: [TodoModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.cellIdentifier)
        return tableView
    }()
    
    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(self.onAddButtonClick), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        refreshData()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.themeColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(6)
            make.height.equalTo(view.snp.width).dividedBy(6)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50 + view.bounds.width / 6, right: 0)
    }


    private func refreshData() {
        todoListData = vm.fetchTodoListData()
    }
    
    @objc
    private func onAddButtonClick() {
        presentFromBottom(AddTodoViewController())
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //todo click event
    }
}

extension MainViewController: UITableViewDataSource {
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
