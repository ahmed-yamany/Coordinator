//
//  Created by Ahmed Yamany on 26/04/2024.
#if os(iOS)
import UIKit

@MainActor
open class Router {
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    open func setNavigationBarHidden(_ hidden: Bool, animated: Bool = true) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
    
    open func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle = .automatic,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    open func present(
        _ viewController: UIViewController,
        transitioningDelegate: UIViewControllerTransitioningDelegate,
        completion: @escaping () -> Void = {}
    ) {
        viewController.transitioningDelegate = transitioningDelegate
        present(viewController, animated: true, presentationStyle: .overFullScreen)
    }
    
    open func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated, completion: completion)
        } else {
            navigationController.popViewController(animated: animated)
            completion()
        }
    }
    
    open func push(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        navigationController.pushViewController(viewController, animated: animated)
        completion()
    }
    
    open func replaceLast(with viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        var viewControllers = navigationController.viewControllers
        if viewControllers.isEmpty {
            viewControllers = [viewController]
        } else {
            viewControllers[viewControllers.count - 1] = viewController
        }
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }
    
    open func replaceFirst(with viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        var viewControllers = navigationController.viewControllers
        viewControllers[0] = viewController
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }
    
    open func insert(_ viewController: UIViewController, at index: Int, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        var viewControllers = navigationController.viewControllers
        viewControllers.insert(viewController, at: index)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }
    
    open func reset(completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        navigationController.viewControllers.removeAll()
    }
    
    open func popToViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popToViewController(viewController, animated: animated)
        completion()
    }
    
    open func popToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popToRootViewController(animated: animated)
        completion()
    }
    
    open func navigationTitle(_ title: String) {
        navigationController.visibleViewController?.navigationItem.title = title
    }
    
    open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: false)
        navigationController.setViewControllers(viewControllers, animated: animated)
        completion()
    }
    
    open func setViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        self.setViewControllers([viewController], animated: animated, completion: completion)
    }
    
    open func present(
        _ viewController: UIViewController,
        detents: [UISheetPresentationController.Detent],
        selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .large,
        grabberVisible: Bool = false,
        cornerRadius: CGFloat? = nil,
        scrollingExpandsWhenScrolledToEdge: Bool = true,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
            sheet.selectedDetentIdentifier = selectedDetentIdentifier
            sheet.prefersGrabberVisible = grabberVisible
            sheet.preferredCornerRadius = cornerRadius
            sheet.prefersScrollingExpandsWhenScrolledToEdge = scrollingExpandsWhenScrolledToEdge
            sheet.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        }
        present(viewController, animated: animated, completion: completion)
    }
    
    private func sheetPresentationController() -> UISheetPresentationController? {
        guard let viewController = navigationController.presentedViewController,
              let sheet = viewController.sheetPresentationController else {
            return nil
        }
        return sheet
    }
    
    open func sheetSelectedDetent( _ identifier: UISheetPresentationController.Detent.Identifier, animated: Bool = false) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        
        if animated {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = identifier
            }
        } else {
            sheet.selectedDetentIdentifier = identifier
        }
    }
    
    open func sheetDetents( _ detents: [UISheetPresentationController.Detent], animated: Bool = false) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        if animated {
            sheet.animateChanges {
                sheet.detents = detents
            }
        } else {
            sheet.detents = detents
        }
    }
    
    open func sheetPrefersGrabberVisible(_ visible: Bool = false) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        
        sheet.prefersGrabberVisible = visible
    }
    
    open func sheetCornerRadius( _ cornerRadius: CGFloat, animated: Bool = false) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        
        if animated {
            sheet.animateChanges {
                sheet.preferredCornerRadius = cornerRadius
            }
        } else {
            sheet.preferredCornerRadius = cornerRadius
        }
    }
    
    open func sheetPrefersScrollingExpandsWhenScrolledToEdge(_ preferred: Bool = true) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        
        sheet.prefersScrollingExpandsWhenScrolledToEdge = preferred
    }
    
    open func sheetLargestUndimmedDetentIdentifier(_ identifier: UISheetPresentationController.Detent.Identifier? = nil) {
        guard let sheet = sheetPresentationController() else {
            return
        }
        
        sheet.largestUndimmedDetentIdentifier = identifier
    }
}
#endif
