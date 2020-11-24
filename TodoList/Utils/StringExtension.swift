//
//  StringExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/24.
//

import Foundation

extension String {
    
    func fillZero(count: Int) -> String {
        var res = self
        while res.count < count {
            res = "0\(res)"
        }
        return res
    }
}
