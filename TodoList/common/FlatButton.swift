//
//  FlatButton.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class FlatButton: UIButton {
    
    private enum Style {
        case image
        case text
    }
    
    private let style: Style
    
    private var image: UIImage?
    
    private var multiplied: CGFloat?
    
    private var text: String?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        return label
    }()

    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = image
        return iconView
    } ()
    
    init(image: UIImage?, multipliedBy multiplied: CGFloat = 1) {
        self.style = .image
        self.image = image
        self.multiplied = multiplied
        super.init(frame: .zero)
        setupUI()
    }
    
    init(text: String) {
        self.style = .text
        self.text = text
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.themeColor
        
        if style == .image {
            addSubview(iconView)
            iconView.snp.makeConstraints { (make) in
                make.width.height.equalTo(self.snp.height).multipliedBy(self.multiplied!)
                make.center.equalToSuperview()
            }
        } else if style == .text {
            addSubview(label)
            label.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

}
