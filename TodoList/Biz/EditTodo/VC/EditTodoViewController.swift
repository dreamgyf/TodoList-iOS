//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class EditTodoViewController: BottomViewController {
    
    private static let CacheKey = "EditTodoViewController.AddCache"
    
    private enum Mode {
        case add
        case edit
    }
    
    private let mode: Mode
    
    private let vm = EditTodoVM()
    
    private let data: TodoModel?
    
    private var setTime: TimeInterval? {
        didSet {
            refreshTimeView()
        }
    }
    
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
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self
        return textView
    }()
    
    private lazy var contentPlaceholderView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        if #available(iOS 13.0, *) {
            label.textColor = UIColor.placeholderText
        } else {
            label.textColor = UIColor(red: 60, green: 60, blue: 67, alpha: 0.3)
        }
        label.text = "描述"
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_confirm"), multipliedBy: 1.1)
        button.addTarget(self, action: #selector(onConfirmClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearbutton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_clear"), multipliedBy: 0.7)
        button.addTarget(self, action: #selector(onClearClick), for: .touchUpInside)
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
    
    private lazy var timeView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeColor
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var timePickerView: TimePickerView = {
        let view = TimePickerView()
        view.confirmAction = {
            self.setTime = view.getTime().timeIntervalSince1970
            self.resumeFromTimePicker()
        }
        view.cancelAction = {
            self.resumeFromTimePicker()
        }
        view.clearAction = {
            self.setTime = nil
            self.resumeFromTimePicker()
        }
        return view
    } ()
    
    init() {
        self.mode = .add
        self.data = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    init(data: TodoModel) {
        self.mode = .edit
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        preLoadData()
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
        
        contentView.addSubview(contentPlaceholderView)
        contentPlaceholderView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(18)
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
        
        containerView.addSubview(clearbutton)
        clearbutton.snp.makeConstraints { (make) in
            make.right.equalTo(confirmButton.snp.left).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(view.snp.width).multipliedBy(0.07)
        }
        
        containerView.addSubview(alarmButton)
        alarmButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.07)
            make.height.equalTo(view.snp.width).multipliedBy(0.07)
        }
        
        containerView.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.left.equalTo(alarmButton.snp.right).offset(4)
            make.centerY.equalTo(alarmButton)
        }
        
        view.addSubview(timePickerView)
        timePickerView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }
    }
    
    private func preLoadData() {
        if mode == .add, let model = MemoryCache.get(key: EditTodoViewController.CacheKey) as? TodoModel {
            // 如果是新建模式，从cache里读取上一次未新建时留存的内容（如果有）
            titleView.text = model.title
            contentView.text = model.content
            if model.setTime != -1 {
                setTime = TimeInterval(model.setTime)
                timePickerView.selectDate(Date(timeIntervalSince1970: TimeInterval(model.setTime)))
            }
        } else if mode == .edit, let data = self.data {
            titleView.text = data.title
            contentView.text = data.content
            setTime = TimeInterval(data.setTime)
            timePickerView.selectDate(Date(timeIntervalSince1970: TimeInterval(data.setTime)))
        }
        self.textViewDidChange(contentView)
    }
    
    private func refreshTimeView() {
        if let time = self.setTime {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            timeView.text = fmt.string(from: Date(timeIntervalSince1970: TimeInterval(time)))
        } else {
            timeView.text = nil
        }
    }
    
    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func showTimePicker() {
        containerView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }
        
        timePickerView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func resumeFromTimePicker() {
        containerView.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        
        timePickerView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private enum OriginOfDismiss {
        case confirm
        case clickOuter
    }
    
    private var dismissBy: OriginOfDismiss = .clickOuter
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        // 如果是新建模式，并且没有点击确定按钮，将这次内容保存到cache中
        if mode == .add, dismissBy == .clickOuter {
            let model = TodoModel(id: nil, 
                                  title: titleView.text!, 
                                  content: contentView.text,
                                  createTime: Int32(Date().timeIntervalSince1970),
                                  setTime: Int32(setTime ?? -1),
                                  status: .unfinished)
            MemoryCache.put(key: EditTodoViewController.CacheKey, value: model)
        } else if dismissBy == .confirm {
            let _ = MemoryCache.remove(key: EditTodoViewController.CacheKey)
        }
        super.dismiss(animated: flag, completion: completion)
    }

}

extension EditTodoViewController {
    
    @objc
    private func onConfirmClick() {
        if titleView.text == nil || titleView.text!.isEmpty {
            showAlert(title: "请输入标题", message: nil, preferredStyle: .alert)
            return
        }
        
        let id = data?.id
        let now = Date().timeIntervalSince1970
        let model = TodoModel(id: id, 
                              title: titleView.text!, 
                              content: contentView.text,
                              createTime: Int32(now),
                              setTime: Int32(setTime ?? now),
                              status: .unfinished)
        
        if mode == .add {
            vm.saveData(model)
        } else if mode == .edit {
            vm.updateData(model)
        }
        dismissBy = .confirm
        dismiss()
        NotificationCenter.default.post(name: .refreshTodoList, object: self)
    }
    
    @objc
    private func onClearClick() {
        titleView.text = nil
        contentView.text = nil
        setTime = nil
    }
    
    @objc
    private func onAlarmClick() {
        showTimePicker()
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

extension EditTodoViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        contentPlaceholderView.isHidden = !textView.text.isEmpty
    }
}
