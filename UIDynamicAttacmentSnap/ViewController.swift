//
//  ViewController.swift
//  UIDynamicAttacmentSnap
//
//  Created by Art Karma on 5/2/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var squareView = UIView()
    private var squareViewAnchor = UIView() // якорь
    private var anchorView = UIView()
    private var animator: UIDynamicAnimator?
    private var attachmentBehavior: UIAttachmentBehavior?
    private var panorama: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGestureRecognizer()
        createSquareSmallView()
        createAnchorView()
        createAnimationAndBehavior()
    }
    
    private func createSquareSmallView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        squareView.backgroundColor = .green
        squareView.center = self.view.center
        squareViewAnchor.frame = CGRect(x: 60, y: 0, width: 20, height: 20)
        squareViewAnchor.backgroundColor = .brown
        squareView.addSubview(squareViewAnchor)
        self.view.addSubview(squareView)
    }
    
    private func createAnchorView() {
        anchorView.frame = CGRect(x: 120, y: 120, width: 20, height: 20)
        anchorView.backgroundColor = .red
        self.view.addSubview(anchorView)
    }
    
    private func createGestureRecognizer() {
        panorama = UIPanGestureRecognizer(target: self, action: #selector(handledPan(param:)))
        self.view.addGestureRecognizer(panorama!)
    }
    
    @objc func handledPan(param: UIPanGestureRecognizer) {
        let tapPoint = param.location(in: self.view)
        print(tapPoint)
        attachmentBehavior?.anchorPoint = tapPoint // поведению передаем точку где будем тягать
        anchorView.center = tapPoint
    }
    
    private func createAnimationAndBehavior() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        animator?.addBehavior(collision)
    }
}

