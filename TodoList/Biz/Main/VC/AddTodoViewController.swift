//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class AddTodoViewController: BottomViewController {
    
    private lazy var titleView: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "标题"
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    private lazy var contentView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_confirm"))
        button.addTarget(self, action: #selector(onConfirmClick), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 10
        
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(18)
            make.top.equalToSuperview().offset(20)
        }
        
        let horLine = UIView()
        horLine.backgroundColor = UIColor(hexString: "#b0b4be")
        containerView.addSubview(horLine)
        horLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(1)
            make.top.equalTo(titleView.snp.bottom).offset(7)
        }
        
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(horLine.snp.bottom)
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
        }
        
        containerView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(view.snp.width).multipliedBy(0.07)
        }
    }

}

extension AddTodoViewController {
    
    @objc
    private func onConfirmClick() {
        
    }
}
