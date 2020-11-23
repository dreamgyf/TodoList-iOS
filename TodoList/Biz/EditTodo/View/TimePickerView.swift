//
//  TimePickerView.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import UIKit

class TimePickerView: UIView {
    
    private lazy var picker: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_confirm"), multipliedBy: 1.1)
        button.addTarget(self, action: #selector(onConfirmClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_cancel"), multipliedBy: 0.7)
        button.addTarget(self, action: #selector(onCancelClick), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        
        addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(picker.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.right.equalTo(confirmButton.snp.left).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(picker.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
    }
    
    func getTime() -> TimeInterval {
        return -1
    }
    
    var confirmAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
}

extension TimePickerView {
    
    @objc
    private func onConfirmClick() {
        if let action = confirmAction {
            action()
        }
    }
    
    @objc
    private func onCancelClick() {
        if let action = cancelAction {
            action()
        }
    }
}

extension TimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "test"
    }
}

extension TimePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
}
