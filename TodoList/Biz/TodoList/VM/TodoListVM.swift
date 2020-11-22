//
//  MainViewVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

class TodoListVM {
    
    func fetchTodoListData() -> [TodoModel] {
        var data: [TodoModel] = []
        for _ in 1...20 {
            let item = TodoModel(title: "test title", content: "test content")
            data.append(item)
        }
        return data
    }
}
