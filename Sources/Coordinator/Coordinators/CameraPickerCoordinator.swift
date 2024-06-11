
import UIKit

@MainActor
public final class CameraPickerCoordinator: NSObject {
    public typealias Delegate =  UIImagePickerControllerDelegate & UINavigationControllerDelegate

    public let picker = UIImagePickerController()
    public let router: Router
    
    public init(router: Router, delegate: Delegate) {
        self.router = router
        super.init()
        picker.delegate = delegate
        picker.sourceType = .camera
    }
    
    public func start(completion: @escaping () -> Void = {}) {
        router.present(picker, completion: completion)
    }
    
    public var allowsEditing: Bool {
        get { picker.allowsEditing }
        set { picker.allowsEditing = newValue }
    }
    
    public var cameraFlashMode: UIImagePickerController.CameraFlashMode {
        get { picker.cameraFlashMode }
        set { picker.cameraFlashMode = newValue }
    }
    
    public var cameraDevice: UIImagePickerController.CameraDevice {
        get { picker.cameraDevice }
        set { picker.cameraDevice = newValue }
    }
    
    public var showsCameraControls: Bool {
        get { picker.showsCameraControls }
        set { picker.showsCameraControls = newValue }
    }
}
