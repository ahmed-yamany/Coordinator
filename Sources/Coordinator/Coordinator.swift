import UIKit


open class Coordinator: NSObject {
    private(set) var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    private(set) var currentIndex: Int = -1

    public var viewControllers: [CoordinatorViewController.Type]  = []
    
    
    public override init() {
        super.init()

    }
    
    open func push(userInfo: [String: Any]? = nil) {
        increaseCurrentIndex()
        
        let currentCoordinator = self.viewControllers[currentIndex].init()
        currentCoordinator.coordinator = self
        currentCoordinator.userInfo = userInfo

        switch currentCoordinator.coordinationType {
        case .navigation:
            navigationController.pushViewController(currentCoordinator, animated: true)
        case .segue:
            if currentIndex <= 0{
                fatalError("you should not present segue at first ViewController at coordinator array")
            }
            guard let lastVC = navigationController.viewControllers.last as? CoordinatorViewController else {return}
            lastVC.present(currentCoordinator, animated: true)
        }
        
    }
    
    open func pop() {
        decreaseCurrentIndex()
    }
    
    private func increaseCurrentIndex() {
         self.currentIndex = currentIndex == viewControllers.count - 1 ? currentIndex : currentIndex + 1
     }
     
     private func decreaseCurrentIndex() {
         self.currentIndex = currentIndex == 0 ? 0 : currentIndex - 1
     }

}
