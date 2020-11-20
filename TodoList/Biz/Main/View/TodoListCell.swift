//
//  TodoListCell.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

import UIKit

class TodoListCell: UITableViewCell {
    
    public static let cellIdentifier = "TodoListCellID"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    } ()
    
    private lazy var content: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(7)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
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
        title.text = data.title
        content.text = data.content
    }

}
