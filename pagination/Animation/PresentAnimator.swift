//
//  PresentAnimator.swift
//  pagination
//
//  Created by Levy Cristian  on 06/01/19.
//  Copyright © 2019 Levy Cristian . All rights reserved.
//

import UIKit

class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        
        // replace main view with snapshot
        if let snapshotFrom = fromVC.view.snapshotView(afterScreenUpdates: false),
            let snapshotTo = toVC.view.snapshotView(afterScreenUpdates: true){
            
            
            snapshotFrom.tag = AnimatorManager.snapshotNumber0
            snapshotFrom.isUserInteractionEnabled = false
            snapshotTo.tag = AnimatorManager.snapshotNumber1
            snapshotTo.isUserInteractionEnabled = false
            
            
            containerView.insertSubview(snapshotTo, aboveSubview: fromVC.view)
            toVC.view.isHidden = true
            snapshotTo.center.x -= toVC.view.bounds.width
            containerView.insertSubview(snapshotFrom, aboveSubview: snapshotTo)
            fromVC.view.isHidden = true
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    snapshotFrom.center.x += UIScreen.main.bounds.width * AnimatorManager.animatorWidth
                    snapshotTo.center.x += UIScreen.main.bounds.width
            },
                completion: { _ in
                    toVC.view.isHidden = false
                    fromVC.view.isHidden = false
                    snapshotTo.removeFromSuperview()
                    snapshotFrom.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            )
        }
    }
}
