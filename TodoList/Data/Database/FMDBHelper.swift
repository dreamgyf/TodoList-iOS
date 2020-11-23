//
//  FMDBHelper.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import FMDB

class FMDBHelper {
    
    private init() {}
    
    static let shared = FMDBHelper()
    
    private let dbName = "TodoList.db"
    
    lazy var db: FMDatabase = {
        let url = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dbName)
        print(url)
        return FMDatabase(url: url)
    }()
    
    func initDB() {
        createTable()
    }
    
    private func createTable() {
        let sql = """
            create table if not exists todo_list(
            id integer primary key autoincrement,
            title text,
            content text,
            create_time integer,
            set_time integer,
            status integer
            );
        """
        if db.open() {
            db.executeStatements(sql)
            db.close()
        }
    }
    
    func resultSet2TodoModel(_ res: FMResultSet) -> TodoModel {
        let id = res.int(forColumn: "id")
        let title = res.string(forColumn: "title") ?? ""
        let content = res.string(forColumn: "content") ?? ""
        let createTime = res.int(forColumn: "create_time")
        var setTime: Int32? = res.int(forColumn: "set_time")
        if setTime == -1 {
            setTime = nil
        }
        let status = res.int(forColumn: "status") == 0 ? TodoModel.Status.unfinished : TodoModel.Status.finished
        
        return TodoModel(id: id, 
                         title: title, 
                         content: content,
                         createTime: createTime,
                         setTime: setTime,
                         status: status
                         )
    }
}
