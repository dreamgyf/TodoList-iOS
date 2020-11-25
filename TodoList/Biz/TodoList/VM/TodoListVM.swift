//
//  MainViewVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//
import Foundation

class TodoListVM {
    
    func queryAll() -> [TodoModel] {
        return TodoModel.queryAll()
    }
    
    func queryByStatus(_ status: TodoModel.Status) -> [TodoModel] {
        return TodoModel.queryByStatus(status)
    }
    
    func queryByDate(_ date: Date) -> [TodoModel] {
        return TodoModel.queryByDate(date)
    }
    
    func updateData(_ data: TodoModel) {
        TodoModel.updateData(data)
    }
    
    func deleteData(_ data: TodoModel) {
        TodoModel.deleteData(data)
    }
}
