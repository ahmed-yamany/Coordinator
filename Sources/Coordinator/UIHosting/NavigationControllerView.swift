//
//  Created by Ahmed Yamany on 19/06/2024.
//

import SwiftUI

private struct NavigationControllerViewRepresentable: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UINavigationController
    
    let router: UIHostingRouter
    
    public init(router: UIHostingRouter) {
        self.router = router
    }
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        return router.navigationController
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}

public struct NavigationControllerView: View {
    let router: UIHostingRouter
    
    public init(router: UIHostingRouter) {
        self.router = router
    }
    
    public var body: some View {
        NavigationControllerViewRepresentable(router: router)
            .ignoresSafeArea()
    }
}
