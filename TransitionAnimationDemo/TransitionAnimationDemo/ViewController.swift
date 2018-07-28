//
//  ViewController.swift
//  TransitionAnimationDemo
//
//  Created by grwong on 2018/7/24.
//  Copyright © 2018年 grwong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rightPresentInteractionController: RightPresentInterationController?
    
    var leftPresentInterationController: LeftPresentInterationController?
    
    lazy var rightVC = RightViewController()
    
    lazy var leftVC = LeftViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        rightVC.transitioningDelegate = self
        leftVC.transitioningDelegate = self
        rightPresentInteractionController = RightPresentInterationController(viewController: self, toViewController: rightVC)
        leftPresentInterationController = LeftPresentInterationController(viewController: self, toViewController: leftVC)
    }

    @IBAction func leftBtnAction(_ sender: UIButton) {
        present(leftVC, animated: true, completion: nil)
    }
    
    @IBAction func rightBtnAction(_ sender: UIButton) {
        present(rightVC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let revealVC = source as? ViewController  else { return nil }
        if let _ = presented as? RightViewController {
            return RightPresentAnimationController(interactionController: revealVC.rightPresentInteractionController)
        } else if let _ = presented as? LeftViewController {
            return LeftPresentAnimationController(interactionController: revealVC.leftPresentInterationController)
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let revealVC = dismissed as? RightViewController {
            return RightDismissAnimationController(interactionController: revealVC.rightInteractionController)
        } else if let revealVC = dismissed as? LeftViewController {
            return LeftDismissAnimationController(interactionController: revealVC.leftInteractionController)
        }
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let animator = animator as? RightDismissAnimationController,
            let interationController = animator.interactionController,
            interationController.interactionInProgress {
            return interationController
        } else if let animator = animator as? LeftDismissAnimationController,
            let interationController = animator.interactionController,
            interationController.interactionInProgress {
            return interationController
        }
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let animator = animator as? RightPresentAnimationController,
            let interationController = animator.interactionController,
            interationController.interactionInProgress {
            return interationController
        } else if let animator = animator as? LeftPresentAnimationController,
            let interationController = animator.interactionController,
            interationController.interactionInProgress {
            return interationController
        }
        return nil
    }
}

