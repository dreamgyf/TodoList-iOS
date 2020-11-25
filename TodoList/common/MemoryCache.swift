//
//  MemoryCache.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/25.
//

import Foundation

class MemoryCache {
    
    private static var dictionary = [String: Any]()
    
    static func put(key: String, value: Any) {
        dictionary[key] = value
    }
    
    static func get(key: String) -> Any? {
        return dictionary[key]
    }
    
    static func remove(key: String) -> Any? {
        return dictionary.removeValue(forKey: key)
    }
}
