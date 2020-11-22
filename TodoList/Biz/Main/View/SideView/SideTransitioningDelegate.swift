//
//  SideTransitioningDelegate.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/22.
//

import UIKit

class SideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = SidePresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideTransionPush()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideTransionPop()
    }
}
