import UIKit

private struct TransitionConfig {
    static let time: TimeInterval = 0.5
}

final class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TransitionConfig.time
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewController(forKey: .to),
           let fromViewController = transitionContext.viewController(forKey: .from) {
            
            let finalFrame = transitionContext.finalFrame(for: toViewController)
            let container = transitionContext.containerView
            
            toViewController.view.alpha = 0
            
            container.addSubview(toViewController.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController.view.alpha = 1
            }) { isFinish in
                transitionContext.completeTransition(isFinish && !transitionContext.transitionWasCancelled)
            }
        }
    }
}
