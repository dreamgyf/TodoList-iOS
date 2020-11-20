//
//  FlatButton.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class FlatButton: UIButton {
    
    private let image: UIImage?

    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = image
        return iconView
    } ()
    
    init(image: UIImage?) {
        self.image = image
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.themeColor
        
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.snp.height)
            make.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

}
