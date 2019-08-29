//
//  SecondViewController.swift
//  pagination
//
//  Created by Levy Cristian  on 06/01/19.
//  Copyright © 2019 Levy Cristian . All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    private lazy var secondView: SecondView = {
        let view = SecondView()
        view.backgroundColor = .orange
        return view
    }()
    
    fileprivate lazy var rightEdgePanGesture : UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(rightEdge))
        gesture.edges = .right
        gesture.minimumNumberOfTouches = 1
        return gesture
    }()
    
    lazy var interactor: Interactor? = {
        let interactor = Interactor()
        return interactor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fristViewSetUp()
    }
    
    fileprivate func fristViewSetUp(){
        view.addSubview(secondView)
        secondView.fillSuperview(safeArea: false)
        secondView.setUp()
        secondView.addGestureRecognizer(rightEdgePanGesture)
        
    }
    @objc fileprivate func rightEdge(_ sender: UIScreenEdgePanGestureRecognizer){
        let translation = sender.translation(in: secondView)
        let progress = AnimatorManager.calculateProgress(translation, viewBounds: view.bounds, direction: .left)
        
        AnimatorManager.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
}
