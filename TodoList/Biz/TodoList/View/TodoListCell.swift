//
//  TodoListCell.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    public static let cellIdentifier = "TodoListCellID"
    
    private var data: TodoModel?
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    } ()
    
    private lazy var content: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    } ()
    
    private lazy var time: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(hexString: "#b0b4be")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var finishButton: UIButton = {
        let button = FlatButton(text: "完成")
        button.addTarget(self, action: #selector(onFinishClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hexString: "#b0b4be")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let leftView = UIView()
        let rightView = UIView()
        
        
        contentView.addSubview(leftView)
        contentView.addSubview(rightView)
        
        leftView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview()
            make.right.equalTo(rightView.snp.left)
        }
        
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview()
        }
        
        leftView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        leftView.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }
        
        leftView.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.top.equalTo(content.snp.bottom).offset(7)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        rightView.addSubview(finishButton)
        rightView.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(finishButton)
            make.bottom.equalToSuperview()
        }
        
        layoutIfNeeded()
        finishButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.13)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.05)
            make.centerY.equalToSuperview().offset(-(statusLabel.bounds.height + 10) / 2)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: TodoModel) {
        self.data = data
        content.isHidden = data.content.isEmpty
        
        title.text = data.title
        content.text = data.content
        
        let timestamp = TimeInterval(data.setTime)
        let date = Date(timeIntervalSince1970: timestamp)
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        time.text = fmt.string(from: date)
        
        statusLabel.text = data.status == .unfinished ? "未完成" : "已完成"
        finishButton.isHidden = data.status == .finished
    }
    
    @objc
    private func onFinishClick() {
        if let action = finishAction {
            action()
        }
    }
    
    var finishAction: (() -> Void)?

}
