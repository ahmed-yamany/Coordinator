//
//  Created by Ahmed Yamany on 19/06/2024.
//

import SwiftUI

@MainActor
open class UIHostingRouter: ObservableObject {
    private let router: Router
    public let navigationController: UINavigationController = UINavigationController()
    
    public init() {
        router = Router(navigationController: navigationController)
    }
    
    open func setNavigationBarHidden(_ hidden: Bool, animated: Bool = true) {
        router.setNavigationBarHidden(hidden, animated: animated)
    }
    
    open func present(
        _ view: some View,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle = .automatic,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        let viewController = UIHostingController(rootView: view)
        router.present(
            viewController,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            completion: completion
        )
    }
    
    open func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        router.dismiss(animated: animated, completion: completion)
    }
    
    open func push(_ view: some View, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewController = UIHostingController(rootView: view)
        router.push(viewController, animated: animated, completion: completion)
    }
    
    open func replaceLast(with view: some View, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewController = UIHostingController(rootView: view)
        router.replaceLast(with: viewController, animated: animated, completion: completion)
    }
    
    open func replaceFirst(with view: some View, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewController = UIHostingController(rootView: view)
        router.replaceFirst(with: viewController, animated: animated, completion: completion)
    }
    
    open func insert(_ view: some View, at index: Int, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewController = UIHostingController(rootView: view)
        router.insert(viewController, at: index, animated: animated, completion: completion)
    }
    
    open func reset(completion: @escaping () -> Void = {}) {
        router.reset(completion: completion)
    }
    
    open func popToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        router.popToRoot(animated: animated, completion: completion)
    }
    
    open func navigationTitle(_ title: String) {
        router.navigationTitle(title)
    }
    
    open func setViews(_ views: [some View], animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewControllers = views.map { UIHostingController(rootView: $0) }
        router.setViewControllers(viewControllers, animated: animated, completion: completion)
    }
    
    open func setView(_ view: some View, animated: Bool = true, completion: @escaping () -> Void = {}) {
        setViews([view], animated: animated, completion: completion)
    }
    
    open func present(
        _ view: some View,
        detents: [UISheetPresentationController.Detent],
        selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .large,
        grabberVisible: Bool = false,
        cornerRadius: CGFloat? = nil,
        scrollingExpandsWhenScrolledToEdge: Bool = true,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        let viewController = UIHostingController(rootView: view)
        router.present(
            viewController,
            detents: detents,
            selectedDetentIdentifier: selectedDetentIdentifier,
            grabberVisible: grabberVisible,
            cornerRadius: cornerRadius,
            scrollingExpandsWhenScrolledToEdge: scrollingExpandsWhenScrolledToEdge,
            largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
            animated: animated,
            completion: completion
        )
    }
    
    open func sheetSelectedDetent( _ identifier: UISheetPresentationController.Detent.Identifier, animated: Bool = false) {
        router.sheetSelectedDetent(identifier, animated: animated)
    }
    
    open func sheetDetents( _ detents: [UISheetPresentationController.Detent], animated: Bool = false) {
        router.sheetDetents(detents, animated: animated)
    }
    
    open func sheetPrefersGrabberVisible(_ visible: Bool = false) {
        router.sheetPrefersGrabberVisible(visible)
    }
    
    open func sheetCornerRadius( _ cornerRadius: CGFloat, animated: Bool = false) {
        router.sheetCornerRadius(cornerRadius, animated: animated)
    }
    
    open func sheetPrefersScrollingExpandsWhenScrolledToEdge(_ preferred: Bool = true) {
        router.sheetPrefersScrollingExpandsWhenScrolledToEdge(preferred)
    }
    
    open func sheetLargestUndimmedDetentIdentifier(_ identifier: UISheetPresentationController.Detent.Identifier? = nil) {
        router.sheetLargestUndimmedDetentIdentifier(identifier)
    }
}
