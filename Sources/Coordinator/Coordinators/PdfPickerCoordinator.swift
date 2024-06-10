//
//  PdfPickerCoordinator.swift
//
//
//  Created by Ahmed Yamany on 10/06/2024.
//

import UIKit

open class PdfPickerCoordinator: Coordinator {
    public let router: Router
    public let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])

    public init(router: Router, delegate: UIDocumentPickerDelegate) {
        self.router = router
        controller.allowsMultipleSelection = true
        controller.delegate = delegate
    }

    public func start() { }

    public func present(animated: Bool = true,
                         presentationStyle: UIModalPresentationStyle = .automatic,
                         transitionStyle: UIModalTransitionStyle = .coverVertical,
                         completion: @escaping () -> Void = {}) {
        router.present(
            controller,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            completion: completion
        )
    }
    
    public func push(animated: Bool = true, completion: @escaping () -> Void = {}) {
        router.push(controller, animated: animated, completion: completion)
    }
    
}
