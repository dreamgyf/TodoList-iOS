//
//  UIViewControllerExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/20.
//

import UIKit

class BottomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentFromBottomPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
