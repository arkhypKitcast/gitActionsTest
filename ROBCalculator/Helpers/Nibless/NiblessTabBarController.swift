//
//  NiblessTabBarController.swift
//  Kreafeuer_UIKit
//
//  Created by arkhyp on 07.12.2021.
//

import Foundation
import UIKit

open class NiblessTabBarController: UITabBarController {

  // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
