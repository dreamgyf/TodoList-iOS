//
//  TodoModel.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//
import Foundation

struct TodoModel {
    
    enum Status {
        case finished
        case unfinished
    }
    
    var id: Int64?
    var title: String
    var content: String
    var createTime: Int32
    var setTime: Int32
    var status: Status
}

extension TodoModel {
    
    private static let db = FMDBHelper.shared.db
    
    static func queryAll() -> [TodoModel] {
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
    
    static func queryByStatus(_ status: TodoModel.Status) -> [TodoModel] {
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
    
    static func queryByDate(_ date: Date, timeZone: TimeZone = TimeZone.current) -> [TodoModel] {
        let sql = "select * from todo_list where set_time >= ? and set_time < ?"
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        dayFormatter.timeZone = timeZone
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
    
    static func saveData(_ model: TodoModel) -> Int64? {
        let sql = "insert into todo_list (title, content, create_time, set_time, status) values (?, ?, ?, ?, ?)"
        
        var id: Int64?
        if db.open() {
            db.executeUpdate(sql, withArgumentsIn: [model.title, model.content, model.createTime, 
                                                    model.setTime, model.status == .unfinished ? 0 : 1])
            id = db.lastInsertRowId
            db.close()
        }
        return id
    }
    
    static func updateData(_ data: TodoModel) {
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
    
    static func deleteData(_ data: TodoModel) {
        let sql = "delete from todo_list where id = ?"
        
        if db.open() {
            db.executeUpdate(sql, withArgumentsIn: [data.id!])
            db.close()
        }
    }
}
