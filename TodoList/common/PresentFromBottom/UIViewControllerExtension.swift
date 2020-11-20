//
//  UIViewControllerExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

extension UIViewController: UIViewControllerTransitioningDelegate {
    
    func presentFromBottom(_ vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentFromBottomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
