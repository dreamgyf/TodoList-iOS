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
    
    let id: Int32?
    let title: String
    let content: String
    let createTime: Int32
    let setTime: Int32?
    let status: Status
}
