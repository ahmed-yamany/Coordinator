//
//  PHPickerCoordinator.swift
//
//
//  Created by Ahmed Yamany on 10/06/2024.
//
#if os(iOS)
import UIKit
import PhotosUI

public class PHPickerCoordinator: Coordinator {
    public let router: Router
    public private(set) var picker: PHPickerViewController!
    
    public init(router: Router, delegate: PHPickerViewControllerDelegate, configuration: PHPickerConfiguration) {
        self.router = router
        picker = PHPickerViewController(configuration: configuration)
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
#endif
