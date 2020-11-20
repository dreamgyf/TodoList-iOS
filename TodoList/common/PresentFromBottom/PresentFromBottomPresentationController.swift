//
//  AddTodoViewController.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class PresentFromBottomPresentationController: UIPresentationController {
    
    var viewController: UIViewController

    private lazy var blackView: UIView = {
        let view = UIView(frame: self.containerView?.bounds ?? .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        viewController = presentedViewController
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 1
        })
    }

    override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    @objc
    private func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
