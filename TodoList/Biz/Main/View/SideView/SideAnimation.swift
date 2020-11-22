//
//  SideAnimation.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/22.
//

import UIKit

class SideTransionPush: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        let container = transitionContext.containerView
        container.addSubview(toVC.view)
        
        let width = UIScreen.main.bounds.width * 0.4
        toVC.view.frame = CGRect(x: 0 - width, y: 0, width: width, height: UIScreen.main.bounds.height)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC.view.frame = CGRect(x: 0, y: 0, width: width, height: UIScreen.main.bounds.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class SideTransionPop: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        let width = UIScreen.main.bounds.width * 0.4
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = CGRect(x: 0 - width, y: 0, width: width, height: UIScreen.main.bounds.height)
        }, completion: { _ in
            fromVC.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
