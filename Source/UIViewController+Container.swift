import UIKit

public extension UIViewController {
    /**
     Adds the controller to the view hierarchy safely.
     - parameter controller: The controller to be added
     - parameter frame: The frame for the added controller, if the frame is not provided or is `nil` then the parent controller's frame will be used
     */
    public func addController(controller: UIViewController, frame: CGRect? = nil) {
        self.addChildViewController(controller)

        if let frame = frame {
            controller.view.frame = frame
        } else {
            controller.view.translatesAutoresizingMaskIntoConstraints = false
        }

        self.view.addSubview(controller.view)

        if frame == nil {
            let views = ["view": controller.view as AnyObject]

            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[view]|", options: [], metrics: nil, views: views))

            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: views))
        }

        controller.didMoveToParentViewController(self)
    }

    /**
     Removes the controller from the view hierarchy safely.
     - parameter controller: The controller to be removed
     */
    public func removeController(controller: UIViewController) {
        controller.willMoveToParentViewController(nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
}
