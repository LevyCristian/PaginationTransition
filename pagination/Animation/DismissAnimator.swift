//
//  DismissAnimator.swift
//  pagination
//
//  Created by Levy Cristian  on 06/01/19.
//  Copyright © 2019 Levy Cristian . All rights reserved.
//

import UIKit

class DismissMenuAnimator : NSObject {
}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        if let snapshotTo = toVC.view.snapshotView(afterScreenUpdates: true),
            let snapshotFrom = fromVC.view.snapshotView(afterScreenUpdates: false){
            
            containerView.insertSubview(snapshotTo, aboveSubview: fromVC.view)
            toVC.view.isHidden = true
            snapshotTo.center.x += toVC.view.bounds.width
            containerView.insertSubview(snapshotFrom, aboveSubview: snapshotTo)
            fromVC.view.isHidden = true
            
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    snapshotTo.center.x -= UIScreen.main.bounds.width * AnimatorManager.animatorWidth
                    snapshotFrom.center.x -= UIScreen.main.bounds.width
            },
                completion: { _ in
                    let didTransitionComplete = !transitionContext.transitionWasCancelled
                    if didTransitionComplete {
                        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                        toVC.view.isHidden = false
                        fromVC.view.isHidden = false
                        snapshotTo.removeFromSuperview()
                        snapshotFrom.removeFromSuperview()
                        
                    }
                    transitionContext.completeTransition(didTransitionComplete)
            })
        }
        
    }
}
