//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class EditTodoViewController: BottomViewController {
    
    private let vm = EditTodoVM()
    
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
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onAlarmClick), for: .touchUpInside)
        
        let iconView = UIImageView()
        iconView.image = UIImage(named: "icon_alarm")
        
        button.backgroundColor = UIColor(white: 0, alpha: 0)
        button.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
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
        
        containerView.addSubview(alarmButton)
        alarmButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1 + 20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.07)
            make.height.equalTo(view.snp.width).multipliedBy(0.07)
        }
    }
    
    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension EditTodoViewController {
    
    @objc
    private func onConfirmClick() {
        if titleView.text == nil || titleView.text == "" {
            titleView.placeholder = "请输入标题"
            return
        }
        
        let model = TodoModel(id: nil, 
                              title: titleView.text!, 
                              content: contentView.text,
                              createTime: Int32(Date().timeIntervalSince1970),
                              setTime: Int32(Date().timeIntervalSince1970),
                              status: .unfinished)
        vm.saveData(model)
        dismiss()
        NotificationCenter.default.post(name: .refreshTodoList, object: self)
    }
    
    @objc
    private func onAlarmClick() {
        
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
