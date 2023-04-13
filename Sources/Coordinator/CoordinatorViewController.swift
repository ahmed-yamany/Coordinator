//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 13/04/2023.
//

import UIKit

public enum CoordinationTypes {
    case navigation
    case segue
}

open class CoordinatorViewController: UIViewController{
 
    // the coordinator is responsible for managing navigation between view controllers.
    public var coordinator: Coordinator?
    public var coordinationType: CoordinationTypes = .navigation

    public var userInfo: [String: Any]? = nil
    
    // used to notify the coordinator when the view controller is popped from the navigation stack.
    open override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.coordinator?.pop()
        }
    }
}
