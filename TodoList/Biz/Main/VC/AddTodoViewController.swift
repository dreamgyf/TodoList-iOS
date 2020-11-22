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
        handleKeyboard()
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
    
    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension AddTodoViewController {
    
    @objc
    private func onConfirmClick() {
        
    }
    
    @objc
    private func keyboardWillShow(_ notifaction: Notification) {
        let userInfo = notifaction.userInfo! as Dictionary
        let rect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = rect.height
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        
        UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
            self.view.center = CGPoint.init(x: self.view.center.x, y: self.view.bounds.height / 2 - height)
        })
    }
    
    @objc
    private func keyboardWillHide(_ notifaction: Notification) {
        let userInfo = notifaction.userInfo! as Dictionary
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        
        UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
            self.view.center = CGPoint.init(x: self.view.center.x, y: self.view.bounds.height / 2)
        })
    }
    
}
