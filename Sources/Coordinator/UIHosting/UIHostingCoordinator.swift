//
//  Created by Ahmed Yamany on 19/06/2024.
//
#if os(iOS)
import SwiftUI

@MainActor
public protocol UIHostingCoordinator: View {
    var router: UIHostingRouter { get }
    
    func start()
}
#endif
