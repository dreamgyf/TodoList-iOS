//
//  MainViewVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

class TodoListVM {
    
    private let db = FMDBHelper.shared.db
    
    func queryAll() -> [TodoModel] {
        let sql = "select * from todo_list"
        
        if db.open() {
            if let res = db.executeQuery(sql, withArgumentsIn: []) {
                var data: [TodoModel] = []
                while res.next() {
                    data.append(FMDBHelper.shared.resultSet2TodoModel(res))
                }
                return data
            }
            db.close()
        }
        return []
    }
    
    func queryByStatus(_ status: TodoModel.Status) -> [TodoModel] {
        var sql: String
        switch status {
        case .unfinished:
            sql = "select * from todo_list where status = 0"
        case .finished:
            sql = "select * from todo_list where status = 1"
        }
        
        if db.open() {
            if let res = db.executeQuery(sql, withArgumentsIn: []) {
                var data: [TodoModel] = []
                while res.next() {
                    data.append(FMDBHelper.shared.resultSet2TodoModel(res))
                }
                return data
            }
            db.close()
        }
        return []
    }
}
