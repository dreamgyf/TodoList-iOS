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
        return FMDatabase(url: url)
    }()
    
    func initDB() {
        createTable()
    }
    
    func createTable() {
        let sql = """
            create table if not exists todo_list(
            id integer primary key autoincrement,
            title text,
            content text
            );
        """
        
        db.executeStatements(sql)
    }
}
