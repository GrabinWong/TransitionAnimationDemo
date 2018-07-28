import UIKit

class RightPresentInterationController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    private weak var toViewController: UIViewController!
    private var shaking = false
    
    init(viewController: UIViewController, toViewController: UIViewController) {
        super.init()
        self.viewController = viewController
        self.toViewController = toViewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = .right
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        if !shaking {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            shaking = true
        }
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        var progress = -translation.x / UIScreen.main.bounds.size.width
        print(translation.x)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.present(toViewController, animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
            shaking = false
        default:
            break
        }
        
    }
}
