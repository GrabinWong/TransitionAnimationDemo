import UIKit

class LeftDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let interactionController: LeftDismissInteractiveController?

    init(interactionController: LeftDismissInteractiveController?) {
        self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromView = fromVC.view,
            let toView = toVC.view  else { return }
        
        transitionContext.containerView.addSubview(toView)
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let duration = transitionDuration(using: transitionContext)
        fromView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        toView.frame = CGRect(x: width, y: 0, width: width, height: height)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect(x: -width, y: 0, width: width, height: height)
            toView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }) { (finished) in
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
            let isCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!isCancelled)
        }
    }

}
