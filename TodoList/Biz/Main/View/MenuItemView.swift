//
//  MenuItemView.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import UIKit

class MenuItemView: UIView {
    
    var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupAction() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doAction)))
    }

    var action: (() -> Void)?
    
    @objc
    private func doAction() {
        if let action = action {
            action()
        }
    }
}
