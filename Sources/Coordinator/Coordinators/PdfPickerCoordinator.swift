//
//  PdfPickerCoordinator.swift
//
//
//  Created by Ahmed Yamany on 10/06/2024.
//

import UIKit

public class PdfPickerCoordinator: Coordinator {
    public let router: Router
    public let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
    
    public init(router: Router, delegate: UIDocumentPickerDelegate) {
        self.router = router
        picker.allowsMultipleSelection = true
        picker.delegate = delegate
    }
    
    public func start() { 
        self.present()
    }
    
    public func present(animated: Bool = true,
                        presentationStyle: UIModalPresentationStyle = .automatic,
                        transitionStyle: UIModalTransitionStyle = .coverVertical,
                        completion: @escaping () -> Void = {}) {
        router.present(
            picker,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            completion: completion
        )
    }
    
    public func push(animated: Bool = true, completion: @escaping () -> Void = {}) {
        router.push(picker, animated: animated, completion: completion)
    }
    
}
