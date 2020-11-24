//
//  MainViewVM.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//
import Foundation

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
    
    func queryByDate(_ date: Date) -> [TodoModel] {
        let sql = "select * from todo_list where set_time >= ? and set_time < ?"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        let targetDayStr = dayFormatter.string(from: date)
        let targetDay = dayFormatter.date(from: targetDayStr)
        
        let targetDayTimestamp = Int(targetDay!.timeIntervalSince1970)
        let nextDayTimestamp = targetDayTimestamp + 34 * 60 * 60
        
        if db.open() {
            if let res = db.executeQuery(sql, withArgumentsIn: [targetDayTimestamp, nextDayTimestamp]) {
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
    
    func deleteData(_ data: TodoModel) {
        let sql = "delete from todo_list where id = ?"
        
        if db.open() {
            db.executeUpdate(sql, withArgumentsIn: [data.id!])
            db.close()
        }
    }
    
    func updateData(_ data: TodoModel) {
        let sql = "update todo_list set title = ?, content = ?, create_time = ?, set_time = ?, status = ? where id = ?"
        
        if db.open() {
            db.executeUpdate(sql, withArgumentsIn: [data.title, 
                                                    data.content, 
                                                    data.createTime, 
                                                    data.setTime, 
                                                    data.status == .unfinished ? 0 : 1, 
                                                    data.id!])
            db.close()
        }
    }
}
