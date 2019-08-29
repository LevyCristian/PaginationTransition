//
//  FristViewController.swift
//  pagination
//
//  Created by Levy Cristian  on 06/01/19.
//  Copyright © 2019 Levy Cristian . All rights reserved.
//

import UIKit

class FristViewController: UIViewController {
    
    fileprivate lazy var fristView: FristView = {
        let view = FristView()
        view.backgroundColor = .red
        return view
    }()
    
    fileprivate lazy var interactor: Interactor = {
        let interactor = Interactor()
        return interactor
    }()
    
    fileprivate lazy var leftEdgePanGesture : UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftEdge))
        gesture.edges = .left
        gesture.minimumNumberOfTouches = 1
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fristViewSetUp()
    }
    
    fileprivate func fristViewSetUp(){
        view.addSubview(fristView)
        fristView.fillSuperview(safeArea: false)
        fristView.setUp()
        fristView.addGestureRecognizer(leftEdgePanGesture)
        
    }
    

    fileprivate func navigationBarSetup() {
        
        let exploreBarButtonItem = UIBarButtonItem(title: "second", style: .plain, target: self, action: #selector(secondButtonClicked))
        navigationItem.leftBarButtonItem = exploreBarButtonItem
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
    }
    
    @objc fileprivate func secondButtonClicked() {
        let destinationController = SecondViewController()
        destinationController.transitioningDelegate = self
        present(destinationController, animated: true, completion: nil)
        //navigationController?.pushViewController(destinationController, animated: true)
    }
    
    @objc fileprivate func leftEdge(_ sender: UIScreenEdgePanGestureRecognizer){
        let translation = sender.translation(in: fristView)
        
        let progress = AnimatorManager.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        AnimatorManager.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                let destinationController = SecondViewController()
                destinationController.transitioningDelegate = self
                destinationController.interactor = self.interactor
                present(destinationController, animated: true, completion: nil)
        }
    }

}

extension FristViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
