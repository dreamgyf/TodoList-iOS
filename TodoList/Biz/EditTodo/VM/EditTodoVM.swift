//
//  EditTodoVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//
import FMDB

class EditTodoVM {
    
    func saveData(_ model: TodoModel) {
        TodoModel.saveData(model)
    }
    
    func updateData(_ model: TodoModel) {
        TodoModel.updateData(model)
    }
}
