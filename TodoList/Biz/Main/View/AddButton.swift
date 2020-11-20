//
//  AddButton.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

import UIKit

class AddButton: UIButton {
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "icon_add")
        return iconView
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.themeColor
        
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview().multipliedBy(0.6)
            make.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
}
