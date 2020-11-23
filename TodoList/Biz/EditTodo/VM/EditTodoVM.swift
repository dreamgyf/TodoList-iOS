//
//  EditTodoVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//
import FMDB

class EditTodoVM {
    
    func saveData(_ model: TodoModel) {
        let db = FMDBHelper.shared.db
        let sql = "insert into todo_list (title, content, create_time, set_time, status) values (?, ?, ?, ?, ?)"
        
        if db.open() {
            db.executeUpdate(sql, withArgumentsIn: [model.title, model.content, model.createTime, 
                                                    model.setTime ?? -1, model.status == .unfinished ? 0 : 1])
            db.close()
        }
    }
}
