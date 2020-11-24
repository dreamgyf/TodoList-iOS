//
//  TimePickerView.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import UIKit

class TimePickerView: UIView {
    
    private var earliestYear: String
    
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
    
    private lazy var clearbutton: UIButton = {
        let button = FlatButton(image: UIImage(named: "icon_clear"), multipliedBy: 0.7)
        button.addTarget(self, action: #selector(onClearClick), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        earliestYear = Date.thisYear
        super.init(frame: frame)
        
        setupUI()
        selectDate(Date())
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
        
        addSubview(clearbutton)
        clearbutton.snp.makeConstraints { (make) in
            make.right.equalTo(cancelButton.snp.left).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(picker.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
    }
    
    func selectDate(_ date: Date) {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd-HH-mm"
        let fullDateStr = fmt.string(from: date)
        let dateArray = fullDateStr.split(separator: "-")
        let year = dateArray[0]
        let month = dateArray[1]
        let day = dateArray[2]
        let hour = dateArray[3]
        let min = dateArray[4]
        
        if Int(year)! < Int(earliestYear)! {
            earliestYear = String(year)
            picker.reloadComponent(0)
        }
        
        picker.selectRow(Int(month)! - 1, inComponent: 1, animated: false)
        picker.selectRow(Int(day)! - 1, inComponent: 2, animated: false)
        picker.selectRow(Int(hour)!, inComponent: 3, animated: false)
        picker.selectRow(Int(min)!, inComponent: 4, animated: false)
    }
    
    func getTime() -> Date {
        let yearStr = self.pickerView(picker, titleForRow: picker.selectedRow(inComponent: 0), forComponent: 0)!
        let monthStr = self.pickerView(picker, titleForRow: picker.selectedRow(inComponent: 1), forComponent: 1)!
        let dayStr = self.pickerView(picker, titleForRow: picker.selectedRow(inComponent: 2), forComponent: 2)!
        let hourStr = self.pickerView(picker, titleForRow: picker.selectedRow(inComponent: 3), forComponent: 3)!
        let minStr = self.pickerView(picker, titleForRow: picker.selectedRow(inComponent: 4), forComponent: 4)!
        
        let dateStr = "\(yearStr)-\(monthStr)-\(dayStr) \(hourStr):\(minStr)"
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        return fmt.date(from: dateStr)!
    }
    
    var confirmAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    var clearAction: (() -> Void)?
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
    
    @objc
    private func onClearClick() {
        if let action = clearAction {
            action()
        }
    }
}

extension TimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(Int(earliestYear)! + row)"
        case 1:
            return "\(row + 1)"
        case 2:
            return "\(row + 1)"
        case 3:
            return "\(row)".fillZero(count: 2)
        case 4:
            return "\(row)".fillZero(count: 2)
        default:
            return ""
        }
    }
}

extension TimePickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return Int(Date.thisYear)! - Int(earliestYear)! + 3
        case 1:
            return 12
        case 2:
            let yearStr = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
            let monthStr = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
            return Date.getDays(year: Int(yearStr)!, month: Int(monthStr)!)
        case 3:
            return 24
        case 4:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            pickerView.reloadComponent(2)
        }
    }
    
}
