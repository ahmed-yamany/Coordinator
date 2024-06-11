
import UIKit

public protocol CameraPickerDelegate: AnyObject {
    func cameraPicker(didPick image: UIImage)
}

@MainActor
public final class CameraPickerCoordinator: NSObject {
    public let picker = UIImagePickerController()

    public let router: Router
    public let infoKey: UIImagePickerController.InfoKey
    public weak var delegate: CameraPickerDelegate?
    
    public init(router: Router, delegate: CameraPickerDelegate, infoKey: UIImagePickerController.InfoKey = .originalImage) {
        self.router = router
        self.delegate = delegate
        self.infoKey = infoKey
        super.init()
        picker.delegate = self
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

extension CameraPickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[infoKey] as? UIImage {
            guard let delegate else {
                debugPrint("Camera Picker Delegate is Nil")
                return
            }
            delegate.cameraPicker(didPick: image)
        } else {
            debugPrint("Camera Picker Didn't Pick an Image")
        }
        picker.dismiss(animated: true)
    }
}
