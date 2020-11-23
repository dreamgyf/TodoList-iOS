//
//  NSNotificationExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import Foundation

extension NSNotification.Name {
    
    public static var refreshTodoList: NSNotification.Name {
        get {
            return NSNotification.Name("com.dreamgyf.TodoList-iOS.TodoList.Refresh")
        }
    }
    
}
