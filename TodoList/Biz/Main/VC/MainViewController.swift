//
//  ViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/19.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var sideDelegate = SideTransitioningDelegate()
    private lazy var bottomDelegate = BottomTransitioningDelegate()
    
    private lazy var navButton: UIView = {
        let screenWidth = UIScreen.main.bounds.width
        let navBarHeight = self.navigationController!.navigationBar.frame.size.height
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.07, height: navBarHeight * 0.5))
        button.setImage(UIImage(named: "icon_menu"), for: .normal)
        button.addTarget(self, action: #selector(onMenuClick), for: .touchUpInside)
        
        //解决iOS 11以上，图片会拉宽leftBarButtonItem，并且直接设置UIButton的frame无效的问题
        let view = UIView(frame: button.frame)
        view.addSubview(button)
        return view
    }()
    
    private lazy var MenuVC: UINavigationController = {
        let vc = MenuViewController()
        vc.action = { style in
            self.todoListVC.style = style
        }
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private lazy var todoListVC: TodoListViewController = {
        let vc = TodoListViewController(frame: self.view.frame)
        return vc
    }()
    
    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(self.onAddButtonClick), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.themeColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navButton)
        
        view.addSubview(todoListVC.view)
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(6)
            make.height.equalTo(view.snp.width).dividedBy(6)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
}

//actions
extension MainViewController {
    @objc
    private func onMenuClick() {
        presentSide(MenuVC)
    }
    
    @objc
    private func onAddButtonClick() {
        presentBottom(EditTodoViewController())
    }
}

extension MainViewController {
    
    func presentSide(_ vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = sideDelegate
        present(vc, animated: true, completion: nil)
    }
    
    func presentBottom(_ vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = bottomDelegate
        present(vc, animated: true, completion: nil)
    }
}

