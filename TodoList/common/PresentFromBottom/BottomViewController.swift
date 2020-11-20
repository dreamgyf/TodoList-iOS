//
//  BottomViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class BottomViewController: UIViewController {
    
    open var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onBlankAreaClick))
        view.addGestureRecognizer(gesture)
        
        containerView = UIView()
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(doNothing))
        containerView.addGestureRecognizer(gesture2)
        containerView.isUserInteractionEnabled = true
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    @objc
    private func onBlankAreaClick() {
        dismiss()
    }
    
    @objc
    private func doNothing() {
    }
    
    func dismiss() {
        super.dismiss(animated: true, completion: nil)
    }

}
