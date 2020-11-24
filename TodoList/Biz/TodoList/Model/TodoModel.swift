//
//  TodoModel.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

struct TodoModel {
    
    enum Status {
        case finished
        case unfinished
    }
    
    var id: Int32?
    var title: String
    var content: String
    var createTime: Int32
    var setTime: Int32
    var status: Status
}
